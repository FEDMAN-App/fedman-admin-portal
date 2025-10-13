import 'package:cached_network_image/cached_network_image.dart';
import 'package:fedman_admin_app/core/constants/app_constants.dart';
import 'package:fedman_admin_app/core/utils/snackbar_utils.dart';
import 'package:fedman_admin_app/presentation/federations/data/models/federation_model.dart';
import 'package:fedman_admin_app/presentation/federations/widgets/federation_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../core/common_widgets/custom_buttons.dart';
import '../../../core/common_widgets/custom_text_form_field.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/space.dart';
import '../../../core/theme/app_text_styles.dart';
import '../bloc/add_federation_bloc/add_federation_bloc.dart';
import '../bloc/federation_member_bloc/federation_member_bloc.dart';
import '../data/enums/federation_types.dart';
import '../data/repositories/federation_repo.dart';

class AddFederationDialog extends StatefulWidget {
  final Function(List<FederationModel>)? onFederationsSelected;
  final int? federationId;
  final String? federationType;
  final List<int>? currentMemberIds;

  const AddFederationDialog({
    super.key, 
    this.onFederationsSelected,
    this.federationId,
    this.federationType,
    this.currentMemberIds,
  });



  @override
  State<AddFederationDialog> createState() => _AddFederationDialogState();
}

class _AddFederationDialogState extends State<AddFederationDialog> {
  final ValueNotifier<String> _searchQueryNotifier = ValueNotifier('');
  final ValueNotifier<List<FederationModel>> _selectedFederationsNotifier =
      ValueNotifier([]);
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  String? _currentFilterType;
late AddFederationBloc addFederationBloc;

