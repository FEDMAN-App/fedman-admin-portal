import 'package:fedman_admin_app/core/constants/app_constants.dart';
import 'package:fedman_admin_app/core/utils/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/common_widgets/custom_buttons.dart';
import '../../../core/common_widgets/custom_cached_image_widget.dart';
import '../../../core/common_widgets/custom_text_form_field.dart';
import '../../../core/common_widgets/retry_widget.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/space.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../bloc/add_federation_bloc/add_federation_bloc.dart';
import '../data/models/federation_model.dart';

class AddMemberFederationWidget extends StatefulWidget {
  final VoidCallback? onCancel;
  final Function(List<String>)? onAddSelected;
  final Function(List<int> selectedFedIds)? onSelect;
  final String title;
  final String? federationType; // Federation type filter for API calls

  const AddMemberFederationWidget({
    super.key,
    this.onCancel,
    this.onAddSelected,
    this.onSelect,
    required this.title,
    this.federationType,
  });

  @override
  State<AddMemberFederationWidget> createState() => _AddMemberFederationWidgetState();
}

class _AddMemberFederationWidgetState extends State<AddMemberFederationWidget> {
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<List<int>> _selectedMembersNotifier = ValueNotifier([]);
  final ScrollController _scrollController = ScrollController();
  late final Debouncer _searchDebouncer;
  int _currentPage = 1;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _searchDebouncer = Debouncer(delay: const Duration(milliseconds: 500));
    _searchController.addListener(_onSearchChanged);
    _scrollController.addListener(_onScroll);
  }

  void _onSearchChanged() {
    _searchDebouncer.call(() {
      _triggerSearch();
    });
  }

  void _triggerSearch() {
    _currentPage = 1;
    context.read<AddFederationBloc>().add(
      GetFederationsRequested(
        page: 1,
        search: _searchController.text.isEmpty ? null : _searchController.text,
        federationType: widget.federationType,
      ),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreFederations();
    }
  }

  void _loadMoreFederations() {
    final currentState = context.read<AddFederationBloc>().state;
    if (currentState is FederationsSuccess && 
        !currentState.isLoadingMore &&
        currentState.page < currentState.totalPages) {
      
      _currentPage = currentState.page + 1;
      context.read<AddFederationBloc>().add(
        LoadMoreFederationsRequested(
          page: _currentPage,
          search: _searchController.text.isEmpty ? null : _searchController.text,
          federationType: widget.federationType,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 500,minHeight: 0),
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.neutral50,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        border: Border.all(color: AppColors.neutral200)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [

          Text(
            widget.title,
            style: AppTextStyles.subHeading2,
          ),
          16.verticalSpace,

          SizedBox(
            height: 57,
            child: CustomTextFormField(
              controller: _searchController,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              hintText: 'Search federations...',
              prefixIcon: Icon(Icons.search, color: AppColors.greyColor),
            ),
          ),
          24.verticalSpace,

          Flexible(
            child: BlocConsumer<AddFederationBloc, AddFederationState>(
              buildWhen: (previous, current) => current is FederationsLoading || current is FederationsSuccess || current is FederationsError,
              listener: (context, state) {
                if (state is FederationsError) {
                  SnackbarUtils.showCustomToast(
                    context,
                    state.message,
                    isError: true,
                  );
                }
              },
              builder: (context, state) {
                if (state is FederationsLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is FederationsSuccess) {
                  return _buildFederationsList(state.federations, state.isLoadingMore);
                } else if (state is FederationsError) {
                  return Center(
                    child: RetryWidget(
                      message: 'Failed to load federations',
                      onTapOnRetry: () => _triggerSearch(),
                    ),
                  );
                }

                return _buildFederationsList([], false);
              },
            ),
          ),


        ],
      ),
    );
  }

  Widget _buildFederationsList(List<FederationModel> federations, bool isLoadingMore) {
    return ValueListenableBuilder<List<int>>(
      valueListenable: _selectedMembersNotifier,
      builder: (context, selectedMembers, _) {
        return ListView.separated(
          controller: _scrollController,

          padding: EdgeInsets.symmetric(horizontal: 1,vertical: 0),
          itemCount: federations.length + (isLoadingMore ? 1 : 0),
          separatorBuilder: (_, index) => 12.verticalSpace,
          itemBuilder: (context, index) {
            if (index >= federations.length) {
              return Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
            
            final federation = federations[index];
            final isSelected = selectedMembers.contains(federation.id);

            return GestureDetector(
              onTap: () {
                final updatedList = List<int>.from(selectedMembers);
                if (isSelected) {
                  updatedList.remove(federation.id);
                } else {
                  updatedList.add(federation.id!);
                }
                _selectedMembersNotifier.value = updatedList;
                // Call onSelect callback with updated list
                widget.onSelect?.call(updatedList);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary50 : AppColors.baseWhiteColor,
                  border: Border.all(
                    width: 0.5,
                    color: isSelected ? AppColors.primaryColor : AppColors.neutral100,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: federation.fedLogo != null
                          ? CustomCachedImageWidget(
                              url: federation.fedLogo!,
                            )
                          : SvgPicture.asset(
                              AppAssets.federationIcon,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                    ),
                    16.horizontalSpace,
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            federation.name,
                            style: AppTextStyles.body1.copyWith(
                              color: AppColors.baseBlackColor,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                          4.verticalSpace,
                          Text(
                            '${federation.type.displayName} • ${federation.country}',
                            style: AppTextStyles.body2.copyWith(
                              color: AppColors.neutral600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Icon(
                        Icons.check_circle,
                        color: AppColors.primaryColor,
                        size: 24,
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _selectedMembersNotifier.dispose();
    _scrollController.dispose();
    _searchDebouncer.dispose();
    super.dispose();
  }
}