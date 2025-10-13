import 'package:fedman_admin_app/core/common_widgets/common_widgets_barrel.dart';
import 'package:fedman_admin_app/core/extensions/extensions_barrell.dart';
import 'package:fedman_admin_app/presentation/home/widgets/overview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/common_widgets/responsive_row_column.dart';
import '../../core/common_widgets/screen_body.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';
import 'widgets/quick_action_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenBody(
      child: Padding(
        padding: ResponsiveHelper.responsivePadding(
          context,
          mobile: const EdgeInsets.all(16),
          desktop: const EdgeInsets.all(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            24.verticalSpace,
            _buildOverviewSection(context),
            32.verticalSpace,
            _buildAdminQuickActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Overview',
          style: AppTextStyles.subHeading1,
        ),
        Row(
          children: [
            Text(
              'Today',
              style: AppTextStyles.body2.copyWith(
                color: AppColors.neutralBase,
              ),
            ),
            8.horizontalSpace,
            const Icon(
              Icons.calendar_today,
              size: 16,
              color: AppColors.neutralBase,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOverviewSection(BuildContext context) {
    return ResponsiveWrap(
      wrapAt: ResponsiveLayout.alwaysColumn,
     // layout: ResponsiveLayout.mobileColumn,
      runSpacing:ResponsiveHelper.responsiveValue(
        context,
        mobile: 16,
        desktop: 26,
      ),
      spacing: ResponsiveHelper.responsiveValue(
        context,
        mobile: 16,
        desktop: 26,
      ),
      children: [
        OverviewCard(
          icon: SvgPicture.asset(
            AppAssets.federationIcon,

            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          iconBackgroundColor: AppColors.tertiaryColor,
          mainValue: '24',
          label: 'Total Federations',
          indicatorText: '+2 this month',
          indicatorColor: AppColors.positiveColor,
        ),
        OverviewCard (
          icon: SvgPicture.asset(
            AppAssets.userAdministrationIcon,

            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          iconBackgroundColor: AppColors.positiveColor,
          mainValue: '1,847',
          label: 'Total User\'s',
          indicatorText: '+156 this month',
          indicatorColor: AppColors.positiveColor,
        ),
        OverviewCard(
          icon: SvgPicture.asset(
            AppAssets.eventIcon,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          iconBackgroundColor: AppColors.negativeColor,
          mainValue: '43',
          label: 'Active Events',
          indicatorText: '+8 this week',
          indicatorColor: AppColors.negativeBase,
        ),
        OverviewCard(
          icon: const Icon(
            Icons.pets,
            color: Colors.white,
          ),
          iconBackgroundColor: AppColors.warningColor,
          mainValue: '3,291',
          label: 'Registered Animals',
          indicatorText: '+89 this month',
          indicatorColor: AppColors.warningColor,
        ),
        OverviewCard(
          icon: SvgPicture.asset(
            AppAssets.judgeIcon,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          iconBackgroundColor: AppColors.dashboardPurple,
          mainValue: '50',
          label: 'Total Judges',
          indicatorText: '+12 this month',
          indicatorColor: AppColors.positiveColor,
        ),
        OverviewCard(
          icon: const Icon(
            Icons.pending_actions,
            size: 24,
            color: Colors.white,
          ),
          iconBackgroundColor: AppColors.primaryColor,
          mainValue: '18',
          label: 'Pending Requests',
          indicatorText: 'Needs attention',
          indicatorColor: AppColors.negativeColor,
        ),
      ],
    );
  }

  Widget _buildAdminQuickActions(BuildContext context) {
    return RoundedContainerWidget(
      showShadow: false,
      showBorder: false,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Admin Quick Actions',
              style: AppTextStyles.subHeading1,
            ),
            20.verticalSpace,
            ResponsiveRowColumn(
              layout: ResponsiveLayout.mobileColumn,
              wrapInExpanded: true,
              excludeSpacingFromExpanded: true,

              spacing: 12,
              children: [
                QuickActionCard(
                  icon: AppAssets.federationIcon,
                  title: 'Add Federations',
                  onTap: () {},
                ),
                QuickActionCard(
                  icon: AppAssets.disciplineIcon,
                  title: 'Add Disciplines',
                  onTap: () {},
                ),
                QuickActionCard(
                  icon: AppAssets.eventIcon,
                  title: 'Create Events',
                  onTap: () {},
                ),
                QuickActionCard(
                  icon: AppAssets.judgeIcon,
                  title: 'Manage Judges',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}