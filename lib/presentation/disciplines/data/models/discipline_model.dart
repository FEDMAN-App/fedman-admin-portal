import 'package:freezed_annotation/freezed_annotation.dart';

part 'discipline_model.freezed.dart';
part 'discipline_model.g.dart';

@freezed
abstract class DisciplineModel with _$DisciplineModel {
  const factory DisciplineModel({
    required String id,
    required String name,
    required int levels,
    required bool rankingEnabled,
    required List<String> levelNames,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) = _DisciplineModel;

  factory DisciplineModel.fromJson(Map<String, dynamic> json) =>
      _$DisciplineModelFromJson(json);
}