part of 'discipline_image_bloc.dart';

@immutable
sealed class DisciplineImageEvent {}

class GetDisciplineImageRequested extends DisciplineImageEvent {
  final int disciplineId;

  GetDisciplineImageRequested({required this.disciplineId});
}

class UploadDisciplineImageRequested extends DisciplineImageEvent {
  final int disciplineId;
  final File imageFile;

  UploadDisciplineImageRequested({
    required this.disciplineId,
    required this.imageFile,
  });
}

class DeleteDisciplineImageRequested extends DisciplineImageEvent {
  final int disciplineId;

  DeleteDisciplineImageRequested({required this.disciplineId});
}