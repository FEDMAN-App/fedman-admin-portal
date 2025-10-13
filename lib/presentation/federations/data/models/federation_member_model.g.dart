// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'federation_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FederationMemberModel _$FederationMemberModelFromJson(
  Map<String, dynamic> json,
) => _FederationMemberModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  country: json['country'] as String,
  city: json['city'] as String,
  joinedAt: json['joinedAt'] as String,
);

Map<String, dynamic> _$FederationMemberModelToJson(
  _FederationMemberModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'country': instance.country,
  'city': instance.city,
  'joinedAt': instance.joinedAt,
};
