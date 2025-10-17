import 'package:easy_localization/easy_localization.dart';
import 'package:fedman_admin_app/core/navigation/app_routes.dart';
import 'package:fedman_admin_app/core/navigation/route_name.dart';
import 'package:fedman_admin_app/presentation/disciplines/data/enums/sport_types.dart';
import 'package:fedman_admin_app/presentation/disciplines/data/enums/ranking_type.dart';
import 'package:fedman_admin_app/presentation/disciplines/data/enums/status_type.dart';
import 'package:fedman_admin_app/presentation/disciplines/screens/widgets/discipline_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fedman_admin_app/core/common_widgets/screen_body.dart';
import 'package:fedman_admin_app/core/common_widgets/custom_buttons.dart';
import 'package:fedman_admin_app/core/common_widgets/custom_text_form_field.dart';
import 'package:fedman_admin_app/core/common_widgets/responsive_row_column.dart';
import 'package:fedman_admin_app/core/common_widgets/retry_widget.dart';
import 'package:fedman_admin_app/core/extensions/space.dart';
import 'package:fedman_admin_app/core/theme/app_text_styles.dart';
import 'package:fedman_admin_app/core/constants/app_colors.dart';
import 'package:fedman_admin_app/core/utils/responsive_helper.dart';
import 'package:fedman_admin_app/core/utils/snackbar_utils.dart';
import 'package:go_router/go_router.dart';

import '../data/models/discipline_model.dart';
import '../blocs/descipline_bloc/discipline_bloc.dart';
import '../data/repositories/discipline_repo.dart';
import '../../federations/widgets/pagination_widget.dart';
import 'package:get_it/get_it.dart';

class DisciplinesScreen extends StatelessWidget {
  const DisciplinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DisciplineBloc(
        disciplineRepo: GetIt.I<DisciplineRepo>(),
      ),
      child: const _DisciplinesScreenView(),
    );
  }
}

class _DisciplinesScreenView extends StatefulWidget {
  const _DisciplinesScreenView();

  @override
  State<_DisciplinesScreenView> createState() => _DisciplinesScreenViewState();
}

class _DisciplinesScreenViewState extends State<_DisciplinesScreenView> {
  final ValueNotifier<String> _searchNotifier = ValueNotifier('');
  final ValueNotifier<String> _selectedTypeNotifier = ValueNotifier('All Types');
  final ValueNotifier<String> _selectedStatusNotifier = ValueNotifier('Active');
  final ValueNotifier<String> _selectedRankingNotifier = ValueNotifier('All Ranking');
  final TextEditingController _searchController = TextEditingController();
  
  // Pagination state
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier(1);

  @override
  void initState() {
    super.initState();
    _loadDisciplines();
    
    // Listen to filter changes
    _searchNotifier.addListener(_onFiltersChanged);
    _selectedTypeNotifier.addListener(_onFiltersChanged);
    _selectedStatusNotifier.addListener(_onFiltersChanged);
    _selectedRankingNotifier.addListener(_onFiltersChanged);
    _currentPageNotifier.addListener(_onFiltersChanged);
  }

  void _loadDisciplines() {
    context.read<DisciplineBloc>().add(
      GetDisciplinesRequested(
        page: _currentPageNotifier.value,
        search: _searchNotifier.value.isEmpty ? null : _searchNotifier.value,
        status: DisciplineStatus.getApiValueFromDisplayName(_selectedStatusNotifier.value),
        sportType: SportType.getApiValueFromDisplayName(_selectedTypeNotifier.value),
        hasRanking: RankingType.getApiValueFromDisplayName(_selectedRankingNotifier.value),
      ),
    );
  }

