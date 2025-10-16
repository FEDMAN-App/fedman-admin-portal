part of 'discipline_bloc.dart';

@immutable
sealed class DisciplineEvent {}

class GetDisciplinesRequested extends DisciplineEvent {
  final int page;
  final String? search;
  final bool? status;
  final String? sportType;
  final bool? hasRanking;

  GetDisciplinesRequested({
    this.page = 1,
    this.search,
    this.status,
    this.sportType,
    this.hasRanking,
  });
}

class GetDisciplineRequested extends DisciplineEvent {
  final int disciplineId;

  GetDisciplineRequested({required this.disciplineId});
}

class UpdateDisciplineRequested extends DisciplineEvent {
  final int disciplineId;
  final DisciplineModel discipline;

  UpdateDisciplineRequested({
    required this.disciplineId,
    required this.discipline,
  });
}

class ActivateDisciplineRequested extends DisciplineEvent {
  final int disciplineId;

  ActivateDisciplineRequested({required this.disciplineId});
}

class DeactivateDisciplineRequested extends DisciplineEvent {
  final int disciplineId;

  DeactivateDisciplineRequested({required this.disciplineId});
}

class DeleteDisciplineRequested extends DisciplineEvent {
  final int disciplineId;

  DeleteDisciplineRequested({required this.disciplineId});
}
