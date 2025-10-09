import 'package:bloc/bloc.dart';
import 'package:fedman_admin_app/core/utils/error_handler.dart';
import 'package:fedman_admin_app/core/utils/logger_service.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../data/models/federation_model.dart';
import '../../data/repositories/federation_repo.dart';

part 'add_federation_event.dart';
part 'add_federation_state.dart';

class AddFederationBloc extends Bloc<AddFederationEvent, AddFederationState> {
  final FederationRepo federationRepo;

  AddFederationBloc({required this.federationRepo}) : super(AddFederationInitial()) {
    on<CreateFederationRequested>(_onCreateFederationRequested);
    on<UpdateFederationRequested>(_onUpdateFederationRequested);
    on<LoadFederationForEditRequested>(_onLoadFederationForEditRequested);
    on<GetFederationsRequested>(_onGetFederationsRequested);
  }


  Future<void> _onGetFederationsRequested(
      GetFederationsRequested event,
      Emitter<AddFederationState> emit,
      ) async {
    try {
      emit(FederationsLoading());

      final result = await federationRepo.getFederations(
        page: event.page,
        search: event.search,
        federationType: event.federationType,
        country: event.country,
      );

      if (result.success && result.data != null) {
        final paginatedData = result.data!;
        emit(FederationsSuccess(
          federations: paginatedData.items,
          message: result.message ?? 'Federations loaded successfully',
          total: paginatedData.total,
          page: paginatedData.page,
          limit: paginatedData.limit,
          totalPages: paginatedData.totalPages,
        ));
      } else {
        emit(FederationsError(message: result.message ?? 'Failed to load federations'));
      }
    } catch (e) {
      final error = ErrorHandler.handleError(e);
      GetIt.I.get<LoggerService>().e(error);
      emit(FederationsError(message: 'Error loading federations: $error'));
    }
  }



  Future<void> _onCreateFederationRequested(
    CreateFederationRequested event,
    Emitter<AddFederationState> emit,
  ) async {
    try {
      emit(AddFederationLoading());

      final result = await federationRepo.createFederation(event.federation);

      if (result.success && result.data != null) {
        emit(AddFederationSuccess(
          federation: result.data!,
          message: result.message ?? 'Federation created successfully',
          isUpdate: false,
        ));
      } else {
        emit(AddFederationError(message: result.message ?? 'Failed to create federation'));
      }
    } catch (e) {
      final error = ErrorHandler.handleError(e);
      GetIt.I.get<LoggerService>().e(error);
      emit(AddFederationError(message: 'Error creating federation: $error'));
    }
  }

  Future<void> _onUpdateFederationRequested(
    UpdateFederationRequested event,
    Emitter<AddFederationState> emit,
  ) async {
    try {
      emit(AddFederationLoading());

      final result = await federationRepo.updateFederation(event.federationId, event.federation);

      if (result.success && result.data != null) {
        emit(AddFederationSuccess(
          federation: result.data!,
          message: result.message ?? 'Federation updated successfully',
          isUpdate: true,
        ));
      } else {
        emit(AddFederationError(message: result.message ?? 'Failed to update federation'));
      }
    } catch (e) {
      final error = ErrorHandler.handleError(e);
      GetIt.I.get<LoggerService>().e(error);
      emit(AddFederationError(message: 'Error updating federation: $error'));
    }
  }

  Future<void> _onLoadFederationForEditRequested(
    LoadFederationForEditRequested event,
    Emitter<AddFederationState> emit,
  ) async {
    try {
      emit(AddFederationLoading());

      final result = await federationRepo.getFederationById(event.federationId);

      if (result.success && result.data != null) {
        emit(AddFederationLoaded(federation: result.data!));
      } else {
        emit(AddFederationError(message: result.message ?? 'Failed to load federation'));
      }
    } catch (e) {
      final error = ErrorHandler.handleError(e);
      GetIt.I.get<LoggerService>().e(error);
      emit(AddFederationError(message: 'Error loading federation: $error'));
    }
  }
}
