import 'package:freezed_annotation/freezed_annotation.dart';

enum StatusType {
  @JsonValue(true)
  active(true, 'Active'),
  @JsonValue(false)
  inactive(false, 'Inactive');

  const StatusType(this.apiValue, this.displayName);

  final bool apiValue;
  final String displayName;

  static StatusType? fromApiValue(bool apiValue) {
    for (StatusType type in StatusType.values) {
      if (type.apiValue == apiValue) {
        return type;
      }
    }
    return null;
  }

  static List<String> get dropdownValues {
    return ['All Status', ...StatusType.values.map((e) => e.displayName)];
  }

  static bool? getApiValueFromDisplayName(String? displayName) {
    if (displayName == null || displayName == 'All Status') return null;
    
    for (StatusType type in StatusType.values) {
      if (type.displayName == displayName) {
        return type.apiValue;
      }
    }
    return null;
  }
}