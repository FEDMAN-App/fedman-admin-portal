import 'package:fedman_admin_app/core/navigation/app_routes.dart';
import 'package:fedman_admin_app/core/navigation/route_name.dart';
import 'package:fedman_admin_app/core/utils/responsive_helper.dart';
import 'package:fedman_admin_app/core/utils/debouncer.dart';
import 'package:fedman_admin_app/core/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';

import '../../../core/common_widgets/custom_buttons.dart';
import '../../../core/common_widgets/custom_text_form_field.dart';
import '../../../core/common_widgets/responsive_row_column.dart';
import '../../../core/common_widgets/screen_body.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../data/enums/federation_types.dart' as ft;
import '../../../core/extensions/space.dart';
import '../../../core/theme/app_text_styles.dart';
import '../data/models/federation_model.dart';
import '../data/repositories/federation_repo.dart';
import '../bloc/federations_bloc.dart';
import '../widgets/federation_filter_dropdown.dart';
import '../widgets/federation_list_item.dart';
import '../widgets/no_federations_widget.dart';
import '../widgets/pagination_widget.dart';

class FederationsScreen extends StatelessWidget {
  const FederationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FederationsBloc(
        federationRepo: GetIt.instance<FederationRepo>(),
      )..add(GetFederationsRequested()),
      child: const _FederationsScreenContent(),
    );
  }
}

class _FederationsScreenContent extends StatefulWidget {
  const _FederationsScreenContent();

  @override
  State<_FederationsScreenContent> createState() => _FederationsScreenContentState();
}

class _FederationsScreenContentState extends State<_FederationsScreenContent> {
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<String?> _selectedLocationNotifier = ValueNotifier(null);
  final ValueNotifier<String?> _selectedTypeNotifier = ValueNotifier(null);
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier(1);
  final ValueNotifier<int> _totalPagesNotifier = ValueNotifier(8);
  late final Debouncer _searchDebouncer;
  
  late final List<String> _types;

  @override
  void initState() {
    super.initState();
    _searchDebouncer = Debouncer(delay: const Duration(milliseconds: 500));
    _types = ft.FederationType.dropdownValues;
    
    // Add listeners for search and filters
    _searchController.addListener(_onSearchChanged);
    _selectedLocationNotifier.addListener(_onFiltersChanged);
    _selectedTypeNotifier.addListener(_onFiltersChanged);
    _currentPageNotifier.addListener(_onPageChanged);
  }

  void _onSearchChanged() {
    _searchDebouncer.call(() {
      _triggerSearch();
    });
  }

  void _onFiltersChanged() {
    _currentPageNotifier.value = 1; // Reset to first page when filters change
    _triggerSearch();
  }

  void _onPageChanged() {
    _triggerSearch();
  }

