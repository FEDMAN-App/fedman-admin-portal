// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discipline_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    _CategoryModel(
      categoryName: json['categoryName'] as String,
      categoryValues: (json['categoryValues'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CategoryModelToJson(_CategoryModel instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'categoryValues': instance.categoryValues,
    };

_LevelModel _$LevelModelFromJson(Map<String, dynamic> json) => _LevelModel(
  levelName: json['levelName'] as String,
  categories: (json['categories'] as List<dynamic>)
      .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  classTypes: (json['classTypes'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$LevelModelToJson(_LevelModel instance) =>
    <String, dynamic>{
      'levelName': instance.levelName,
      'categories': instance.categories,
      'classTypes': instance.classTypes,
    };

_DisciplineModel _$DisciplineModelFromJson(Map<String, dynamic> json) =>
    _DisciplineModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      levels: (json['levels'] as List<dynamic>)
          .map((e) => LevelModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasRanking: json['hasRanking'] as bool,
      sportType: $enumDecode(_$SportTypeEnumMap, json['sportType']),
      logoUrl: json['logoUrl'] as String?,
      status: json['status'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DisciplineModelToJson(_DisciplineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'levels': instance.levels,
      'hasRanking': instance.hasRanking,
      'sportType': _$SportTypeEnumMap[instance.sportType]!,
      'logoUrl': ?instance.logoUrl,
      'status': instance.status,
      'createdAt': ?instance.createdAt?.toIso8601String(),
      'updatedAt': ?instance.updatedAt?.toIso8601String(),
    };

const _$SportTypeEnumMap = {
  SportType.dogSports: 'DOG_SPORTS',
  SportType.horseSports: 'HORSE_SPORTS',
};
