import 'package:fedman_admin_app/presentation/disciplines/data/enums/sport_types.dart';
import 'package:fedman_admin_app/presentation/federations/widgets/add_discipline_dialog.dart';
import 'package:flutter/material.dart';

import '../../../core/common_widgets/custom_buttons.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/space.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../disciplines/data/models/discipline_model.dart';
import 'discipline_list_item.dart';

class LinkedDisciplinesView extends StatefulWidget {
  const LinkedDisciplinesView({super.key});

  @override
  State<LinkedDisciplinesView> createState() => _LinkedDisciplinesViewState();
}

class _LinkedDisciplinesViewState extends State<LinkedDisciplinesView> {
  final List<DisciplineModel> _disciplines = [
    DisciplineModel(
      id: 1,
      name: 'Show Jumping',
      levels: [
        LevelModel(
          levelName: 'Starter',
          categories: [
            CategoryModel(
              categoryName: 'Height',
              categoryValues: ['60cm', '70cm', '80cm'],
            ),
          ],
          classTypes: ['Individual', 'Team'],
        ),
        LevelModel(
          levelName: 'Pre-Entry',
          categories: [
            CategoryModel(
              categoryName: 'Height',
              categoryValues: ['90cm', '1.00m'],
            ),
          ],
          classTypes: ['Individual'],
        ),
      ],
      hasRanking: true,
      sportType: SportType.horseSports,
      status: 'active',
    ),
    DisciplineModel(
      id: 2,
      name: 'Dressage',
      levels: [
        LevelModel(
          levelName: 'Introductory',
          categories: [
            CategoryModel(
              categoryName: 'Test Level',
              categoryValues: ['Test A', 'Test B'],
            ),
          ],
          classTypes: ['Individual'],
        ),
        LevelModel(
          levelName: 'Training',
          categories: [
            CategoryModel(
              categoryName: 'Test Level',
              categoryValues: ['Level 1', 'Level 2'],
            ),
          ],
          classTypes: ['Individual', 'Freestyle'],
        ),
      ],
      hasRanking: true,
      sportType: SportType.horseSports,
      status: 'active',
    ),
    DisciplineModel(
      id: 3,
      name: 'Cross Country',
      levels: [
        LevelModel(
          levelName: 'Beginner Novice',
          categories: [
            CategoryModel(
              categoryName: 'Distance',
              categoryValues: ['2640m', '3000m'],
            ),
          ],
          classTypes: ['Individual'],
        ),
        LevelModel(
          levelName: 'Novice',
          categories: [
            CategoryModel(
              categoryName: 'Fence Height',
              categoryValues: ['2\'9"', '3\'0"'],
            ),
          ],
          classTypes: ['Individual'],
        ),
      ],
      hasRanking: false,
      sportType: SportType.horseSports,
      status: 'active',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        24.verticalSpace,
        _buildDisciplinesTable(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Linked Disciplines',
          style: AppTextStyles.subHeading2,
        ),
        CustomButton(
          showTitle:  !ResponsiveHelper.isMobile(context),
          isSecondaryBtn: true,
          title: 'Add Discipline',
          borderColor: AppColors.warningColor,
          icon: Padding(
            padding:  EdgeInsets.only(right: ResponsiveHelper.isMobile(context)?0.0: 8.0),
            child: Icon(
              Icons.add,
              color: AppColors.primaryColor,
              size: 18,
            ),
          ),
          onTap: _addDiscipline,
        ),
      ],
    );
  }

  Widget _buildDisciplinesTable() {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.baseWhiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.greyColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          (isMobile)?SizedBox():_buildTableHeader(),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _disciplines.length,
            itemBuilder: (context, index) {
              return DisciplineListItem(
                discipline: _disciplines[index],
                onEdit: () => _editDiscipline(_disciplines[index]),
                onDelete: () => _deleteDiscipline(_disciplines[index]),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.tertiary100,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Discipline Name',
              textAlign: TextAlign.center,
              style: AppTextStyles.body2.copyWith(
                color: AppColors.tertiaryColor,
                fontWeight: FontWeight.w500

              ),
            ),
          ),

            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  'No of Levels',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.tertiaryColor,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  'Ranking Enabled',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.tertiaryColor,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  'Levels',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.tertiaryColor,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),

          const SizedBox(width: 45),
        ],
      ),
    );
  }

  void _addDiscipline() {
   showDialog(context: context, builder: (context) => AddDisciplineDialog(),);
  }

  void _editDiscipline(DisciplineModel discipline) {
    // TODO: Implement edit discipline functionality
    print('Edit discipline: ${discipline.name}');
  }

  void _deleteDiscipline(DisciplineModel discipline) {
    // TODO: Implement delete discipline functionality
    print('Delete discipline: ${discipline.name}');
  }
}