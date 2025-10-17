import 'package:fedman_admin_app/presentation/disciplines/data/models/discipline_model.dart';
import 'package:flutter/material.dart';
import 'package:fedman_admin_app/core/extensions/space.dart';
import 'package:fedman_admin_app/core/theme/app_text_styles.dart';
import 'package:fedman_admin_app/core/constants/app_colors.dart';

class LevelCard extends StatelessWidget {
  final LevelModel level;

  const LevelCard({
    super.key,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 350,maxWidth: 500, ),
      child: Card(

        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                level.levelName,
                style: AppTextStyles.subHeading2,
              ),
              16.verticalSpace,
              Text(
                'Categories:',
                style: AppTextStyles.body1.copyWith(
                ),
              ),
              8.verticalSpace,
              ...level.categories.map((category) => CategoryListItem(
                title: category.categoryName,
                values: category.categoryValues,
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryListItem extends StatelessWidget {
  final String title;
  final List<String> values;

  const CategoryListItem({
    super.key,
    required this.title,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.body2.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.baseBlackColor,
            ),
          ),
          16.horizontalSpace,
          Wrap(

            spacing: 8,
            runSpacing: 8,
            children: values.map((value) => CategoryChip(label: value)).toList(),
          ),
        ],
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;

  const CategoryChip({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.info50  ,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: (backgroundColor ?? AppColors.infoColor).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.body2.copyWith(
          color: textColor ?? Colors.blue[700],
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}