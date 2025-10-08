import 'package:fedman_admin_app/core/common_widgets/common_widgets_barrel.dart';
import 'package:fedman_admin_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/common_widgets/custom_buttons.dart';
import '../../../core/common_widgets/responsive_row_column.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/space.dart';
import '../../../core/theme/app_text_styles.dart';


class FederationDetailsView extends StatelessWidget {
  const FederationDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop=ResponsiveHelper.isDesktop(context);
    return ResponsiveRowColumn(
      layout: ResponsiveLayout.mobileTabletColumn,
wrapInExpanded: true,

      rowCrossAxisAlignment: CrossAxisAlignment.start,


      children: [
        _buildFederationInformation(),
        isDesktop? 20.horizontalSpace:20.verticalSpace,
        _buildDocumentsSection(),
      ],
    );
  }

  Widget _buildFederationInformation() {
    return RoundedContainerWidget(
      showShadow: false,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Federation Information',
              style: AppTextStyles.subHeading2,
            ),
            24.verticalSpace,
            _buildInfoRow('Name', 'European Equestrian Federation'),
            24.verticalSpace,
            _buildAddressSection(),
            24.verticalSpace,
            _buildInfoRow('Status', 'Active', isStatus: true),
            24.verticalSpace,
            _buildInfoRow('Created Date', 'January 15, 2024'),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 16,
              color: AppColors.greyColor,
            ),
            6.horizontalSpace,
            Text(
              'Address',
              style: AppTextStyles.body2.copyWith(
                color: AppColors.greyColor,
              ),
            ),
          ],
        ),
        6.verticalSpace,
        Text(
          '123 Main ST\nNew York, NY 10001',
          style: AppTextStyles.body1,
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isStatus = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.body2.copyWith(
            color: AppColors.neutral600,
          ),
        ),
        6.verticalSpace,
        if (isStatus)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.positive50Color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.positiveColor,
                    shape: BoxShape.circle,
                  ),
                ),
                6.horizontalSpace,
                Text(
                  value,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.baseBlackColor,
                  ),
                ),
              ],
            ),
          )
        else
          Text(
            value,
            style: AppTextStyles.body1,
          ),
      ],
    );
  }

  Widget _buildDocumentsSection() {
    return RoundedContainerWidget(
      showShadow: false,

      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Documents',
              style: AppTextStyles.subHeading2,
            ),
            24.verticalSpace,
            _buildDocumentItem(
              'Federation Statutes 2024',
              'PDF • 2.3 MB • 1/15/2024',
            ),
            24.verticalSpace,
            _buildDocumentItem(
              'Competition Rules',
              'PDF • 2.3 MB • 1/15/2024',
            ),
            24.verticalSpace,
            _buildDocumentItem(
              'Safety Guidelines',
              'PDF • 2.3 MB • 1/15/2024',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentItem(String title, String details) {
    return RoundedContainerWidget(
      showShadow: false,
      color: AppColors.neutral50,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                AppAssets.pdfFileIcon,
                width: 20,
                height: 20,
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body1.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    details,
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                AppAssets.downloadIcon,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  AppColors.greyColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}