// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'federation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FederationModel _$FederationModelFromJson(Map<String, dynamic> json) =>
    _FederationModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      type: const FederationTypeConverter().fromJson(json['type'] as String),
      streetAddress: json['address'] as String,
      postCode: json['postalCode'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      fedLogo: json['logoUrl'] as String?,
      documents: json['documents'] as List<dynamic>? ?? const [],
      status: json['status'] as String?,
      createdDate: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      memberFederationIdsWhenCreation:
          (json['memberFederationIdsWhenCreation'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      parentFederationIdsWhenCreation:
          (json['parentFederationIdsWhenCreation'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
      parentCount: (json['parentCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$FederationModelToJson(
  _FederationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'type': const FederationTypeConverter().toJson(instance.type),
  'address': instance.streetAddress,
  'postalCode': instance.postCode,
  'city': instance.city,
  'country': instance.country,
  'logoUrl': instance.fedLogo,
  'documents': instance.documents,
  'status': instance.status,
  'createdAt': instance.createdDate,
  'updatedAt': instance.updatedAt,
  'memberFederationIdsWhenCreation': instance.memberFederationIdsWhenCreation,
  'parentFederationIdsWhenCreation': instance.parentFederationIdsWhenCreation,
  'memberCount': instance.memberCount,
  'parentCount': instance.parentCount,
};
