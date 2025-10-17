import 'package:fedman_admin_app/core/common_widgets/custom_buttons.dart';
import 'package:fedman_admin_app/core/common_widgets/custom_text_form_field.dart';
import 'package:fedman_admin_app/core/constants/app_assets.dart';
import 'package:fedman_admin_app/core/constants/app_colors.dart';
import 'package:fedman_admin_app/core/extensions/space.dart';
import 'package:fedman_admin_app/core/theme/app_text_styles.dart';
import 'package:fedman_admin_app/presentation/disciplines/data/models/discipline_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddLevelDialog extends StatefulWidget {
  final LevelModel? levelToEdit;

  const AddLevelDialog({super.key, this.levelToEdit});

  @override
  State<AddLevelDialog> createState() => _AddLevelDialogState();
}

class _AddLevelDialogState extends State<AddLevelDialog> {
  final TextEditingController _levelNameController = TextEditingController();
  final ValueNotifier<List<CategoryModel>> _categoriesNotifier = ValueNotifier(
    [],
  );
  final Map<int, TextEditingController> _categoryNameControllers = {};
  final Map<int, TextEditingController> _categoryValueControllers = {};
  final ValueNotifier<String?> _errorMessageNotifier = ValueNotifier(null);

  bool get isEditMode => widget.levelToEdit != null;

