import 'package:fedman_admin_app/core/common_widgets/screen_body.dart';
import 'package:fedman_admin_app/core/common_widgets/custom_text_form_field.dart';
import 'package:fedman_admin_app/core/extensions/space.dart';
import 'package:fedman_admin_app/core/theme/app_text_styles.dart';
import 'package:fedman_admin_app/core/constants/app_colors.dart';
import 'package:fedman_admin_app/core/constants/app_assets.dart';
import 'package:fedman_admin_app/core/common_widgets/custom_buttons.dart';
import 'package:fedman_admin_app/core/common_widgets/responsive_row_column.dart';
import 'package:fedman_admin_app/core/utils/responsive_helper.dart';
import 'package:fedman_admin_app/presentation/disciplines/data/enums/sport_types.dart';
import 'package:fedman_admin_app/presentation/disciplines/data/enums/status_type.dart';
import 'package:fedman_admin_app/presentation/disciplines/data/models/discipline_model.dart';
import 'package:fedman_admin_app/presentation/disciplines/screens/widgets/level_card.dart';
import 'package:fedman_admin_app/presentation/disciplines/screens/widgets/add_level_dialog.dart';
import 'package:fedman_admin_app/presentation/disciplines/mixins/discipline_form_mixin.dart';
import 'package:fedman_admin_app/presentation/disciplines/blocs/create_discipline_bloc/create_discipline_bloc.dart';
import 'package:fedman_admin_app/presentation/disciplines/data/repositories/discipline_repo.dart';
import 'package:fedman_admin_app/core/di/injection.dart';
import 'package:fedman_admin_app/core/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';



class CreateNewDisciplineScreen extends StatelessWidget {
  final int? disciplineId;
  
  const CreateNewDisciplineScreen({super.key, this.disciplineId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateDisciplineBloc(
        disciplineRepo: GetIt.instance<DisciplineRepo>(),
      ),
      child: CreateNewDisciplineScreenView(disciplineId: disciplineId),
    );
  }
}
class CreateNewDisciplineScreenView extends StatefulWidget {
  final int? disciplineId;

  const CreateNewDisciplineScreenView({super.key, this.disciplineId});

