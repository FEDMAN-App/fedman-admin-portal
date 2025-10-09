import 'package:bloc/bloc.dart';
import 'package:fedman_admin_app/core/utils/error_handler.dart';
import 'package:fedman_admin_app/core/utils/logger_service.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../data/models/federation_model.dart';
import '../data/repositories/federation_repo.dart';

part 'federations_event.dart';
part 'federations_state.dart';

class FederationsBloc extends Bloc<FederationsEvent, FederationsState> {
  final FederationRepo federationRepo;

  FederationsBloc({required this.federationRepo}) : super(FederationsInitial()) {
    on<GetFederationsRequested>(_onGetFederationsRequested);
  }

  Future<void> _onGetFederationsRequested(
    GetFederationsRequested event,
    Emitter<FederationsState> emit,
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
}
