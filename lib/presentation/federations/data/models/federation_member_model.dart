import 'package:freezed_annotation/freezed_annotation.dart';

part 'federation_member_model.freezed.dart';
part 'federation_member_model.g.dart';

@freezed
abstract class FederationMemberModel with _$FederationMemberModel {
  const factory FederationMemberModel({
    required int id,
    required String name,
    required String country,
    required String city,
    required String joinedAt,
  }) = _FederationMemberModel;

  factory FederationMemberModel.fromJson(Map<String, dynamic> json) =>
      _$FederationMemberModelFromJson(json);
}