  @override
  void initState() {
    super.initState();
    if (isEditMode && widget.levelToEdit != null) {
      _levelNameController.text = widget.levelToEdit!.levelName;
      final categories = List<CategoryModel>.from(
        widget.levelToEdit!.categories,
      );
      _categoriesNotifier.value = categories;

      // Create controllers for existing categories
      for (int i = 0; i < categories.length; i++) {
        _categoryNameControllers[i] = TextEditingController(
          text: categories[i].categoryName,
        );
        _categoryValueControllers[i] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    _levelNameController.dispose();
    _categoriesNotifier.dispose();
    _errorMessageNotifier.dispose();

    // Dispose all category controllers
    for (final controller in _categoryNameControllers.values) {
      controller.dispose();
    }
    for (final controller in _categoryValueControllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  void _addNewCategory() {
    // Clear error when adding category
    if (_errorMessageNotifier.value != null) {
      _errorMessageNotifier.value = null;
    }

    final currentCategories = List<CategoryModel>.from(
      _categoriesNotifier.value,
    );
    final newIndex = currentCategories.length;

    // Create controllers for the new category
    _categoryNameControllers[newIndex] = TextEditingController();
    _categoryValueControllers[newIndex] = TextEditingController();

    currentCategories.add(CategoryModel(categoryName: '', categoryValues: []));
    _categoriesNotifier.value = currentCategories;
  }

  void _removeCategory(int index) {
    final currentCategories = List<CategoryModel>.from(
      _categoriesNotifier.value,
    );
    currentCategories.removeAt(index);

    // Dispose and remove controllers for the removed category
    _categoryNameControllers[index]?.dispose();
    _categoryValueControllers[index]?.dispose();
    _categoryNameControllers.remove(index);
    _categoryValueControllers.remove(index);

    // Update indices for remaining controllers
    final namesToUpdate = <int, TextEditingController>{};
    final valuesToUpdate = <int, TextEditingController>{};

    for (final entry in _categoryNameControllers.entries) {
      if (entry.key > index) {
        namesToUpdate[entry.key - 1] = entry.value;
      } else {
        namesToUpdate[entry.key] = entry.value;
      }
    }

    for (final entry in _categoryValueControllers.entries) {
      if (entry.key > index) {
        valuesToUpdate[entry.key - 1] = entry.value;
      } else {
        valuesToUpdate[entry.key] = entry.value;
      }
    }

    _categoryNameControllers.clear();
    _categoryValueControllers.clear();
    _categoryNameControllers.addAll(namesToUpdate);
    _categoryValueControllers.addAll(valuesToUpdate);

    _categoriesNotifier.value = currentCategories;
  }

  void _updateCategoryName(int index, String name) {
    // Clear error when typing category name
    if (_errorMessageNotifier.value != null) {
      _errorMessageNotifier.value = null;
    }

    final currentCategories = List<CategoryModel>.from(
      _categoriesNotifier.value,
    );
    currentCategories[index] = CategoryModel(
      categoryName: name,
      categoryValues: currentCategories[index].categoryValues,
    );
    _categoriesNotifier.value = currentCategories;
  }

  void _updateCategoryValues(int index, List<String> values) {
    final currentCategories = List<CategoryModel>.from(
      _categoriesNotifier.value,
    );
    currentCategories[index] = CategoryModel(
      categoryName: currentCategories[index].categoryName,
      categoryValues: values,
    );
    _categoriesNotifier.value = currentCategories;
  }

  void _addCategoryValue(int categoryIndex, String value) {
    if (value.trim().isEmpty) return;

    // Clear error when adding category value
    if (_errorMessageNotifier.value != null) {
      _errorMessageNotifier.value = null;
    }

    final currentCategories = List<CategoryModel>.from(
      _categoriesNotifier.value,
    );
    final currentValues = List<String>.from(
      currentCategories[categoryIndex].categoryValues,
    );

    if (!currentValues.contains(value.trim())) {
      currentValues.add(value.trim());
      _updateCategoryValues(categoryIndex, currentValues);
    }
  }

  void _removeCategoryValue(int categoryIndex, int valueIndex) {
    final currentCategories = List<CategoryModel>.from(
      _categoriesNotifier.value,
    );
    final currentValues = List<String>.from(
      currentCategories[categoryIndex].categoryValues,
    );
    currentValues.removeAt(valueIndex);
    _updateCategoryValues(categoryIndex, currentValues);
  }

  bool _validateForm() {
    // Clear previous error
    _errorMessageNotifier.value = null;

    // Validate level name
    if (_levelNameController.text.trim().isEmpty) {
      _errorMessageNotifier.value = 'Level name is required';
      return false;
    }

    // Validate at least one category exists
    if (_categoriesNotifier.value.isEmpty) {
      _errorMessageNotifier.value = 'At least one category is required';
      return false;
    }

    // Validate each category
    for (int i = 0; i < _categoriesNotifier.value.length; i++) {
      final categoryName = _categoryNameControllers[i]?.text.trim() ?? '';
      final categoryValues = _categoriesNotifier.value[i].categoryValues;

      // Validate category name
      if (categoryName.isEmpty) {
        _errorMessageNotifier.value =
            'Category name is required for all categories';
        return false;
      }

      // Validate at least one category value
      if (categoryValues.isEmpty) {
        _errorMessageNotifier.value =
            'At least one value is required for each category';
        return false;
      }
    }

    return true;
  }

  void _saveLevel() {
    if (!_validateForm()) return;

    // Collect current category data from controllers
    final updatedCategories = <CategoryModel>[];
    final currentCategories = _categoriesNotifier.value;

    for (int i = 0; i < currentCategories.length; i++) {
      final categoryName = _categoryNameControllers[i]?.text.trim() ?? '';
      updatedCategories.add(
        CategoryModel(
          categoryName: categoryName,
          categoryValues: currentCategories[i].categoryValues,
        ),
      );
    }

    final level = LevelModel(
      levelName: _levelNameController.text.trim(),
      categories: updatedCategories,
      classTypes: widget.levelToEdit?.classTypes ?? [],
    );

    Navigator.of(context).pop(level);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 600,
        constraints: const BoxConstraints(maxHeight: 700),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              24.verticalSpace,
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLevelNameSection(),
                  24.verticalSpace,
                  _buildCategoriesSection(),
                ],
              ),
              24.verticalSpace,
              _buildErrorMessage(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SvgPicture.asset(
            AppAssets.disciplineIcon,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
        ),
        12.horizontalSpace,
        Text(
          isEditMode ? 'Edit Level' : 'Add Level',
          style: AppTextStyles.subHeading1,
        ),
        Spacer(),
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.cancel_outlined),
        ),
      ],
    );
  }

  Widget _buildErrorMessage() {
    return ValueListenableBuilder<String?>(
      valueListenable: _errorMessageNotifier,
      builder: (context, errorMessage, child) {
        if (errorMessage == null) {
          return const SizedBox.shrink();
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: AppColors.errorColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.errorColor.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.error_outline, color: AppColors.errorColor, size: 20),
              8.horizontalSpace,
              Expanded(
                child: Text(
                  errorMessage,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.errorColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLevelNameSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Level name',
          style: AppTextStyles.body1.copyWith(fontWeight: FontWeight.w500),
        ),
        8.verticalSpace,
        CustomTextFormField(
          controller: _levelNameController,
          hintText: 'Enter level name here',
          onChange: (value) {
            // Clear error when user starts typing
            if (_errorMessageNotifier.value != null) {
              _errorMessageNotifier.value = null;
            }
          },
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Categories',
              style: AppTextStyles.body1.copyWith(fontWeight: FontWeight.w500),
            ),
            TextButton.icon(
              onPressed: _addNewCategory,
              icon: Icon(Icons.add, color: AppColors.primaryColor, size: 18),
              label: Text(
                'Add Categories',
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        16.verticalSpace,
        ValueListenableBuilder<List<CategoryModel>>(
          valueListenable: _categoriesNotifier,
          builder: (context, categories, child) {
            if (categories.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: AppColors.neutral50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.neutral200),
                ),
                child: Center(
                  child: Text(
                    'No categories added yet',
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
              );
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: categories.asMap().entries.map((entry) {
                final index = entry.key;
                final category = entry.value;
                return _buildCategoryItem(index, category);
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategoryItem(int index, CategoryModel category) {
    // Get or create controllers for this category
    if (!_categoryNameControllers.containsKey(index)) {
      _categoryNameControllers[index] = TextEditingController(
        text: category.categoryName,
      );
    }
    if (!_categoryValueControllers.containsKey(index)) {
      _categoryValueControllers[index] = TextEditingController();
    }

    final categoryNameController = _categoryNameControllers[index]!;
    final categoryValueController = _categoryValueControllers[index]!;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.baseWhiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: categoryNameController,
                  hintText: 'Name Of the categories',
                  onChange: (value) => _updateCategoryName(index, value ?? ''),
                ),
              ),
              8.horizontalSpace,
              IconButton(
                onPressed: () => _removeCategory(index),
                icon: SvgPicture.asset(
                  AppAssets.deleteIcon,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    AppColors.errorColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  maxLines: 1,
                  expands: false,
                  controller: categoryValueController,
                  hintText: 'e.g., 8", 12", 16"',
                  onFieldSubmitted: (value) {
                    if (value.isNotEmpty) {
                      _addCategoryValue(index, value);
                      categoryValueController.clear();
                    }
                  },
                ),
              ),
              8.horizontalSpace,
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: () {
                    final value = categoryValueController.text;
                    if (value.isNotEmpty) {
                      _addCategoryValue(index, value);
                      categoryValueController.clear();
                    }
                  },
                  icon: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
          if (category.categoryValues.isNotEmpty) ...[
            16.verticalSpace,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: category.categoryValues.asMap().entries.map((
                valueEntry,
              ) {
                final valueIndex = valueEntry.key;
                final value = valueEntry.value;
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),

                  decoration: BoxDecoration(
                    color: AppColors.primary50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primaryColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        value,
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      4.horizontalSpace,
                      GestureDetector(
                        onTap: () => _removeCategoryValue(index, valueIndex),
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 45,
          child: CustomButton(
            title: 'Cancel',
            onTap: () => Navigator.of(context).pop(),
            buttonColor: AppColors.baseWhiteColor,
            titleColor: AppColors.greyColor,
            borderColor: AppColors.neutral200,
            isSecondaryBtn: true,
          ),
        ),
        16.horizontalSpace,
        SizedBox(
          height: 45,
          child: CustomButton(
            isLeadingIcon: true,
            icon: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: SvgPicture.asset(
                AppAssets.circleCheckIcon,
                width: 18,
                height: 18,
                colorFilter: ColorFilter.mode(
                  AppColors.baseWhiteColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            title: isEditMode ? 'Update' : 'Save',
            onTap: _saveLevel,
            buttonColor: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
