import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';

class DefaultDisciplineImageWidget extends StatelessWidget {
  const DefaultDisciplineImageWidget({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8.0,
    this.backgroundColor,
  });

  final double? width;
  final double? height;
  final double borderRadius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        
        color: backgroundColor ?? AppColors.neutral50,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: AppColors.neutral200,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.asset(
          AppAssets.fedmanLogo,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: backgroundColor ?? AppColors.neutral100,
              child: Icon(
                Icons.sports,
                color: AppColors.greyColor,
                size: (width != null && height != null) 
                    ? (width! < height! ? width! * 0.4 : height! * 0.4)
                    : 32,
              ),
            );
          },
        ),
      ),
    );
  }
}