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
  late final Debouncer _searchDebouncer;

  @override
  void initState() {
    super.initState();
    _searchDebouncer = Debouncer(delay: const Duration(milliseconds: 500));
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    _searchDebouncer.call(() {
      _triggerSearch();
    });
  }

  void _triggerSearch() {
    context.read<AddFederationBloc>().add(
      GetFederationsRequested(
        page: 1,
        search: _searchController.text.isEmpty ? null : _searchController.text,
        federationType: widget.federationType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 500,minHeight: 0),
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.neutral50,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
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

          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 57,
                  child: CustomTextFormField(
                    controller: _searchController,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    hintText: 'Search federations...',
                    prefixIcon: Icon(Icons.search, color: AppColors.greyColor),
                  ),
                ),
              ),
              // 24.horizontalSpace,
              // ValueListenableBuilder<List<int>>(
              //   valueListenable: _selectedMembersNotifier,
              //   builder: (context, selectedMembers, _) {
              //     return CustomButton(
              //       isLeadingIcon: true,
              //       icon: Padding(
              //         padding:  EdgeInsets.only(right: 10.0),
              //         child: SvgPicture.asset(AppAssets.federationIcon,colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),width: 20,height: 20,),
              //       ),
              //       title: 'Add Selected (${selectedMembers.length})',
              //       isSecondaryBtn: true,
              //       onTap: selectedMembers.isNotEmpty
              //           ? () => widget.onSelect?.call(selectedMembers)
              //           : null,
              //     );
              //   },
              // ),
            ],
          ),
          24.verticalSpace,

          Expanded(
            child: BlocConsumer<AddFederationBloc, AddFederationState>(
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
                  return _buildFederationsList(state.federations);
                } else if (state is FederationsError) {
                  return Center(
                    child: RetryWidget(
                      message: 'Failed to load federations',
                      onTapOnRetry: () => _triggerSearch(),
                    ),
                  );
                }
                
                return _buildFederationsList([]);
              },
            ),
          ),


        ],
      ),
    );
  }

  Widget _buildFederationsList(List<FederationModel> federations) {
    return ValueListenableBuilder<List<int>>(
      valueListenable: _selectedMembersNotifier,
      builder: (context, selectedMembers, _) {
        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 1),
          itemCount: federations.length,
          separatorBuilder: (_, index) => 12.verticalSpace,
          itemBuilder: (context, index) {
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
    _searchDebouncer.dispose();
    super.dispose();
  }
}