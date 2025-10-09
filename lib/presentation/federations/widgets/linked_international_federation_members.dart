import 'package:fedman_admin_app/core/constants/app_assets.dart';
import 'package:fedman_admin_app/presentation/federations/widgets/add_federation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/common_widgets/custom_buttons.dart';
import '../../../core/common_widgets/custom_cached_image_widget.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/extensions/space.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../data/models/federation_model.dart';
import '../data/enums/federation_types.dart';

class LinkedInternationalFederationMembers extends StatefulWidget {
  const LinkedInternationalFederationMembers({super.key});

  @override
  State<LinkedInternationalFederationMembers> createState() =>
      _LinkedInternationalFederationMembersState();
}

class _LinkedInternationalFederationMembersState
    extends State<LinkedInternationalFederationMembers> {
  final List<FederationModel> _members = [
    FederationModel(
      id: 0,
      name: 'European Equestrian Federation',
      type: FederationType.international,
      country: 'New York',
      city: 'New York',
      streetAddress: '123 Main St',
      postCode: '10001',
      createdDate: '1/15/2024',
      fedLogo: AppConstants.dummyImageUrl,
      status: 'active',
      updatedAt: '1/15/2024',
    ),
    FederationModel(
      id: 1,
      name: 'American Horse Association',
      type: FederationType.national,
      country: 'United States',
      city: 'Los Angeles',
      streetAddress: '456 Oak Ave',
      postCode: '90210',
      createdDate: '1/15/2024',
      fedLogo: AppConstants.dummyImageUrl,
      status: 'active',
      updatedAt: '1/15/2024',
    ),
    FederationModel(
      id: 3,
      name: 'British Dressage Federation',
      type: FederationType.international,
      country: 'United Kingdom',
      city: 'Sunnyvale',
      streetAddress: '789 Pine Rd',
      postCode: 'SW1A 1AA',
      createdDate: '1/15/2024',
      fedLogo: AppConstants.dummyImageUrl,
      status: 'active',
      updatedAt: '1/15/2024',
    ),
    FederationModel(
      id: 4,
      name: 'Australian Equestrian Federation',
      type: FederationType.international,
      country: 'Australia',
      city: 'California',
      streetAddress: '321 Elm St',
      postCode: '2000',
      createdDate: '1/15/2024',
      fedLogo: AppConstants.dummyImageUrl,
      status: 'active',
      updatedAt: '1/15/2024',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        24.verticalSpace,
        _buildMembersList(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Federation Members',
          style: AppTextStyles.subHeading2,
        ),
        SizedBox(
          height:48 ,
          child: CustomButton(
            isSecondaryBtn: true,
            title: 'Add Federations',
            borderColor: AppColors.primaryColor,
            icon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(AppAssets.federationIcon,
                  colorFilter: ColorFilter.mode(
                      AppColors.primaryColor, BlendMode.srcIn), ),
            ),
            onTap: _addFederations,
          ),
        ),
      ],
    );
  }

  Widget _buildMembersList() {
    return Column(
      children: _members.map((memberData) {
        return _buildMemberCard(memberData);
      }).toList(),
    );
  }

  Widget _buildMemberCard(FederationModel memberData) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.baseWhiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.neutral200,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          Container(
            width: 60,
            height: 60,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CustomCachedImageWidget(
              url: memberData.fedLogo ?? AppConstants.dummyImageUrl,
            ),
          ),
          16.horizontalSpace,
          // Federation Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  memberData.name ?? 'Unknown Federation',
                  style: AppTextStyles.body1.copyWith(
                      color: AppColors.neutral700
                  ),
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: AppColors.neutral600,
                    ),
                    4.horizontalSpace,
                    Text(
                      memberData.country ?? 'Unknown Location',
                      style: AppTextStyles.navlinks1.copyWith(
                        color: AppColors.neutral600,
                      ),
                    ),
                  ],
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: AppColors.neutral600,
                    ),
                    4.horizontalSpace,
                    Text(
                      memberData.createdDate ?? 'Unknown Date',
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.neutral600,
                      ),
                    ),
                  ],
                ),
                isMobile? 8.verticalSpace:0.verticalSpace,
                 isMobile? _buildExpiryBadge(memberData):SizedBox(),
              ],
            ),
          ),
          // Expiry Badge
          if (!isMobile) _buildExpiryBadge(memberData),
        ],
      ),
    );
  }

  Widget _buildExpiryBadge(FederationModel memberData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (memberData.status ?? 'active') != "active"
            ? AppColors.negative100
            : AppColors.tertiary50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today,
            size: 16,
            color: (memberData.status ?? 'active') != "active"
                ? AppColors.negativeColor
                : AppColors.infoColor,
          ),
          4.horizontalSpace,
          Text(
            (memberData.status ?? 'active') != "active"
                ? 'Expired ${memberData.createdDate ?? 'Unknown Date'}'
                : 'Expire at: ${memberData.createdDate ?? 'Unknown Date'}',
            style: AppTextStyles.body2.copyWith(
              color: (memberData.status ?? 'active') != "active"
                  ? AppColors.negativeColor
                  : AppColors.infoColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _addFederations() {
    showDialog(context:context, builder: (context) => AddFederationDialog(),);
  }
}

// Helper class to combine federation with membership data
class FederationMemberData {
  final FederationModel federation;
  final String expiryDate;
  final bool isExpired;

  FederationMemberData({
    required this.federation,
    required this.expiryDate,
    required this.isExpired,
  });
}