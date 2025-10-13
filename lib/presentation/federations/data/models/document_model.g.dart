// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocumentModel _$DocumentModelFromJson(Map<String, dynamic> json) =>
    _DocumentModel(
      id: json['id'] as String,
      name: json['name'] as String,
      size: (json['size'] as num).toInt(),
      s3Key: json['s3Key'] as String?,
      s3Url: json['s3Url'] as String?,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
    );

Map<String, dynamic> _$DocumentModelToJson(_DocumentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'size': instance.size,
      's3Key': instance.s3Key,
      's3Url': instance.s3Url,
      'uploadedAt': instance.uploadedAt.toIso8601String(),
    };
