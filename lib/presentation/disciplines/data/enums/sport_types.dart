import 'package:freezed_annotation/freezed_annotation.dart';

enum SportType {
  @JsonValue('DOG_SPORTS')
  dogSports('DOG_SPORTS', 'Dog Sports'),
  @JsonValue('HORSE_SPORTS')
  horseSports('HORSE_SPORTS', 'Horse Sports');

  const SportType(this.apiValue, this.displayName);

  final String apiValue;
  final String displayName;

  static SportType? fromApiValue(String apiValue) {
    for (SportType type in SportType.values) {
      if (type.apiValue == apiValue) {
        return type;
      }
    }
    return null;
  }

  static List<String> get dropdownValues {
    return ['All Types', ...SportType.values.map((e) => e.displayName)];
  }

  static String? getApiValueFromDisplayName(String? displayName) {
    if (displayName == null || displayName == 'All Types') return null;
    
    for (SportType type in SportType.values) {
      if (type.displayName == displayName) {
        return type.apiValue;
      }
    }
    return null;
  }
}