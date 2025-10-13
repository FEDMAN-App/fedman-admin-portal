import 'package:fedman_admin_app/presentation/federations/data/models/document_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/federation_types.dart';

part 'federation_model.freezed.dart';
part 'federation_model.g.dart';

@freezed
@freezed
abstract class FederationModel with _$FederationModel {
  const factory FederationModel({
    @JsonKey(includeIfNull: false) int? id,
    required String name,
    @FederationTypeConverter() required FederationType type,
    @JsonKey(name: 'address') required String streetAddress,
    @JsonKey(name: 'postalCode') required String postCode,
    required String city,
    required String country,
    @JsonKey(includeIfNull: false,name: 'logoUrl') String? fedLogo,
    @JsonKey(includeIfNull: false, toJson: _dynamicListToJson) @Default([]) List<DocumentModel> documents,
    @JsonKey(includeIfNull: false) String? status,
    @JsonKey(name: 'createdAt',includeIfNull: false) String? createdDate,
    @JsonKey(name: 'updatedAt',includeIfNull: false) String? updatedAt,
    @JsonKey(includeIfNull: false, toJson: _listToJson)  List<int>? memberFederationIds,
    @JsonKey(includeIfNull: false, toJson: _listToJson)  List<int>? parentFederationIds,
    @JsonKey(includeIfNull: false) int? memberCount,
    @JsonKey(includeIfNull: false) int? parentCount,
  }) = _FederationModel;

  factory FederationModel.fromJson(Map<String, dynamic> json) =>
      _$FederationModelFromJson(json);
}

List<int>? _listToJson(List<int>? list) {
  return (list?.isEmpty ?? true) ? null : list;
}
List<dynamic>? _dynamicListToJson(List<dynamic>? list) {
  return (list?.isEmpty ?? true) ? null : list;
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