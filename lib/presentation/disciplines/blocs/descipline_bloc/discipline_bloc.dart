import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/network/paginated_response.dart';
import '../../data/models/discipline_model.dart';
import '../../data/repositories/discipline_repo.dart';

part 'descipline_event.dart';
part 'discipline_state.dart';

class DisciplineBloc extends Bloc<DisciplineEvent, DisciplineState> {
  final DisciplineRepo disciplineRepo;

  DisciplineBloc({required this.disciplineRepo}) : super(DisciplineInitial()) {
    on<GetDisciplinesRequested>(_onGetDisciplinesRequested);
    on<GetDisciplineRequested>(_onGetDisciplineRequested);
    on<UpdateDisciplineRequested>(_onUpdateDisciplineRequested);
    on<ActivateDisciplineRequested>(_onActivateDisciplineRequested);
    on<DeactivateDisciplineRequested>(_onDeactivateDisciplineRequested);
    on<DeleteDisciplineRequested>(_onDeleteDisciplineRequested);
  }

  Future<void> _onGetDisciplinesRequested(
    GetDisciplinesRequested event,
    Emitter<DisciplineState> emit,
  ) async {
    try {
      emit(DisciplinesLoading());
      final result = await disciplineRepo.getDisciplines(
        page: event.page,
        search: event.search,
        status: event.status,
        sportType: event.sportType,
        hasRanking: event.hasRanking,
      );

      if (result.success && result.data != null) {
        emit(DisciplinesLoaded(disciplines: result.data!));
      } else {
        emit(DisciplinesError(message: result.message ?? 'Failed to get disciplines'));
      }
    } catch (e) {
      emit(DisciplinesError(message: 'Error: $e'));
    }
  }

  Future<void> _onGetDisciplineRequested(
    GetDisciplineRequested event,
    Emitter<DisciplineState> emit,
  ) async {
    try {
      emit(DisciplineLoading());
      final result = await disciplineRepo.getDiscipline(event.disciplineId);

      if (result.success && result.data != null) {
        emit(DisciplineLoaded(discipline: result.data!));
      } else {
        emit(DisciplineError(message: result.message ?? 'Failed to get discipline'));
      }
    } catch (e) {
      emit(DisciplineError(message: 'Error: $e'));
    }
  }

  Future<void> _onUpdateDisciplineRequested(
    UpdateDisciplineRequested event,
    Emitter<DisciplineState> emit,
  ) async {
    try {
      emit(DisciplineLoading());
      final result = await disciplineRepo.updateDiscipline(
        event.disciplineId,
        event.discipline,
      );

      if (result.success && result.data != null) {
        emit(DisciplineOperationSuccess(message: result.message ?? 'Discipline updated successfully'));
      } else {
        emit(DisciplineError(message: result.message ?? 'Failed to update discipline'));
      }
    } catch (e) {
      emit(DisciplineError(message: 'Error: $e'));
    }
  }

  Future<void> _onActivateDisciplineRequested(
    ActivateDisciplineRequested event,
    Emitter<DisciplineState> emit,
  ) async {
    try {
      emit(DisciplineLoading());
      final result = await disciplineRepo.activateDiscipline(event.disciplineId);

      if (result.success) {
        emit(DisciplineOperationSuccess(message: result.message ?? 'Discipline activated successfully'));
      } else {
        emit(DisciplineError(message: result.message ?? 'Failed to activate discipline'));
      }
    } catch (e) {
      emit(DisciplineError(message: 'Error: $e'));
    }
  }

  Future<void> _onDeactivateDisciplineRequested(
    DeactivateDisciplineRequested event,
    Emitter<DisciplineState> emit,
  ) async {
    try {
      emit(DisciplineLoading());
      final result = await disciplineRepo.deactivateDiscipline(event.disciplineId);

      if (result.success) {
        emit(DisciplineOperationSuccess(message: result.message ?? 'Discipline deactivated successfully'));
      } else {
        emit(DisciplineError(message: result.message ?? 'Failed to deactivate discipline'));
      }
    } catch (e) {
      emit(DisciplineError(message: 'Error: $e'));
    }
  }

  Future<void> _onDeleteDisciplineRequested(
    DeleteDisciplineRequested event,
    Emitter<DisciplineState> emit,
  ) async {
    try {
      emit(DisciplineLoading());
      final result = await disciplineRepo.deleteDiscipline(event.disciplineId);

      if (result.success) {
        emit(DisciplineOperationSuccess(message: result.message ?? 'Discipline deleted successfully'));
      } else {
        emit(DisciplineError(message: result.message ?? 'Failed to delete discipline'));
      }
    } catch (e) {
      emit(DisciplineError(message: 'Error: $e'));
    }
  }
}
