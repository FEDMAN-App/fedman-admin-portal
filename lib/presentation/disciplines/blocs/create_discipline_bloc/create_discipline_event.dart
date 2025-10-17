part of 'create_discipline_bloc.dart';

@immutable
sealed class CreateDisciplineEvent {}

class SubmitCreateDisciplineForm extends CreateDisciplineEvent {
  final DisciplineModel discipline;

  SubmitCreateDisciplineForm({
    required this.discipline,
  });
}

class SubmitUpdateDisciplineForm extends CreateDisciplineEvent {
  final DisciplineModel discipline;

  SubmitUpdateDisciplineForm({
    required this.discipline,
  });
}

class FetchDisciplineForEdit extends CreateDisciplineEvent {
  final int disciplineId;

  FetchDisciplineForEdit({
    required this.disciplineId,
  });
}
