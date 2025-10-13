import 'package:fedman_admin_app/core/common_widgets/common_widgets_barrel.dart';
import 'package:fedman_admin_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../clippers/one_side_curved_card_painter.dart';

class QuickActionCard extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const QuickActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile=ResponsiveHelper.isMobile(context);
    return GestureDetector(
      onTap: onTap,
      child: RoundedContainerWidget(
        width: isMobile?double.maxFinite: 225,

        showBorder: false,
        showShadow: false,
        color: AppColors.tertiary50,
        child: Stack(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 26),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    icon,
                    width: 26,
                    height: 26,
                  ),
                  6.verticalSpace,
                  Text(
                    title,
                    style: AppTextStyles.cta1.copyWith(
                      color: AppColors.baseBlackColor,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 12,
              right: 10,
              child: Container(
                width: 35,
                height: 35,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }
}