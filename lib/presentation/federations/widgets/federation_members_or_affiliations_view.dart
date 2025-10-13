import 'package:fedman_admin_app/core/constants/app_assets.dart';
import 'package:fedman_admin_app/core/utils/format_date.dart';
import 'package:fedman_admin_app/presentation/federations/data/enums/federation_types.dart';
import 'package:fedman_admin_app/presentation/federations/data/models/federation_member_model.dart';
import 'package:fedman_admin_app/presentation/federations/widgets/add_federation_dialog.dart';
import 'package:fedman_admin_app/presentation/federations/widgets/federation_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import '../../../core/common_widgets/custom_buttons.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/space.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../bloc/federation_member_bloc/federation_member_bloc.dart';
import '../data/models/federation_model.dart';
import '../data/repositories/federation_repo.dart';

class FederationMembersOrAffiliationsView extends StatefulWidget {
  final FederationModel federationModel;

  const FederationMembersOrAffiliationsView({
    super.key,
    required this.federationModel,
  });

  @override
  State<FederationMembersOrAffiliationsView> createState() =>
      _FederationMembersOrAffiliationsViewState();
}

class _FederationMembersOrAffiliationsViewState
    extends State<FederationMembersOrAffiliationsView> {
  final federationMemberBloc =  FederationMemberBloc(federationRepo: GetIt.instance<FederationRepo>());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>

      federationMemberBloc..add(
              GetFederationMembers(
                federationId: widget.federationModel.id!,
                federationType: widget.federationModel.type.displayName,
              ),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildHeader(), 24.verticalSpace, _buildMembersList()],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Federation Members', style: AppTextStyles.subHeading2),
        SizedBox(
          height: 48,
          child: CustomButton(
            isSecondaryBtn: true,
            title: 'Add Federations',
            borderColor: AppColors.primaryColor,
            icon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(
                AppAssets.federationIcon,
                colorFilter: ColorFilter.mode(
                  AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            onTap: _addFederations,
          ),
        ),
      ],
    );
  }

  Widget _buildMembersList() {
    return BlocConsumer<FederationMemberBloc, FederationMemberState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        if (state is MembersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MembersLoaded) {
          if (state.members.isEmpty) {
            final isInternationalOrContinental =
                widget.federationModel.type == FederationType.international ||
                widget.federationModel.type == FederationType.continental;
            return Center(
              child: Text(
                isInternationalOrContinental
                    ? 'No members found'
                    : 'No affiliations found',
                style: AppTextStyles.body1.copyWith(
                  color: AppColors.neutral600,
                ),
              ),
            );
          }
          return Column(
            children: state.members.map((memberData) {
              return _buildMemberCard(memberData);
            }).toList(),
          );
        } else if (state is MembersError) {
          return Center(
            child: Text(
              state.message,
              style: AppTextStyles.body1.copyWith(
                color: AppColors.negativeColor,
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildMemberCard(FederationMemberModel memberData) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.baseWhiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral200, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          FederationLogoWidget(federationId: memberData.id!, size: 60),
          16.horizontalSpace,
          // Federation Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  memberData.name ?? 'Unknown Federation',
                  style: AppTextStyles.body1.copyWith(
                    color: AppColors.neutral700,
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
                      formatDate(
                            DateTime.tryParse(memberData.joinedAt ?? ""),
                            'MMM dd, yyyy',
                          ) ??
                          'Unknown Date',
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.neutral600,
                      ),
                    ),
                  ],
                ),
                isMobile ? 8.verticalSpace : 0.verticalSpace,
                isMobile ? _buildExpiryBadge(memberData) : SizedBox(),
              ],
            ),
          ),
          // Expiry Badge
          if (!isMobile) _buildExpiryBadge(memberData),
        ],
      ),
    );
  }

  Widget _buildExpiryBadge(FederationMemberModel memberData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (true ?? 'active') != "active"
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
            color: (true ?? 'active') != "active"
                ? AppColors.negativeColor
                : AppColors.infoColor,
          ),
          4.horizontalSpace,
          Text(
            (true ?? 'active') != "active"
                ? 'Expired May 03, 2025'
                : 'Expire at: May 03, 2025}',
            style: AppTextStyles.body2.copyWith(
              color: (true ?? 'active') != "active"
                  ? AppColors.negativeColor
                  : AppColors.infoColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _addFederations() async {
    // Get current member IDs from the bloc state
    final currentState = federationMemberBloc.state;
    List<int>? currentMemberIds;
    if (currentState is MembersLoaded) {
      currentMemberIds = currentState.members.map((member) => member.id).toList();
    }
    
    final result = await showDialog(
      context: context,
      builder: (context) => AddFederationDialog(
        federationId: widget.federationModel.id,
        federationType: widget.federationModel.type.displayName,
        currentMemberIds: currentMemberIds,
      ),
    );
    if(result != null && result){
      federationMemberBloc.add(
        GetFederationMembers(
          federationId: widget.federationModel.id!,
          federationType: widget.federationModel.type.displayName,
        ),
      );
    }
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
