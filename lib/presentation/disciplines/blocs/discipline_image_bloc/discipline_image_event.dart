part of 'discipline_image_bloc.dart';

@immutable
sealed class DisciplineImageEvent {}

class GetDisciplineImageRequested extends DisciplineImageEvent {
  final int disciplineId;

  GetDisciplineImageRequested({required this.disciplineId});
}

class UploadDisciplineImageRequested extends DisciplineImageEvent {
  final int disciplineId;
  final Uint8List imageBytes;
  final String fileName;

  UploadDisciplineImageRequested({
    required this.disciplineId,
    required this.imageBytes,
    required this.fileName,
  });
}

class DeleteDisciplineImageRequested extends DisciplineImageEvent {
  final int disciplineId;

  DeleteDisciplineImageRequested({required this.disciplineId});
}