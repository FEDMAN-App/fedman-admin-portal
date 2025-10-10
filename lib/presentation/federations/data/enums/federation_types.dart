import 'package:freezed_annotation/freezed_annotation.dart';

enum FederationType {
  @JsonValue('INTERNATIONAL')
  international('INTERNATIONAL', 'International'),
  @JsonValue('NATIONAL')
  national('NATIONAL', 'National'),
  @JsonValue('CONTINENTAL')
  continental('CONTINENTAL', 'Continental'),
  @JsonValue('REGIONAL')
  regional('REGIONAL', 'Regional'),
  @JsonValue('No_TYPE_SELECTED')
  noType('NO_TYPE_SELECTED', 'No type selected');



  const FederationType(this.apiValue, this.displayName);

  final String apiValue;
  final String displayName;

  static FederationType? fromApiValue(String apiValue) {
    for (FederationType type in FederationType.values) {
      if (type.apiValue == apiValue) {
        return type;
      }
    }
    return null;
  }

  static List<String> get dropdownValues {
    return ['Select type', ...FederationType.values.map((e) => e.displayName)];
  }

  static String? getApiValueFromDisplayName(String? displayName) {
    if (displayName == null || displayName == 'Select type') return null;
    
    for (FederationType type in FederationType.values) {
      if (type.displayName == displayName) {
        return type.apiValue;
      }
    }
    return null;
  }
}