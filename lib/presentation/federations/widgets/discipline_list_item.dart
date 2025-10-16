import 'package:cached_network_image/cached_network_image.dart';
import 'package:fedman_admin_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/space.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../disciplines/data/models/discipline_model.dart';

class DisciplineListItem extends StatelessWidget {
  final DisciplineModel discipline;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const DisciplineListItem({
    super.key,
    required this.discipline,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(

        border: Border(
          bottom: BorderSide(
            color: AppColors.greyColor.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Container(clipBehavior: Clip.antiAlias,decoration: BoxDecoration(shape: BoxShape.circle),width: 40,height: 40,child: CachedNetworkImage(imageUrl: AppConstants.dummyImageUrl,fit: BoxFit.cover,)),
              5.horizontalSpace,
              Flexible(
                child: Text(
                  discipline.name,
                  style: AppTextStyles.navlinks1.copyWith(
                    color: AppColors.baseBlackColor
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: Text(
              discipline.levels.toString(),
              style: AppTextStyles.navlinks1.copyWith(color: AppColors.baseBlackColor),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: _buildRankingEnabledChip(),
        ),
        Expanded(
          flex: 3,
          child: _buildLevelsChips(),
        ),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                discipline.name,
                style: AppTextStyles.body1.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _buildActionButtons(),
          ],
        ),
        8.verticalSpace,
        Text(
          'No of Levels: ${discipline.levels}',
          style: AppTextStyles.navlinks1.copyWith(
            color: AppColors.baseBlackColor,
          ),
        ),
        8.verticalSpace,
        Row (
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Ranking enabled: ',
              style: AppTextStyles.navlinks1.copyWith(
                color: AppColors.baseBlackColor,
              ),
            ),  _buildRankingEnabledChip(),
          ],
        ),
        8.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Levels: ',
              style: AppTextStyles.navlinks1.copyWith(
                color: AppColors.baseBlackColor,
              ),
            ),
            Flexible(child: _buildLevelsChips()),
          ],
        ),
      ],
    );
  }

  Widget _buildRankingEnabledChip() {
    return Center(

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: discipline.hasRanking
              ? AppColors.positive50Color
              : AppColors.negative100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          discipline.hasRanking ? 'Yes' : 'No',
          style: AppTextStyles.navlinks1.copyWith(
            color: discipline.hasRanking
                ? AppColors.positiveColor
                : AppColors.negativeColor,
            fontWeight: FontWeight.w500,

          ),
        ),
      ),
    );
  }

  Widget _buildLevelsChips() {
    return Wrap(
      runAlignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 4,
      children: discipline.levels.take(4).map((level) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.baseWhiteColor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppColors.neutral200,
              width: 1,
            ),
          ),
          child: Text(
            level.levelName,
            style: AppTextStyles.body3.copyWith(

              color: AppColors.neutral800,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons() {
    return SizedBox(
      width: 45,
      child: IconButton(
        onPressed: onEdit,
        icon: Icon(
          Icons.link_off,
          size: 18,
          color: AppColors.negativeColor,
        ),
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(),
      ),
    );
  }
}