import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/federation_types.dart';

part 'federation_model.freezed.dart';
part 'federation_model.g.dart';

@freezed
@freezed
abstract class FederationModel with _$FederationModel {
  const factory FederationModel({
    int? id,
    required String name,
    @FederationTypeConverter() required FederationType type,
    @JsonKey(name: 'address') required String streetAddress,
    @JsonKey(name: 'postalCode') required String postCode,
    required String city,
    required String country,
    @JsonKey(name: 'logoUrl') String? fedLogo,
    @Default([]) List<dynamic> documents,
    String? status,
    @JsonKey(name: 'createdAt') String? createdDate,
    @JsonKey(name: 'updatedAt') String? updatedAt,
    @JsonKey(includeIfNull: false) @Default([]) List<int> memberFederationIdsWhenCreation,
    @JsonKey(includeIfNull: false) @Default([]) List<int> parentFederationIdsWhenCreation,
    @Default(0) int memberCount,
    @Default(0) int parentCount,
  }) = _FederationModel;

  factory FederationModel.fromJson(Map<String, dynamic> json) =>
      _$FederationModelFromJson(json);
}



class FederationTypeConverter implements JsonConverter<FederationType, String> {
  const FederationTypeConverter();

  @override
  FederationType fromJson(String json) {
    return FederationType.fromApiValue(json) ?? FederationType.international;
  } // fallback if needed

  @override
  String toJson(FederationType object) => object.apiValue;
}