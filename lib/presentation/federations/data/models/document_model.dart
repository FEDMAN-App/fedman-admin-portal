import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_model.freezed.dart';
part 'document_model.g.dart';

@freezed
abstract class DocumentModel with _$DocumentModel {
  const factory DocumentModel({
    required String id,
    required String name,
    required int size,
     String? s3Key,
     String? s3Url,
    required DateTime uploadedAt,
  }) = _DocumentModel;

  factory DocumentModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentModelFromJson(json);
}