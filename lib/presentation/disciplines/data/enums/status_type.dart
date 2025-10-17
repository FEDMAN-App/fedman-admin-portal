import 'package:freezed_annotation/freezed_annotation.dart';

enum DisciplineStatus {
  @JsonValue(true)
  active(true, 'Active'),
  @JsonValue(false)
  inactive(false, 'Inactive');

  const DisciplineStatus(this.apiValue, this.displayName);

  final bool apiValue;
  final String displayName;

  static DisciplineStatus? fromApiValue(bool apiValue) {
    for (DisciplineStatus type in DisciplineStatus.values) {
      if (type.apiValue == apiValue) {
        return type;
      }
    }
    return null;
  }

  static List<String> get dropdownValues {
    return ['All Status', ...DisciplineStatus.values.map((e) => e.displayName)];
  }

  static bool? getApiValueFromDisplayName(String? displayName) {
    if (displayName == null || displayName == 'All Status') return null;
    
    for (DisciplineStatus type in DisciplineStatus.values) {
      if (type.displayName == displayName) {
        return type.apiValue;
      }
    }
    return null;
  }
}