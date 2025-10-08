import 'package:cached_network_image/cached_network_image.dart';
import 'package:fedman_admin_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

import '../../../core/common_widgets/custom_buttons.dart';
import '../../../core/common_widgets/custom_text_form_field.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/space.dart';
import '../../../core/theme/app_text_styles.dart';

class AddFederationDialog extends StatefulWidget {
  final Function(List<String>)? onFederationsSelected;

  const AddFederationDialog({super.key, this.onFederationsSelected});

  static Future<List<String>?> show({required BuildContext context}) {
    return showDialog<List<String>>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AddFederationDialog(
        onFederationsSelected: (federations) =>
            Navigator.of(context).pop(federations),
      ),
    );
  }

  @override
  State<AddFederationDialog> createState() => _AddFederationDialogState();
}

class _AddFederationDialogState extends State<AddFederationDialog> {
  final ValueNotifier<String> _searchQueryNotifier = ValueNotifier('');
  final ValueNotifier<List<String>> _selectedFederationsNotifier =
      ValueNotifier([]);
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _federations = [
    {'name': 'American Equestrian Federation', 'isSelected': false},
    {'name': 'Canadian Horse Sports Federation', 'isSelected': false},
    {'name': 'British Equestrian Federation', 'isSelected': false},
    {'name': 'Australian Equestrian Federation', 'isSelected': false},
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _searchQueryNotifier.value = _searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 600,
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            _buildSearchField(),
            Expanded(child: _buildFederationsList()),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Add Federation', style: AppTextStyles.subHeading1),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, size: 20, color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextFormField(
        controller: _searchController,
        hintText: 'Search by name of Federation...',
        prefixIcon: Icon(Icons.search, color: AppColors.neutral600, size: 20),

      ),
    );
  }

  Widget _buildFederationsList() {
    return ValueListenableBuilder<String>(
      valueListenable: _searchQueryNotifier,
      builder: (context, searchQuery, child) {
        final filteredFederations = _federations.where((federation) {
          return federation['name'].toString().toLowerCase().contains(
            searchQuery.toLowerCase(),
          );
        }).toList();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: filteredFederations.length,
            separatorBuilder: (context, index) => 16.verticalSpace,
            itemBuilder: (context, index) {
              final federation = filteredFederations[index];
              return _buildFederationItem(federation);
            },
          ),
        );
      },
    );
  }

  Widget _buildFederationItem(Map<String, dynamic> federation) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: _selectedFederationsNotifier,
      builder: (context, selectedFederations, child) {
        final isSelected = selectedFederations.contains(federation['name']);

        return GestureDetector(
          onTap: () {
            final currentSelected = List<String>.from(
              _selectedFederationsNotifier.value,
            );
            if (isSelected) {
              currentSelected.remove(federation['name']);
            } else {
              currentSelected.add(federation['name']);
            }
            _selectedFederationsNotifier.value = currentSelected;
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryColor.withOpacity(0.1)
                  : AppColors.baseWhiteColor,
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.neutral200,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: CachedNetworkImage(
                    imageUrl: AppConstants.dummyImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        federation['name'],
                        style: AppTextStyles.subHeading2.copyWith(
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.baseBlackColor,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                      4.verticalSpace,
                      Text(
                        'National',
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.neutral600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: AppColors.primaryColor,
                    size: 24,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActions() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 48,
              child: CustomButton(
                title: 'Cancel',
                isSecondaryBtn: true,
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          16.horizontalSpace,
          Expanded(
            child: ValueListenableBuilder<List<String>>(
              valueListenable: _selectedFederationsNotifier,
              builder: (context, selectedFederations, child) {
                return SizedBox(
                  height: 48,
                  child: CustomButton(
                    title: 'Add Federations (${selectedFederations.length})',

                    onTap: selectedFederations.isNotEmpty
                        ? () => widget.onFederationsSelected?.call(selectedFederations)
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchQueryNotifier.dispose();
    _selectedFederationsNotifier.dispose();
    _searchController.dispose();
    super.dispose();
  }
}