  @override
  State<CreateNewDisciplineScreenView> createState() => _CreateNewDisciplineScreenState();
}
class _CreateNewDisciplineScreenState extends State<CreateNewDisciplineScreenView>
    with DisciplineFormMixin {

  @override
  void initState() {
    super.initState();
    // Start with empty levels - users will add through dialog

    // If disciplineId is provided, this is update mode
    if (widget.disciplineId != null) {
      // Fetch discipline data for editing
      context.read<CreateDisciplineBloc>().add(
        FetchDisciplineForEdit(disciplineId: widget.disciplineId!),
      );
    }
  }
  
  bool get isUpdateMode => widget.disciplineId != null;
  
  void _populateFormFields(DisciplineModel discipline) {
    disciplineNameController.text = discipline.name;
    selectedSportTypeNotifier.value = discipline.sportType;
    hasRankingNotifier.value = discipline.hasRanking;
    selectedLevelCountNotifier.value = discipline.levels.length;
    levelsNotifier.value = List.from(discipline.levels);
  }

  Future<void> _showAddLevelDialog([LevelModel? levelToEdit, int? levelIndex]) async {
    final result = await showDialog<LevelModel>(
      context: context,
      builder: (context) => AddLevelDialog(levelToEdit: levelToEdit),
    );

    if (result != null) {
      if (levelToEdit != null && levelIndex != null) {
        // Update existing level
        updateLevel(levelIndex, result);
      } else {
        // Add new level
        addLevel(result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateDisciplineBloc, CreateDisciplineState>(
      listener: (context, state) {
        if (state is FetchDisciplineSuccess) {
          _populateFormFields(state.discipline);
        } else if (state is FetchDisciplineError) {
          SnackbarUtils.showCustomToast(
            context,
            state.message,
            isError: true,
          );
        }
      },
      builder: (context, state) {
        if(state is FetchDisciplineLoading){
          return Center(child: CircularProgressIndicator(),);
        }else{
          return  ScreenBody(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isUpdateMode ? 'Update Discipline' : 'Create Discipline',
                    style: AppTextStyles.subHeading2.copyWith(
                    ),
                  ),
                  //_buildBreadcrumb(),
                  24.verticalSpace,
                  _buildDisciplineInformation(),
                  24.verticalSpace,
                  _buildTypesOfSports(),
                  24.verticalSpace,
                  _buildLevelsSection(),
                  24.verticalSpace,
                  _buildRankingSection(),
                  20.verticalSpace,
                  _buildActionButtons(),
                ],
              ),
            ),
          );
        }

      },

    );
  }

  Widget _buildBreadcrumb() {
    return Row(
      children: [
        Icon(
          Icons.home_outlined,
          size: 16,
          color: AppColors.greyColor,
        ),
        4.horizontalSpace,
        Text(
          'Dashboard',
          style: AppTextStyles.body2.copyWith(
            color: AppColors.greyColor,
          ),
        ),
        8.horizontalSpace,
        Icon(
          Icons.arrow_forward_ios,
          size: 12,
          color: AppColors.greyColor,
        ),
        8.horizontalSpace,
        Text(
          'Disciplines',
          style: AppTextStyles.body2.copyWith(
            color: AppColors.greyColor,
          ),
        ),
        8.horizontalSpace,
        Icon(
          Icons.arrow_forward_ios,
          size: 12,
          color: AppColors.greyColor,
        ),
        8.horizontalSpace,
        Text(
          'Add Discipline',
          style: AppTextStyles.body2.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDisciplineInformation() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.baseWhiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SvgPicture.asset(
                  AppAssets.disciplineIcon,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              12.horizontalSpace,
              Text(
                'Discipline Information',
                style: AppTextStyles.subHeading2,
              ),
            ],
          ),
          24.verticalSpace,
          ResponsiveRowColumn(
            layout: ResponsiveLayout.mobileColumn,
            spacing: 24,
            wrapInExpanded: true,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Discipline Name',
                    style: AppTextStyles.body1.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  8.verticalSpace,
                  CustomTextFormField(
                    controller: disciplineNameController,
                    hintText: 'Enter Discipline name',
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Number of levels',
                    style: AppTextStyles.body1.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  8.verticalSpace,
                  ValueListenableBuilder<int?>(
                    valueListenable: selectedLevelCountNotifier,
                    builder: (context, selectedCount, child) {
                      return DropdownButtonFormField<int>(
                        value: selectedCount,
                        decoration: InputDecoration(
                          hintText: 'Select level count',
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
                            borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          filled: true,
                          fillColor: AppColors.baseWhiteColor,
                        ),
                        items: List.generate(10, (index) => index + 1)
                            .map((count) => DropdownMenuItem(
                                  value: count,
                                  child: Text(
                                    count.toString(),
                                    style: AppTextStyles.body2,
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          selectedLevelCountNotifier.value = value;
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypesOfSports() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Type of Sport',
          style: AppTextStyles.subHeading2,
        ),
        16.verticalSpace,
        ValueListenableBuilder<SportType?>(
          valueListenable: selectedSportTypeNotifier,
          builder: (context, selectedType, child) {
            return DropdownButtonFormField<SportType>(
              value: selectedType,
              decoration: InputDecoration(
                hintText: 'Select sport type',
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
                  borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                filled: true,
                fillColor: AppColors.baseWhiteColor,
              ),
              items: SportType.values
                  .map((sportType) => DropdownMenuItem(
                        value: sportType,
                        child: Text(
                          sportType.displayName,
                          style: AppTextStyles.body2,
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                selectedSportTypeNotifier.value = value;
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildLevelsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Levels',
              style: AppTextStyles.subHeading2,
            ),
            TextButton.icon(
              onPressed: () {
                _showAddLevelDialog();
              },
              icon: Icon(Icons.add, color: AppColors.primaryColor),
              label: Text(
                'Add Level',
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        16.verticalSpace,
        ValueListenableBuilder<List<LevelModel>>(
          valueListenable: levelsNotifier,
          builder: (context, levels, child) {
            if (levels.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: AppColors.neutral50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.neutral200),
                ),
                child: Center(
                  child: Column(
                    children: [

                      Text(
                        'No levels added yet',
                        style: AppTextStyles.body1.copyWith(
                          color: AppColors.greyColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      4.verticalSpace,
                      Text(
                        'Click "Add Level" to create your first level',
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            
            return Wrap(
              runSpacing: 20,
              children: List.generate(levels.length,(index) {
                final level = levels[index];
                return Container(
                  margin: EdgeInsets.only(right: 16),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () => _showAddLevelDialog(level, index),
                        child: LevelCard(level: level),
                      ),
                      Positioned(
                        top: 12,
                        right: 8,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => _showAddLevelDialog(level, index),
                              icon: SvgPicture.asset(
                                AppAssets.editIcon,
                                width: 18,
                                height: 18,
                                colorFilter: ColorFilter.mode(
                                  AppColors.infoColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              padding: const EdgeInsets.all(8),
                              constraints: const BoxConstraints(
                                minWidth: 32,
                                minHeight: 32,
                              ),
                            ),
                            4.horizontalSpace,
                            IconButton(
                              onPressed: () {
                                removeLevel(index);
                              },
                              icon: SvgPicture.asset(
                                AppAssets.deleteIcon,
                                width: 18,
                                height: 18,
                                colorFilter: ColorFilter.mode(
                                  AppColors.errorColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              padding: const EdgeInsets.all(8),
                              constraints: const BoxConstraints(
                                minWidth: 32,
                                minHeight: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRankingSection() {
    return ValueListenableBuilder<bool>(
      valueListenable: hasRankingNotifier,
      builder: (context, hasRanking, child) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.positive50Color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.positiveBase),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.positive100Color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.emoji_events_outlined,
                  color: AppColors.successColor,
                  size: 24,
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Has A Ranking?',
                      style: AppTextStyles.subHeading1.copyWith(
                        color: AppColors.positiveBase,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      'Enabling this makes the discipline competitive means ranking point will be awarded to this discipline',
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.positiveBase,
                      ),
                    ),
                  ],
                ),
              ),

              Column(mainAxisSize: MainAxisSize.min,children: [
                Switch(

                  value: hasRanking,
                  onChanged: (value) {
                    hasRankingNotifier.value = value;
                  },
                  activeThumbColor: AppColors.successColor,
                  inactiveThumbColor: AppColors.baseWhiteColor,
                  inactiveTrackColor: AppColors.neutral100,

                ),
                Text(
                  hasRankingNotifier.value? 'Enabled':"Disabled",
                  style: AppTextStyles.body3.copyWith(
                    color: AppColors.neutral600,
                  ),
                ),
              ],)

            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 26),
      child: Align(
        alignment: Alignment.bottomRight,
        child: BlocConsumer<CreateDisciplineBloc, CreateDisciplineState>(
          listener: (context, state) {
            if (state is CreateDisciplineSuccess) {
              SnackbarUtils.showCustomToast(
                context,
                state.message,
                isError: false,
              );
              context.pop();
            } else if (state is CreateDisciplineError) {
              SnackbarUtils.showCustomToast(
                context,
                state.message,
                isError: true,
              );
            }
          },
          builder: (context, state) {
            return CustomButton(
              title: isUpdateMode ? 'Update Discipline' : 'Create Discipline',
              onTap: state is CreateDisciplineLoading ? null : _submitForm,
              buttonColor: AppColors.primaryColor,
              centerAlign: true,
              isLoading: state is CreateDisciplineLoading,
            );
          },
        ),
      ),
    );
  }

  void _submitForm() {
    if (_validateForm()) {
      final bloc = context.read<CreateDisciplineBloc>();
      
      final discipline = DisciplineModel(
        id: isUpdateMode ? widget.disciplineId! :null,
        name: disciplineNameController.text.trim(),
        sportType: selectedSportTypeNotifier.value!,
        hasRanking: hasRankingNotifier.value,
        levels: levelsNotifier.value,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      if (isUpdateMode) {
        bloc.add(SubmitUpdateDisciplineForm(discipline: discipline));
      } else {
        bloc.add(SubmitCreateDisciplineForm(discipline: discipline));
      }
    }
  }

  bool _validateForm() {
    if (disciplineNameController.text.trim().isEmpty) {
      SnackbarUtils.showCustomToast(
        context,
        'Please enter discipline name',
        isError: true,
      );
      return false;
    }
    
    if (selectedSportTypeNotifier.value == null) {
      SnackbarUtils.showCustomToast(
        context,
        'Please select sport type',
        isError: true,
      );
      return false;
    }
    
    if (levelsNotifier.value.isEmpty) {
      SnackbarUtils.showCustomToast(
        context,
        'Please add at least one level',
        isError: true,
      );
      return false;
    }
    
    return true;
  }

}