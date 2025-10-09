import 'package:cached_network_image/cached_network_image.dart';
import 'package:fedman_admin_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

import '../../../core/common_widgets/custom_buttons.dart';
import '../../../core/common_widgets/custom_text_form_field.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/space.dart';
import '../../../core/theme/app_text_styles.dart';

class AddDisciplineDialog extends StatefulWidget {
  final Function(List<String>)? onDisciplinesSelected;

  const AddDisciplineDialog({super.key, this.onDisciplinesSelected});

  static Future<List<String>?> show({required BuildContext context}) {
    return showDialog<List<String>>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AddDisciplineDialog(
        onDisciplinesSelected: (disciplines) =>
            Navigator.of(context).pop(disciplines),
      ),
    );
  }

  @override
  State<AddDisciplineDialog> createState() => _AddDisciplineDialogState();
}

class _AddDisciplineDialogState extends State<AddDisciplineDialog> {
  final ValueNotifier<String> _searchQueryNotifier = ValueNotifier('');
  final ValueNotifier<List<String>> _selectedDisciplinesNotifier =
      ValueNotifier([]);
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, Object>> _disciplines = <Map<String, Object>>[
    <String, Object>{'name': 'Agility', 'isSelected': false},
    <String, Object>{'name': 'Obedience', 'isSelected': false},
    <String, Object>{'name': 'Dressage', 'isSelected': false},
    <String, Object>{'name': 'Eventing', 'isSelected': false},
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
            Expanded(child: _buildDisciplinesList()),
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
          Text('Add Discipline', style: AppTextStyles.subHeading1),
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
        hintText: 'Search by name of Discipline...',
        prefixIcon: Icon(Icons.search, color: AppColors.neutral600, size: 20),
      ),
    );
  }

  Widget _buildDisciplinesList() {
    return ValueListenableBuilder<String>(
      valueListenable: _searchQueryNotifier,
      builder: (context, searchQuery, child) {
        final filteredDisciplines = _disciplines.where((Map<String, Object> discipline) {
          final String name = discipline['name'] as String? ?? '';
          return name.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: filteredDisciplines.length,
            separatorBuilder: (context, index) => 16.verticalSpace,
            itemBuilder: (context, index) {
              final discipline = filteredDisciplines[index];
              return _buildDisciplineItem(discipline);
            },
          ),
        );
      },
    );
  }

  Widget _buildDisciplineItem(Map<String, Object> discipline) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: _selectedDisciplinesNotifier,
      builder: (context, selectedDisciplines, child) {
        final String disciplineName = discipline['name'] as String? ?? '';
        final isSelected = selectedDisciplines.contains(disciplineName);

        return GestureDetector(
          onTap: () {
            final currentSelected = List<String>.from(
              _selectedDisciplinesNotifier.value,
            );
            if (isSelected) {
              currentSelected.remove(disciplineName);
            } else {
              currentSelected.add(disciplineName);
            }
            _selectedDisciplinesNotifier.value = currentSelected;
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
                  child: Text(
                    disciplineName,
                    style: AppTextStyles.subHeading2.copyWith(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.baseBlackColor,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
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
              valueListenable: _selectedDisciplinesNotifier,
              builder: (context, selectedDisciplines, child) {
                return SizedBox(
                  height: 48,
                  child: CustomButton(
                    title: 'Add Disciplines (${selectedDisciplines.length})',

                    onTap: selectedDisciplines.isNotEmpty
                        ? () => widget.onDisciplinesSelected?.call(
                            selectedDisciplines,
                          )
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
    _selectedDisciplinesNotifier.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
