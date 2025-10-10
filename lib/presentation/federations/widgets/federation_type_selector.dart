import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/space.dart';
import '../../../core/theme/app_text_styles.dart';
import '../bloc/add_federation_bloc/add_federation_bloc.dart';
import '../data/enums/federation_types.dart';
import 'add_member_federation_widget.dart';

class FederationTypeSelector extends StatefulWidget {
  final String? selectedType;
  final ValueChanged<String> onTypeSelected;
  final Function(List<int> selectedFedIds)? onSelect;

  const FederationTypeSelector({
    super.key,
    this.selectedType,
    required this.onTypeSelected,
    this.onSelect,
  });

  @override
  State<FederationTypeSelector> createState() => _FederationTypeSelectorState();
}

class _FederationTypeSelectorState extends State<FederationTypeSelector> {
  
  @override
  void initState() {
    super.initState();
    if (widget.selectedType != null) {
      _fetchFederationsForType(widget.selectedType!);
    }
  }

  @override
  void didUpdateWidget(FederationTypeSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedType != widget.selectedType && widget.selectedType != null) {
      _fetchFederationsForType(widget.selectedType!);
    }
  }

  void _fetchFederationsForType(String federationType) {
    String? filterType;
    
    switch (federationType) {
      case 'International':
        filterType = FederationType.national.apiValue; // International federations show national federations as members
        break;
      case 'National':
        filterType = FederationType.international.apiValue; // National federations show international federations for affiliation
        break;
      case 'Continental':
        filterType = FederationType.national.apiValue; // Continental federations show national federations as members
        break;
      case 'Regional':
        filterType = FederationType.national.apiValue; // Regional federations show national federations for affiliation
        break;
    }

    if (filterType != null) {
      context.read<AddFederationBloc>().add(
        GetFederationsRequested(
          federationType: filterType,
          page: 1,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Federation Type',
              style: AppTextStyles.body1.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),


          ],
        ),
        12.verticalSpace,
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildTypeOption(
              AppAssets.internationalFedTypeIcon,
              'International',
              'International',
            ),
            _buildTypeOption(
              AppAssets.nationalFedTypeIcon,
              'National',
              'National',
            ),
            _buildTypeOption(
              AppAssets.continentalFedTypeIcon,
              'Continental',
              'Continental',
            ),
            _buildTypeOption(
              AppAssets.regionalFedTypeIcon,
              'Regional',
              'Regional',
            ),
          ],
        ),
        if (widget.selectedType == 'International') ...[
          5.verticalSpace,
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: AppColors.infoColor,
              ),
              5.horizontalSpace,
              Text(
                'International federations can include national federations as members & oversee their memberships.',
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.infoColor,
                ),
              ),
            ],
          ),
          24.verticalSpace,
          _buildFederationWidget("Add Member Federation (required)"),
        ] else if (widget.selectedType == 'National') ...[
          5.verticalSpace,
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: AppColors.infoColor,
              ),
              5.horizontalSpace,
              Text(
                'Choose international organizations your federation is affiliated with.',
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.infoColor,
                ),
              ),
            ],
          ),
          24.verticalSpace,
          _buildFederationWidget("Select your International Affiliations (optional)"),
        ] else if (widget.selectedType == 'Continental') ...[
          5.verticalSpace,
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: AppColors.infoColor,
              ),
              5.horizontalSpace,
              Text(
                'Continental federations can include national federations as members.',
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.infoColor,
                ),
              ),
            ],
          ),
          24.verticalSpace,
          _buildFederationWidget("Add National Federation as Members (required)"),
        ] else if (widget.selectedType == 'Regional') ...[
          5.verticalSpace,
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: AppColors.infoColor,
              ),
              5.horizontalSpace,
              Text(
                'Select national affiliations for your regional federation.',
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.infoColor,
                ),
              ),
            ],
          ),
          24.verticalSpace,
          _buildFederationWidget("Select your National Affiliations (optional)"),
        ],
      ],
    );
  }

  Widget _buildFederationWidget(String title) {
    String? filterType;
    switch (widget.selectedType) {
      case 'International':
        filterType = FederationType.national.apiValue;
        break;
      case 'National':
        filterType = FederationType.international.apiValue;
        break;
      case 'Continental':
        filterType = FederationType.national.apiValue;
        break;
      case 'Regional':
        filterType = FederationType.national.apiValue;
        break;
    }
    
    return AddMemberFederationWidget(
      title: title,
      federationType: filterType,
      onCancel: () {},
      onAddSelected: (selectedMembers) {},
      onSelect: widget.onSelect,
    );
  }

  Widget _buildTypeOption(String iconPath, String type, String value) {
    final isSelected = widget.selectedType == value;
    
    return GestureDetector(
      onTap: () {
        widget.onTypeSelected(value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.tertiaryColor.withValues(alpha: 0.1) : AppColors.baseWhiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.tertiaryColor : AppColors.greyColor.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconPath,
              width: 20,
              height: 20,
            ),
            8.horizontalSpace,
            Text(
              type,
              style: AppTextStyles.body2.copyWith(
                color: isSelected ? AppColors.tertiaryColor : AppColors.baseBlackColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }


}