  void _onFiltersChanged() {
    _loadDisciplines();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBody(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocConsumer<DisciplineBloc, DisciplineState>(
          listener: (context, state) {
            if (state is DisciplinesError) {
              SnackbarUtils.showCustomToast(
                context,
                state.message,
                isError: true,
              );
            } else if (state is DisciplineDeleteSuccess) {
              SnackbarUtils.showCustomToast(
                context,
                state.message,
                isError: false,
              );
              _loadDisciplines();
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                _buildHeader(),
                24.verticalSpace,
                _buildFiltersAndSearch(),
                24.verticalSpace,
                _buildDisciplinesGrid(state),
                16.verticalSpace,
                _buildPagination(state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return ResponsiveRowColumn(
      layout: ResponsiveLayout.mobileColumn,
      spacing: 16,
      rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
      columnCrossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Disciplines',
              style: AppTextStyles.subHeading1,
            ),
            4.verticalSpace,
            Text(
              'Manage competition disciplines and their levels',
              style: AppTextStyles.body2.copyWith(
                color: AppColors.greyColor,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 42,
          child: CustomButton(
            centerAlign: ResponsiveHelper.isMobile(context),
            isLeadingIcon: true,
            icon: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Icon(Icons.add,size: 28,color: AppColors.baseWhiteColor,),
            ),

            title: 'Add Discipline',
            onTap: () {
              context.go(RouteName.createDiscipline);
            },
            buttonColor: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildFiltersAndSearch() {
    return ResponsiveRowColumn(
      layout: ResponsiveLayout.mobileColumn,
      spacing: 16,
      wrapInExpanded: true,
      flexValues: [3,1,1],
      children: [
        CustomTextFormField(
          prefixIcon: Icon(Icons.search, color: AppColors.greyColor),
          controller: _searchController,
          hintText: 'Search by name or country...',
          onChange: (value) {
            _searchNotifier.value = value ?? '';
          },
        ),
        ValueListenableBuilder<String>(
          valueListenable: _selectedTypeNotifier,
          builder: (context, selectedType, child) {
            return DropdownButtonFormField<String>(
              value: selectedType,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.neutral200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.neutral200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.neutral200),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                filled: true,
                fillColor: AppColors.baseWhiteColor,
              ),
              items: SportType.dropdownValues
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(
                          type,
                          style: AppTextStyles.body2.copyWith(
                            color: AppColors.baseBlackColor,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  _selectedTypeNotifier.value = value;
                }
              },
            );
          },
        ),
        // ValueListenableBuilder<String>(
        //   valueListenable: _selectedStatusNotifier,
        //   builder: (context, selectedStatus, child) {
        //     return DropdownButtonFormField<String>(
        //       value: selectedStatus,
        //       decoration: InputDecoration(
        //         border: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(8),
        //           borderSide: BorderSide(color: AppColors.neutral200),
        //         ),
        //         enabledBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(8),
        //           borderSide: BorderSide(color: AppColors.neutral200),
        //         ),
        //         focusedBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(8),
        //           borderSide: BorderSide(color: AppColors.neutral200),
        //         ),
        //         contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        //         filled: true,
        //         fillColor: AppColors.baseWhiteColor,
        //       ),
        //       items: StatusType.dropdownValues
        //           .map((status) => DropdownMenuItem(
        //                 value: status,
        //                 child: Text(
        //                   status,
        //                   style: AppTextStyles.body2.copyWith(
        //                     color: AppColors.baseBlackColor,
        //                   ),
        //                 ),
        //               ))
        //           .toList(),
        //       onChanged: (value) {
        //         if (value != null) {
        //           _selectedStatusNotifier.value = value;
        //         }
        //       },
        //     );
        //   },
        // ),
        ValueListenableBuilder<String>(
          valueListenable: _selectedRankingNotifier,
          builder: (context, selectedRanking, child) {
            return DropdownButtonFormField<String>(
              value: selectedRanking,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.neutral200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.neutral200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.neutral200),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                filled: true,
                fillColor: AppColors.baseWhiteColor,
              ),
              items: RankingType.dropdownValues
                  .map((ranking) => DropdownMenuItem(
                        value: ranking,
                        child: Text(
                          ranking,
                          style: AppTextStyles.body2.copyWith(
                            color: AppColors.baseBlackColor,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  _selectedRankingNotifier.value = value;
                }
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildDisciplinesGrid(DisciplineState state) {
    if (state is DisciplinesLoading) {
      return const Center(
        heightFactor: 5,
        child: CircularProgressIndicator(),
      );
    }

    if (state is DisciplinesLoaded) {
      final disciplines = state.disciplines.items;

      if (disciplines.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 64,
                color: Colors.grey[400],
              ),
              16.verticalSpace,
              Text(
                'No disciplines found',
                style: AppTextStyles.heading2.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              8.verticalSpace,
              Text(
                'Try adjusting your search or filters',
                style: AppTextStyles.body2.copyWith(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        );
      }
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          ///height
          mainAxisExtent: ResponsiveHelper.responsiveValue(context, mobile:220,tablet:220, desktop: 230, ) ,
          ///width
          maxCrossAxisExtent: ResponsiveHelper.responsiveValue(context, mobile:520, tablet:320,desktop: 400, ) ,
          crossAxisSpacing: 8,
          mainAxisSpacing: 16,
        ),
        itemCount: disciplines.length,
        itemBuilder: (context, index) {
          final discipline = disciplines[index];
          return DisciplineCard(
            discipline: discipline,
            onView: () {
              context.go("${RouteName.disciplineDetail}?id=${discipline.id}");
            },
            onTap: () {
              context.go("${RouteName.disciplineDetail}?id=${discipline.id}");
            },
            onEdit: () {
              context.go("${RouteName.updateDiscipline}?id=${discipline.id}");
            },
            onDelete: () => _showDeleteConfirmation( discipline),
          );
        },
      );
    }

    if (state is DisciplinesError) {
      return Center(
        child: RetryWidget(
          message: state.message,
          onTapOnRetry: _loadDisciplines,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildPagination(DisciplineState state) {
    if (state is! DisciplinesLoaded) {
      return const SizedBox.shrink();
    }

    final totalPages = state.disciplines.totalPages;
    
    return ValueListenableBuilder<int>(
      valueListenable: _currentPageNotifier,
      builder: (context, currentPage, child) {
        return PaginationWidget(
          currentPage: currentPage,
          totalPages: totalPages,
          onPrevious: currentPage > 1 ? () {
            _currentPageNotifier.value = currentPage - 1;
          } : null,
          onNext: currentPage < totalPages ? () {
            _currentPageNotifier.value = currentPage + 1;
          } : null,
          onPageSelected: (page) {
            _currentPageNotifier.value = page;
          },
        );
      },
    );
  }

  void _showDeleteConfirmation( DisciplineModel discipline) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 500),
        child: AlertDialog(

          title: Text(
            'Delete Discipline',
            style: AppTextStyles.subHeading1,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Are you sure you want to delete "${discipline.name}"?',
                style: AppTextStyles.body1,
              ),
              8.verticalSpace,
              Text(
                'This action cannot be undone and will permanently remove the discipline',
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.negativeColor,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Cancel',
                style: AppTextStyles.body1.copyWith(
                  color: AppColors.greyColor,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<DisciplineBloc>().add(
                  DeleteDisciplineRequested(disciplineId: discipline.id!),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.baseWhiteColor,
              ),
              child: Text(
                'Delete',
                style: AppTextStyles.body1.copyWith(
                  color: AppColors.baseWhiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchNotifier.dispose();
    _selectedTypeNotifier.dispose();
    _selectedStatusNotifier.dispose();
    _selectedRankingNotifier.dispose();
    _searchController.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }
}