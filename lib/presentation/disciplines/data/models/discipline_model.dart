import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/sport_types.dart';

part 'discipline_model.freezed.dart';
part 'discipline_model.g.dart';

@freezed
abstract class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required String categoryName,
    required List<String> categoryValues,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}

@freezed
abstract class LevelModel with _$LevelModel {
  const factory LevelModel({
    required String levelName,
    required List<CategoryModel> categories,
    required List<String> classTypes,
  }) = _LevelModel;

  factory LevelModel.fromJson(Map<String, dynamic> json) =>
      _$LevelModelFromJson(json);
}

@Freezed(toJson: true)
abstract class DisciplineModel with _$DisciplineModel {
  const factory DisciplineModel({
    required int id,
    required String name,
    required List<LevelModel> levels,
    required bool hasRanking,
    required SportType sportType,
    @JsonKey(includeIfNull: false) String? logoUrl,
    required String status,
    @JsonKey(includeIfNull: false) DateTime? createdAt,
    @JsonKey(includeIfNull: false) DateTime? updatedAt,
  }) = _DisciplineModel;

  factory DisciplineModel.fromJson(Map<String, dynamic> json) =>
      _$DisciplineModelFromJson(json);
}