import 'package:fedman_admin_app/core/common_widgets/custom_cached_image_widget.dart';
import 'package:fedman_admin_app/core/common_widgets/option_selector.dart';
import 'package:fedman_admin_app/core/common_widgets/responsive_row_column.dart';
import 'package:fedman_admin_app/core/constants/app_constants.dart';
import 'package:fedman_admin_app/core/utils/responsive_helper.dart';
import 'package:fedman_admin_app/presentation/federations/widgets/deactivate_federation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/common_widgets/screen_body.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/space.dart';
import '../../../core/theme/app_text_styles.dart';
import '../widgets/federation_details_view.dart';
import '../widgets/linked_disciplines_view.dart';
import '../widgets/linked_international_federation_members.dart';

class FederationDetailsScreen extends StatefulWidget {
  const FederationDetailsScreen({super.key});

  @override
  State<FederationDetailsScreen> createState() =>
      _FederationDetailsScreenState();
}

class _FederationDetailsScreenState extends State<FederationDetailsScreen> {
  final ValueNotifier<int> _selectedTabNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ScreenBody(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            24.verticalSpace,
            _buildTabSelector(),
            24.verticalSpace,
            ValueListenableBuilder<int>(
              valueListenable: _selectedTabNotifier,
              builder: (context, selectedTab, child) {
                return _buildTabContent(selectedTab);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {

    return ResponsiveRowColumn(
      columnMainAxisAlignment: MainAxisAlignment.start,
      columnCrossAxisAlignment: CrossAxisAlignment.start,
      layout: ResponsiveLayout.mobileColumn,
      children: [
        Center(
          child: Container(
            clipBehavior: Clip.antiAlias,
            width: 120,
            height: 120,

            decoration: BoxDecoration(shape: BoxShape.circle),

            child: CustomCachedImageWidget(url: AppConstants.dummyImageUrl),
          ),
        ),
        ResponsiveHelper.isMobile(context)? 16.verticalSpace: 16.horizontalSpace,
        ResponsiveHelper.isMobile(context)?_buildFedInfoView():Expanded(

            child: _buildFedInfoView()
        ),
        ResponsiveHelper.isMobile(context)? 10.verticalSpace:0.verticalSpace,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                AppAssets.editIcon,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  AppColors.infoColor,
                  BlendMode.srcIn,
                ),
              ),
            ),

            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => DeactivateFederationDialog(
                    federationName: "ABC federation",
                  ),
                );
              },
              icon: SvgPicture.asset(
                AppAssets.deactivateIcon,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTabSelector() {
    return SizedBox(
      width: ResponsiveHelper.isMobile(context)?double.maxFinite:  270,
      height: 45,
      child: OptionSelector(
        optionRadius: 4,
        options: const ['Details', 'Disciplines', 'Members'],
        selectedIndex: _selectedTabNotifier.value,
        onOptionSelected: (index) {
          _selectedTabNotifier.value = index;
        },
      ),
    );
  }

  Widget _buildTabContent(int selectedTab) {
    switch (selectedTab) {
      case 0:
        return const FederationDetailsView();
      case 1:
        return const LinkedDisciplinesView();
      case 2:
        return const LinkedInternationalFederationMembers();
      default:
        return const FederationDetailsView();
    }
  }

  @override
  void dispose() {
    _selectedTabNotifier.dispose();
    super.dispose();
  }

  Widget _buildFedInfoView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'European Equestrian Federation',
          style: AppTextStyles.subHeading1,
        ),
        12.verticalSpace,
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 20,
              color: AppColors.neutral600,
            ),
            12.horizontalSpace,
            Text(
              'New York',
              style: AppTextStyles.body2.copyWith(
                color: AppColors.neutral600,
              ),
            ),
          ],
        ),
        12.verticalSpace,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              width: 20,
              height: 20,
              AppAssets.internationalFedTypeIcon,
            ),
            12.horizontalSpace,
            Text(
              'International',
              style: AppTextStyles.body2.copyWith(
                color: AppColors.neutral900,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
