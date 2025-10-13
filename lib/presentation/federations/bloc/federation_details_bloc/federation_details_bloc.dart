import 'package:bloc/bloc.dart';
import 'package:fedman_admin_app/presentation/federations/data/models/federation_model.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/error_handler.dart';
import '../../../../core/utils/logger_service.dart';
import '../../data/repositories/federation_repo.dart';

part 'federation_details_event.dart';
part 'federation_details_state.dart';

class FederationDetailsBloc extends Bloc<FederationDetailsEvent, FederationDetailsState> {

  final FederationRepo federationRepo;
  FederationDetailsBloc(this.federationRepo) : super(FederationDetailsInitial()) {
    on<GetFederationRequested>(_onGetFederationDetailsRequested);
    on<DeleteFederationRequested>(_onDeleteFederationRequested);
  }


  Future<void> _onGetFederationDetailsRequested(
      GetFederationRequested event,
      Emitter<FederationDetailsState> emit,
      ) async {
    try {
      emit(FederationLoading());

      final result = await federationRepo.getFederationById(event.id);

      if (result.success && result.data != null) {

        emit(FederationLoaded(federation: result.data!));
      } else {
        emit(GetFederationError(message: result.message ?? 'Failed to load federation'));
      }
    } catch (e) {
      final error = ErrorHandler.handleError(e);
      GetIt.I.get<LoggerService>().e(error);
      emit(GetFederationError(message: 'Error loading federation: $error'));
    }
  }

  Future<void> _onDeleteFederationRequested(
      DeleteFederationRequested event,
      Emitter<FederationDetailsState> emit,
      ) async {
    try {
      emit(FederationDeleting());

      final result = await federationRepo.deleteFederation(event.id);

      if (result.success) {
        emit(FederationDeleted(message: result.message ?? 'Federation deleted successfully'));
      } else {
        emit(DeleteFederationError(message: result.message ?? 'Failed to delete federation'));
      }
    } catch (e) {
      final error = ErrorHandler.handleError(e);
      GetIt.I.get<LoggerService>().e(error);
      emit(DeleteFederationError(message: 'Error deleting federation: $error'));
    }
  }


}
