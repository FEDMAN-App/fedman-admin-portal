// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discipline_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DisciplineModel _$DisciplineModelFromJson(Map<String, dynamic> json) =>
    _DisciplineModel(
      id: json['id'] as String,
      name: json['name'] as String,
      levels: (json['levels'] as num).toInt(),
      rankingEnabled: json['rankingEnabled'] as bool,
      levelNames: (json['levelNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      description: json['description'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$DisciplineModelToJson(_DisciplineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'levels': instance.levels,
      'rankingEnabled': instance.rankingEnabled,
      'levelNames': instance.levelNames,
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isActive': instance.isActive,
    };
