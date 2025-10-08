import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/common_widgets/custom_buttons.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/space.dart';
import '../../../core/theme/app_text_styles.dart';

class DeactivateFederationDialog extends StatelessWidget {
  final String federationName;
  final VoidCallback? onCancel;
  final VoidCallback? onDeactivate;

  const DeactivateFederationDialog({
    super.key,
    required this.federationName,
    this.onCancel,
    this.onDeactivate,
  });

  static Future<bool?> show({
    required BuildContext context,
    required String federationName,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => DeactivateFederationDialog(
        federationName: federationName,
        onCancel: () => Navigator.of(context).pop(false),
        onDeactivate: () => Navigator.of(context).pop(true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(),
            24.verticalSpace,
            _buildTitle(),
            16.verticalSpace,
            _buildDescription(),
            32.verticalSpace,
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return SvgPicture.asset(
      AppAssets.deactivateIcon,
      width: 83,
      height: 83,
      colorFilter: ColorFilter.mode(
        AppColors.primaryColor,
        BlendMode.srcIn,
      ),
    );
  }

  Widget _buildTitle() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Are you sure you want to deactivate\n"',
            style: AppTextStyles.subHeading1.copyWith(
              color: AppColors.baseBlackColor,
              height: 1.4,
            ),
          ),
          TextSpan(
            text: federationName,
            style: AppTextStyles.subHeading1.copyWith(
              color: AppColors.baseBlackColor,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          TextSpan(
            text: '?"',
            style: AppTextStyles.subHeading1.copyWith(
              color: AppColors.baseBlackColor,
              height: 1.4,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription() {
    return Text(
      'This will prevent the federation from accessing the system and managing their competitions. All existing data will be preserved and the federation can be reactivated later.',
      style: AppTextStyles.body1.copyWith(
        color: AppColors.neutral600,
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: CustomButton(
              title: 'Cancel',
              isSecondaryBtn: true,
              onTap: onCancel,
            ),
          ),
        ),
        16.horizontalSpace,
        Expanded(
          child: SizedBox(
            height: 48,
            child: CustomButton(
              title: 'Deactivate',
              onTap: onDeactivate,
            ),
          ),
        ),
      ],
    );
  }
}