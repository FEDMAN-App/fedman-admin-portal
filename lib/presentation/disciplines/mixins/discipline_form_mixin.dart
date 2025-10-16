import 'package:flutter/material.dart';
import 'package:fedman_admin_app/presentation/disciplines/data/enums/sport_types.dart';
import 'package:fedman_admin_app/presentation/disciplines/data/models/discipline_model.dart';

mixin DisciplineFormMixin<T extends StatefulWidget> on State<T> {
  // Text Controllers
  final TextEditingController disciplineNameController = TextEditingController();
  final TextEditingController disciplineDescriptionController = TextEditingController();
  
  // Value Notifiers
  final ValueNotifier<int?> selectedLevelCountNotifier = ValueNotifier(null);
  final ValueNotifier<SportType?> selectedSportTypeNotifier = ValueNotifier(null);
  final ValueNotifier<bool> hasRankingNotifier = ValueNotifier(false);
  final ValueNotifier<List<LevelModel>> levelsNotifier = ValueNotifier([]);
  final ValueNotifier<bool> isActiveNotifier = ValueNotifier(true);
  
  // Additional discipline-specific properties
  final ValueNotifier<String?> selectedDifficultyNotifier = ValueNotifier(null);
  final ValueNotifier<String?> selectedSeasonNotifier = ValueNotifier(null);
  final ValueNotifier<bool> isTeamSportNotifier = ValueNotifier(false);
  final ValueNotifier<int?> maxParticipantsNotifier = ValueNotifier(null);
  final ValueNotifier<int?> minParticipantsNotifier = ValueNotifier(null);
  
  // Equipment and venue requirements
  final ValueNotifier<List<String>> requiredEquipmentNotifier = ValueNotifier([]);
  final ValueNotifier<String?> venueTypeNotifier = ValueNotifier(null);
  
  @override
  void dispose() {
    // Dispose text controllers
    disciplineNameController.dispose();
    disciplineDescriptionController.dispose();
    
    // Dispose value notifiers
    selectedLevelCountNotifier.dispose();
    selectedSportTypeNotifier.dispose();
    hasRankingNotifier.dispose();
    levelsNotifier.dispose();
    isActiveNotifier.dispose();
    selectedDifficultyNotifier.dispose();
    selectedSeasonNotifier.dispose();
    isTeamSportNotifier.dispose();
    maxParticipantsNotifier.dispose();
    minParticipantsNotifier.dispose();
    requiredEquipmentNotifier.dispose();
    venueTypeNotifier.dispose();
    
    super.dispose();
  }
  
  void clearForm() {
    // Clear text controllers
    disciplineNameController.clear();
    disciplineDescriptionController.clear();
    
    // Reset value notifiers
    selectedLevelCountNotifier.value = null;
    selectedSportTypeNotifier.value = null;
    hasRankingNotifier.value = false;
    levelsNotifier.value = [];
    isActiveNotifier.value = true;
    selectedDifficultyNotifier.value = null;
    selectedSeasonNotifier.value = null;
    isTeamSportNotifier.value = false;
    maxParticipantsNotifier.value = null;
    minParticipantsNotifier.value = null;
    requiredEquipmentNotifier.value = [];
    venueTypeNotifier.value = null;
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
      'disciplineName': disciplineNameController.text,
      'description': disciplineDescriptionController.text,
      'sportType': selectedSportTypeNotifier.value?.name,
      'hasRanking': hasRankingNotifier.value,
      'levels': levelsNotifier.value,
      'isActive': isActiveNotifier.value,
      'difficulty': selectedDifficultyNotifier.value,
      'season': selectedSeasonNotifier.value,
      'isTeamSport': isTeamSportNotifier.value,
      'maxParticipants': maxParticipantsNotifier.value,
      'minParticipants': minParticipantsNotifier.value,
      'requiredEquipment': requiredEquipmentNotifier.value,
      'venueType': venueTypeNotifier.value,
    };
  }
  
  void populateForm(Map<String, dynamic> data) {
    disciplineNameController.text = data['disciplineName'] ?? '';
    disciplineDescriptionController.text = data['description'] ?? '';
    selectedSportTypeNotifier.value = data['sportType'] != null 
        ? SportType.values.firstWhere((e) => e.name == data['sportType'])
        : null;
    hasRankingNotifier.value = data['hasRanking'] ?? false;
    levelsNotifier.value = data['levels'] ?? [];
    isActiveNotifier.value = data['isActive'] ?? true;
    selectedDifficultyNotifier.value = data['difficulty'];
    selectedSeasonNotifier.value = data['season'];
    isTeamSportNotifier.value = data['isTeamSport'] ?? false;
    maxParticipantsNotifier.value = data['maxParticipants'];
    minParticipantsNotifier.value = data['minParticipants'];
    requiredEquipmentNotifier.value = List<String>.from(data['requiredEquipment'] ?? []);
    venueTypeNotifier.value = data['venueType'];
  }
}