  @override
  void initState() {
    super.initState();
    addFederationBloc=AddFederationBloc(federationRepo: GetIt.I.get());
    _searchController.addListener(() {
      _searchQueryNotifier.value = _searchController.text;
    });
    _scrollController.addListener(_onScroll);
    _fetchFederations();
  }
  
  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreFederations();
    }
  }
  
  void _loadMoreFederations() {
    final currentState = addFederationBloc.state;
    if (currentState is FederationsSuccess && 
        !currentState.isLoadingMore &&
        currentState.page < currentState.totalPages) {
      
      addFederationBloc.add(
        LoadMoreFederationsRequested(
          page: currentState.page + 1,
          search: _searchController.text.isEmpty ? null : _searchController.text,
          federationType: _currentFilterType!,
        ),
      );
    }
  }

  void _fetchFederations() {
    if (widget.federationType == null) return;
    
    String? filterType;
    switch (widget.federationType!.toLowerCase()) {
      case 'international':
        filterType = FederationType.national.apiValue;
        break;
      case 'continental':
        filterType = FederationType.national.apiValue;
        break;
      case 'national':
        filterType = FederationType.international.apiValue;
        break;
      case 'regional':
        filterType = FederationType.national.apiValue;
        break;
    }
    
    if (filterType != null) {
      _currentFilterType = filterType;
      
      addFederationBloc.add(
        GetFederationsRequested(
          federationType: filterType,
          page: 1,
          search: _searchController.text.isEmpty ? null : _searchController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FederationMemberBloc(
            federationRepo: GetIt.instance<FederationRepo>(),
          ),
        ),
        BlocProvider(
          create: (context) => addFederationBloc
        ),
      ],
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 600,
          constraints: const BoxConstraints(maxHeight: 600),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              _buildSearchField(),
              Expanded(child: _buildFederationsList()),
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    // Determine header text based on federation type
    String headerText = 'Add Federation';
    if (widget.federationType != null) {
      final isInternationalOrContinental = 
          widget.federationType!.toLowerCase() == 'international' ||
          widget.federationType!.toLowerCase() == 'continental';
      headerText = isInternationalOrContinental 
          ? 'Add Federation Members' 
          : 'Add Affiliations';
    }
    
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(headerText, style: AppTextStyles.subHeading1),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, size: 20, color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextFormField(
        controller: _searchController,
        hintText: 'Search by name of Federation...',
        prefixIcon: Icon(Icons.search, color: AppColors.neutral600, size: 20),

      ),
    );
  }

  Widget _buildFederationsList() {
    return BlocBuilder<AddFederationBloc, AddFederationState>(
      builder: (context, state) {
        if (state is FederationsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FederationsSuccess) {
          return ValueListenableBuilder<String>(
            valueListenable: _searchQueryNotifier,
            builder: (context, searchQuery, child) {
              // Filter out existing members first, then apply search filter
              final availableFederations = state.federations.where((federation) {
                // Exclude federations that are already members
                if (widget.currentMemberIds != null && widget.currentMemberIds!.contains(federation.id)) {
                  return false;
                }
                
                // Apply search filter
                final name = federation.name ?? '';
                return name.toLowerCase().contains(searchQuery.toLowerCase());
              }).toList();

              if (availableFederations.isEmpty) {
                return Center(
                  child: Text(
                    'No federations found',
                    style: AppTextStyles.body1.copyWith(
                      color: AppColors.neutral600,
                    ),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: ListView.separated(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: availableFederations.length + (state.isLoadingMore ? 1 : 0),
                  separatorBuilder: (context, index) => 16.verticalSpace,
                  itemBuilder: (context, index) {
                    if (index >= availableFederations.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    final federation = availableFederations[index];
                    return _buildFederationItem(federation);
                  },
                ),
              );
            },
          );
        } else if (state is FederationsError) {
          return Center(
            child: Text(
              state.message,
              style: AppTextStyles.body1.copyWith(
                color: AppColors.negativeColor,
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildFederationItem(FederationModel federation) {
    return ValueListenableBuilder<List<FederationModel>>(
      valueListenable: _selectedFederationsNotifier,
      builder: (context, selectedFederations, child) {
        final isSelected = selectedFederations.any((f) => f.id == federation.id);

        return GestureDetector(
          onTap: () {
            final currentSelected = List<FederationModel>.from(
              _selectedFederationsNotifier.value,
            );
            if (isSelected) {
              currentSelected.removeWhere((f) => f.id == federation.id);
            } else {
              currentSelected.add(federation);
            }
            _selectedFederationsNotifier.value = currentSelected;
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryColor.withOpacity(0.1)
                  : AppColors.baseWhiteColor,
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.neutral200,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                FederationLogoWidget(federationId: federation.id!,size: 48,),
                16.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        federation.name!,
                        style: AppTextStyles.subHeading2.copyWith(
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.baseBlackColor,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                      4.verticalSpace,
                      Text(
                        federation.type.displayName,
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
  }

  Widget _buildActions() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 48,
              child: CustomButton(
                title: 'Cancel',
                isSecondaryBtn: true,
                onTap: () => context.pop(false),
              ),
            ),
          ),
          16.horizontalSpace,
          Expanded(
            child: BlocConsumer<FederationMemberBloc, FederationMemberState>(
              listener: (context, state) {
                if (state is MembersAdded) {
                  context.pop(true);
                 SnackbarUtils.showCustomToast(context, state.message);
                } else if (state is MembersAddedError) {
                  SnackbarUtils.showCustomToast(context, state.message);
                }
              },
              builder: (context, state) {
                return ValueListenableBuilder<List<FederationModel>>(
                  valueListenable: _selectedFederationsNotifier,
                  builder: (context, selectedFederations, child) {
                    final isLoading = state is MembersAdding;
                    return SizedBox(
                      height: 48,
                      child: CustomButton(
                        title: 'Add Federations (${selectedFederations.length})',
                        isLoading: isLoading,
                        onTap: selectedFederations.isNotEmpty && !isLoading
                            ? () {
                                if (widget.federationId != null && widget.federationType != null) {
                                  final memberIds = selectedFederations.map((fed) => fed.id!).toList();
                                  context.read<FederationMemberBloc>().add(
                                    AddFederationMembers(
                                      federationId: widget.federationId!,
                                      federationType: widget.federationType!,
                                      memberIds: memberIds,
                                    ),
                                  );
                                } else {
                                  widget.onFederationsSelected?.call(selectedFederations);
                                }
                              }
                            : null,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchQueryNotifier.dispose();
    _selectedFederationsNotifier.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}