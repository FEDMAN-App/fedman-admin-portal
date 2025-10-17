import 'package:flutter/material.dart';
import 'package:fedman_admin_app/presentation/disciplines/data/enums/sport_types.dart';
import 'package:fedman_admin_app/presentation/disciplines/data/models/discipline_model.dart';

mixin DisciplineFormMixin<T extends StatefulWidget> on State<T> {
  // Text Controllers
  final TextEditingController disciplineNameController = TextEditingController();
  
  // Value Notifiers
  final ValueNotifier<int?> selectedLevelCountNotifier = ValueNotifier(null);
  final ValueNotifier<SportType?> selectedSportTypeNotifier = ValueNotifier(null);
  final ValueNotifier<bool> hasRankingNotifier = ValueNotifier(false);
  final ValueNotifier<List<LevelModel>> levelsNotifier = ValueNotifier([]);
  
  @override
  void dispose() {
    // Dispose text controllers
    disciplineNameController.dispose();
    
    // Dispose value notifiers
    selectedLevelCountNotifier.dispose();
    selectedSportTypeNotifier.dispose();
    hasRankingNotifier.dispose();
    levelsNotifier.dispose();
    
    super.dispose();
  }
  
  void clearForm() {
    // Clear text controllers
    disciplineNameController.clear();
    
    // Reset value notifiers
    selectedLevelCountNotifier.value = null;
    selectedSportTypeNotifier.value = null;
    hasRankingNotifier.value = false;
    levelsNotifier.value = [];
  }
  
  void initializeDefaultLevels() {
    // Initialize with 5 default levels
    final levels = List.generate(
      5,
      (index) => LevelModel(
        levelName: 'Level ${index + 1}',
        categories: [
          CategoryModel(
            categoryName: 'Age Bracket',
            categoryValues: ['U20', 'U24'],
          ),
          CategoryModel(
            categoryName: 'Professional Status',
            categoryValues: ['Amateur', 'Open'],
          ),
          CategoryModel(
            categoryName: 'Horse Experience',
            categoryValues: ['Domestic', 'Olympic'],
          ),
          CategoryModel(
            categoryName: 'Jump Heights',
            categoryValues: ['Olympic'],
          ),
        ],
        classTypes: [],
      ),
    );
    levelsNotifier.value = levels;
  }
  
  void addLevel(LevelModel level) {
    final currentLevels = List<LevelModel>.from(levelsNotifier.value);
    currentLevels.add(level);
    levelsNotifier.value = currentLevels;
  }
  
  void updateLevel(int index, LevelModel level) {
    final currentLevels = List<LevelModel>.from(levelsNotifier.value);
    currentLevels[index] = level;
    levelsNotifier.value = currentLevels;
  }
  
  void removeLevel(int index) {
    final updatedLevels = List<LevelModel>.from(levelsNotifier.value);
    updatedLevels.removeAt(index);
    levelsNotifier.value = updatedLevels;
  }
  
  bool validateForm() {
    return disciplineNameController.text.isNotEmpty &&
           selectedSportTypeNotifier.value != null &&
           levelsNotifier.value.isNotEmpty;
  }
  
  Map<String, dynamic> getFormData() {
    return {
      'name': disciplineNameController.text,
      'sportType': selectedSportTypeNotifier.value,
      'hasRanking': hasRankingNotifier.value,
      'levels': levelsNotifier.value,
    };
  }
  
  void populateForm(DisciplineModel discipline) {
    disciplineNameController.text = discipline.name;
    selectedSportTypeNotifier.value = discipline.sportType;
    hasRankingNotifier.value = discipline.hasRanking;
    levelsNotifier.value = discipline.levels;
  }
}