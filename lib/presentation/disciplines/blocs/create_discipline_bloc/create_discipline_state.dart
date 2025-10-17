part of 'create_discipline_bloc.dart';

@immutable
sealed class CreateDisciplineState {}

final class CreateDisciplineInitial extends CreateDisciplineState {}

final class CreateDisciplineLoading extends CreateDisciplineState {}

final class CreateDisciplineSuccess extends CreateDisciplineState {
  final String message;
  
  CreateDisciplineSuccess({required this.message});
}

final class CreateDisciplineError extends CreateDisciplineState {
  final String message;
  
  CreateDisciplineError({required this.message});
}

final class FetchDisciplineLoading extends CreateDisciplineState {}

final class FetchDisciplineSuccess extends CreateDisciplineState {
  final DisciplineModel discipline;
  
  FetchDisciplineSuccess({required this.discipline});
}

final class FetchDisciplineError extends CreateDisciplineState {
  final String message;
  
  FetchDisciplineError({required this.message});
}
