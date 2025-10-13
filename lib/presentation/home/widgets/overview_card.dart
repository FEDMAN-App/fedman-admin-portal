import 'package:fedman_admin_app/core/common_widgets/common_widgets_barrel.dart';
import 'package:fedman_admin_app/core/extensions/extensions_barrell.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';


class OverviewCard extends StatelessWidget {
  final Widget icon;
  final Color iconBackgroundColor;
  final String mainValue;
  final String label;
  final String? indicatorText;
  final Color? indicatorColor;

  const OverviewCard({
    super.key,
    required this.icon,
    required this.iconBackgroundColor,
    required this.mainValue,
    required this.label,
    this.indicatorText,
    this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile=ResponsiveHelper.isMobile(context);

    return RoundedContainerWidget(
      width: isMobile?double.maxFinite: 310,

      showShadow: false,
      showBorder: false,

      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(

                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: icon,
            ),
            16.verticalSpace,
            Text(
              mainValue,
              style: AppTextStyles.heading1.copyWith(
                color: AppColors.baseBlackColor,
              ),
            ),
            4.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: AppTextStyles.body1.copyWith(
                      color: AppColors.typographyLightBase,

                    ),
                  ),
                ),
                if (indicatorText != null) ...[
                  8.horizontalSpace,
                  Text(
                    indicatorText!,
                    style: AppTextStyles.body3.copyWith(
                      color: indicatorColor ?? AppColors.positiveColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}