import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/enums/sport_types.dart';
import '../../data/models/discipline_model.dart';
import '../../data/repositories/discipline_repo.dart';

part 'create_discipline_event.dart';
part 'create_discipline_state.dart';

class CreateDisciplineBloc extends Bloc<CreateDisciplineEvent, CreateDisciplineState> {
  final DisciplineRepo disciplineRepo;

  CreateDisciplineBloc({required this.disciplineRepo}) : super(CreateDisciplineInitial()) {
    on<SubmitCreateDisciplineForm>(_onSubmitCreateDisciplineForm);
    on<SubmitUpdateDisciplineForm>(_onSubmitUpdateDisciplineForm);
    on<FetchDisciplineForEdit>(_onFetchDisciplineForEdit);
  }

  Future<void> _onSubmitCreateDisciplineForm(
    SubmitCreateDisciplineForm event,
    Emitter<CreateDisciplineState> emit,
  ) async {
    try {
      emit(CreateDisciplineLoading());

      final result = await disciplineRepo.createDiscipline(event.discipline);

      if (result.success && result.data != null) {
        emit(CreateDisciplineSuccess(message: result.message ?? 'Discipline created successfully'));
      } else {
        emit(CreateDisciplineError(message: result.message ?? 'Failed to create discipline'));
      }
    } catch (e) {
      emit(CreateDisciplineError(message: 'Error: $e'));
    }
  }

  Future<void> _onSubmitUpdateDisciplineForm(
    SubmitUpdateDisciplineForm event,
    Emitter<CreateDisciplineState> emit,
  ) async {
    try {
      emit(CreateDisciplineLoading());

      final result = await disciplineRepo.updateDiscipline(event.discipline.id!, event.discipline);

      if (result.success && result.data != null) {
        emit(CreateDisciplineSuccess(message: result.message ?? 'Discipline updated successfully'));
      } else {
        emit(CreateDisciplineError(message: result.message ?? 'Failed to update discipline'));
      }
    } catch (e) {
      emit(CreateDisciplineError(message: 'Error: $e'));
    }
  }

  Future<void> _onFetchDisciplineForEdit(
    FetchDisciplineForEdit event,
    Emitter<CreateDisciplineState> emit,
  ) async {
    try {
      emit(FetchDisciplineLoading());

      final result = await disciplineRepo.getDiscipline(event.disciplineId);

      if (result.success && result.data != null) {
        emit(FetchDisciplineSuccess(discipline: result.data!));
      } else {
        emit(FetchDisciplineError(message: result.message ?? 'Failed to fetch discipline'));
      }
    } catch (e) {
      emit(FetchDisciplineError(message: 'Error: $e'));
    }
  }
}
