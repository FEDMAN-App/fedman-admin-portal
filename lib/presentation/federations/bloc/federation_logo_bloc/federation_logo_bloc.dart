import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/repositories/federation_repo.dart';

part 'federation_logo_event.dart';
part 'federation_logo_state.dart';

class FederationLogoBloc extends Bloc<FederationLogoEvent, FederationLogoState> {
  final FederationRepo federationRepo;

  FederationLogoBloc({required this.federationRepo}) : super(FederationLogoInitial()) {
    on<GetFederationLogoRequested>(_onGetFederationLogoRequested);
  }

  Future<void> _onGetFederationLogoRequested(
    GetFederationLogoRequested event,
    Emitter<FederationLogoState> emit,
  ) async {
    try {
      emit(FederationLogoLoading());
      
      final result = await federationRepo.getFederationLogo(event.federationId);
      
      if (result.success && result.data != null) {
        emit(FederationLogoLoaded(logoUrl: result.data!));
      } else {
        emit(FederationLogoError(message: result.message ?? 'Failed to load federation logo'));
      }
    } catch (e) {
      emit(FederationLogoError(message: 'Error loading federation logo: $e'));
    }
  }
}
