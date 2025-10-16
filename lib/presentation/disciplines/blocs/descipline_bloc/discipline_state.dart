part of 'discipline_bloc.dart';

@immutable
sealed class DisciplineState {}

final class DisciplineInitial extends DisciplineState {}

final class DisciplinesLoading extends DisciplineState {}

final class DisciplinesLoaded extends DisciplineState {
  final PaginatedResponse<DisciplineModel> disciplines;
  final bool hasReachedMax;

   DisciplinesLoaded({
    required this.disciplines,
    this.hasReachedMax = false,
  });
}

final class DisciplineLoading extends DisciplineState {}

final class DisciplineLoaded extends DisciplineState {
  final DisciplineModel discipline;

   DisciplineLoaded({required this.discipline});
}

final class DisciplinesError extends DisciplineState {
  final String message;

   DisciplinesError({required this.message});
}

final class DisciplineError extends DisciplineState {
  final String message;

   DisciplineError({required this.message});
}

final class DisciplineOperationSuccess extends DisciplineState {
  final String message;

   DisciplineOperationSuccess({required this.message});
}