  void _triggerSearch() {
    // Convert display name to API value using enum
    String? federationType = ft.FederationType.getApiValueFromDisplayName(_selectedTypeNotifier.value);
    
    String? country = _selectedLocationNotifier.value;
    if (country == 'All Locations') {
      country = null;
    }
    
    context.read<FederationsBloc>().add(
      GetFederationsRequested(
        page: _currentPageNotifier.value,
        search: _searchController.text.isEmpty ? null : _searchController.text,
        federationType: federationType,
        country: country,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FederationsBloc, FederationsState>(
      listener: (context, state) {
        if (state is FederationsError) {
          SnackbarUtils.showCustomToast(
            context,
            state.message,
            isError: true,
          );
        } else if (state is FederationsSuccess) {
          // Update total pages when we get successful response
          _totalPagesNotifier.value = state.totalPages;
        }
      },
      child: ScreenBody(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Federations',
                          style: AppTextStyles.subHeading1,
                        ),
                        4.verticalSpace,
                        Text(
                          'Manage all registered federations and their administrators',
                          style: AppTextStyles.body2.copyWith(
                            color: AppColors.greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.horizontalSpace,
                  CustomButton(
                    title: 'Add Federation',
                    icon: Icon(
                      Icons.add,
                      color: AppColors.baseWhiteColor,
                      size: 20,
                    ),
                    onTap: _addFederation,
                  ),
                ],
              ),

              32.verticalSpace,
              ResponsiveRowColumn(
                layout: ResponsiveLayout.mobileTabletColumn,
                spacing: 8,
                rowCrossAxisAlignment: CrossAxisAlignment.start,
                columnCrossAxisAlignment: CrossAxisAlignment.stretch,
                excludeSpacingFromExpanded: true,
                wrapInExpanded: true,
                flexValues: const [2, 1, 1],
                children: [
                  CustomTextFormField(
                    prefixIcon: Icon(Icons.search, color: AppColors.greyColor),
                    controller: _searchController,
                    hintText: 'Search by name or country...',
                  ),
                  ValueListenableBuilder<String?>(
                    valueListenable: _selectedLocationNotifier,
                    builder: (context, selectedLocation, child) {
                      return FederationFilterDropdown(
                        title: 'All Locations',
                        selectedValue: selectedLocation,
                        items: AppConstants.countries,
                        prefixIcon: Icons.location_on,
                        onChanged: (value) {
                          _selectedLocationNotifier.value = value;
                        },
                      );
                    },
                  ),
                  ValueListenableBuilder<String?>(
                    valueListenable: _selectedTypeNotifier,
                    builder: (context, selectedType, child) {
                      return FederationFilterDropdown(
                        title: 'Select type',
                        selectedValue: selectedType,
                        items: _types,
                        onChanged: (value) {
                          _selectedTypeNotifier.value = value;
                        },
                      );
                    },
                  ),
                ],
              ),
              24.verticalSpace,
              BlocBuilder<FederationsBloc, FederationsState>(
                builder: (context, state) {
                  if (state is FederationsLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(50.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is FederationsSuccess && state.federations.isNotEmpty) {
                    return _buildFederationsContent(state.federations);
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: NoFederationsWidget(
                        onAddFederation: _addFederation,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFederationsContent(List<FederationModel> federations) {
    return Column(
      children: [

        Container(
          decoration: BoxDecoration(
            color: AppColors.baseWhiteColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.greyColor.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.bgColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Federation',
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.tertiaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Type',
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.tertiaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ResponsiveHelper.isMobile(context)
                        ? const SizedBox()
                        : Expanded(
                            flex: 2,
                            child: Text(
                              'Location',
                              style: AppTextStyles.body2.copyWith(
                                color: AppColors.tertiaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                    const SizedBox(width: 56),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(10),
                itemCount: federations.length,
                itemBuilder: (context, index) {
                  return FederationListItem(
                    federation: federations[index],
                    onTap: () => _viewFederation(federations[index]),
                    onView: () => _viewFederation(federations[index]),
                    onEdit: () => _editFederation(federations[index]),
                    onDeactivate: () => _deactivateFederation(federations[index]),
                  );
                },
              ),
            ],
          ),
        ),
        24.verticalSpace,
        ValueListenableBuilder<int>(
          valueListenable: _currentPageNotifier,
          builder: (context, currentPage, child) {
            return ValueListenableBuilder<int>(
              valueListenable: _totalPagesNotifier,
              builder: (context, totalPages, child) {
                return PaginationWidget(
                  visiblePageCount: ResponsiveHelper.isMobile(context) ? 1 : 5,
                  currentPage: currentPage,
                  totalPages: totalPages,
                  onPrevious: () {
                    if (currentPage > 1) {
                      _currentPageNotifier.value = currentPage - 1;
                    }
                  },
                  onNext: () {
                    if (currentPage < totalPages) {
                      _currentPageNotifier.value = currentPage + 1;
                    }
                  },
                  onPageSelected: (page) {
                    _currentPageNotifier.value = page;
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  void _addFederation() {
    context.go(RouteName.addFederation);
  }

  void _viewFederation(FederationModel federation) {
    context.go('/federations/${federation.id}');
  }

  void _editFederation(FederationModel federation) {

    //context.go('${RouteName.addFederation}/${federation.id}');
    context.go('/addFederation/${federation.id}');
  }

  void _deactivateFederation(FederationModel federation) {
    print('Deactivate federation: ${federation.name}');
  }

  @override
  void dispose() {
    _searchController.dispose();
    _selectedLocationNotifier.dispose();
    _selectedTypeNotifier.dispose();
    _currentPageNotifier.dispose();
    _totalPagesNotifier.dispose();
    _searchDebouncer.dispose();
    super.dispose();
  }
}