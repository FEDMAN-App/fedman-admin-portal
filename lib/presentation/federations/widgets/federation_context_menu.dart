import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/space.dart';
import '../../../core/theme/app_text_styles.dart';

class FederationContextMenu extends StatelessWidget {
  final VoidCallback? onView;
  final VoidCallback? onEdit;
  final VoidCallback? onDeactivate;

  const FederationContextMenu({
    super.key,
    this.onView,
    this.onEdit,
    this.onDeactivate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: AppColors.baseWhiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.baseBlackColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [


        ],
      ),
    );
  }

  static Widget _buildMenuItem({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    bool isDestructive = false,
    required BuildContext context
  }) {
    return InkWell(
      onTap: (){
        context.pop();
        onTap?.call();
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(

        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: isDestructive ? AppColors.negativeColor : AppColors.greyColor,
            ),
            12.horizontalSpace,
            Text(
              title,
              style: AppTextStyles.body2.copyWith(
                color: isDestructive ? AppColors.negativeColor : AppColors.baseBlackColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildDivider() {
    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(horizontal: 8),
      color: AppColors.greyColor.withValues(alpha: 0.2),
    );
  }

  static void show({
    required BuildContext context,
    required RelativeRect position,
    VoidCallback? onView,
    VoidCallback? onEdit,
    VoidCallback? onDeactivate,
  }) {
    showMenu<void>(
      menuPadding: EdgeInsets.zero,
      context: context,
      position: position,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      constraints: BoxConstraints(maxWidth: 140),
      elevation: 5,


      items: [
        PopupMenuItem<void>(


          padding: EdgeInsets.zero,
          child: _buildMenuItem(
            context: context,
            icon: Icons.visibility_outlined,
            title: 'View',
            onTap: onView,
          ),


        ),

        PopupMenuItem<void>(
            height: 1,
            enabled: false,
          padding: EdgeInsets.zero,

          child: _buildDivider()


        ),

        PopupMenuItem<void>(

          padding: EdgeInsets.zero,

          child:
          _buildMenuItem(
            context: context,
            icon: Icons.edit_outlined,
            title: 'Edit',
            onTap: onEdit,
          ),



        ),
        PopupMenuItem<void>(

            height: 1,
            enabled: false,
            padding: EdgeInsets.zero,
            child: _buildDivider()


        ),
        PopupMenuItem<void>(




          padding: EdgeInsets.zero,

          child:
          _buildMenuItem(
            context: context,
            icon: Icons.delete,
            title: 'Delete',
            onTap: onDeactivate,
            isDestructive: true,
          ),


        ),
      ],
    );
  }
}