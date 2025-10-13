import 'package:fedman_admin_app/core/extensions/extensions_barrell.dart';
import 'package:flutter/material.dart';


import '../constants/app_colors.dart';
import '../theme/app_text_styles.dart';

class InfoWidget extends StatelessWidget {
  final String text;
  final double? iconSize;
  final Color? iconColor;
  final TextStyle? textStyle;

  const InfoWidget({
    super.key,
    required this.text,
    this.iconSize = 16,
    this.iconColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.info_outline,
          size: iconSize,
          color: iconColor ?? AppColors.infoColor,
        ),
        5.horizontalSpace,
        Expanded(
          child: Text(
            text,
            style: textStyle ??
                AppTextStyles.body2.copyWith(
                  color: AppColors.infoColor,
                ),
          ),
        ),
      ],
    );
  }
}