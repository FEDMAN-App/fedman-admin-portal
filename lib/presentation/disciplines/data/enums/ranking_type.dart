import 'package:freezed_annotation/freezed_annotation.dart';

enum RankingType {
  @JsonValue(true)
  enabled(true, 'Enabled'),
  @JsonValue(false)
  disabled(false, 'Disabled');

  const RankingType(this.apiValue, this.displayName);

  final bool apiValue;
  final String displayName;

  static RankingType? fromApiValue(bool apiValue) {
    for (RankingType type in RankingType.values) {
      if (type.apiValue == apiValue) {
        return type;
      }
    }
    return null;
  }

  static List<String> get dropdownValues {
    return ['All Ranking', ...RankingType.values.map((e) => e.displayName)];
  }

  static bool? getApiValueFromDisplayName(String? displayName) {
    if (displayName == null || displayName == 'All Ranking') return null;
    
    for (RankingType type in RankingType.values) {
      if (type.displayName == displayName) {
        return type.apiValue;
      }
    }
    return null;
  }
}