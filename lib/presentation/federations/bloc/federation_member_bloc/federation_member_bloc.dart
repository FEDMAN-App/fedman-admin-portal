import 'package:bloc/bloc.dart';
import 'package:fedman_admin_app/presentation/federations/data/models/federation_member_model.dart';
import 'package:meta/meta.dart';
import '../../data/models/federation_model.dart';
import '../../data/repositories/federation_repo.dart';

part 'federation_member_event.dart';
part 'federation_member_state.dart';

class FederationMemberBloc extends Bloc<FederationMemberEvent, FederationMemberState> {
  final FederationRepo federationRepo;

  FederationMemberBloc({required this.federationRepo}) : super(FederationMemberInitial()) {
    on<GetFederationMembers>(_onGetFederationMembers);
    on<AddFederationMembers>(_onAddFederationMembers);
  }

  Future<void> _onGetFederationMembers(
    GetFederationMembers event,
    Emitter<FederationMemberState> emit,
  ) async {
    try {
      emit(MembersLoading());
      
      final result = event.federationType.toLowerCase() == 'international' || 
                    event.federationType.toLowerCase() == 'continental'
          ? await federationRepo.getMembers(event.federationId)
          : await federationRepo.getAffiliations(event.federationId);
      
      if (result.success && result.data != null) {
        emit(MembersLoaded(members: result.data!));
      } else {
        emit(MembersError(message: result.message ?? 'Failed to load federation members'));
      }
    } catch (e) {
      emit(MembersError(message: 'Error: $e'));
    }
  }

  Future<void> _onAddFederationMembers(
    AddFederationMembers event,
    Emitter<FederationMemberState> emit,
  ) async {
    try {
      emit(MembersAdding());
      
      final result = event.federationType.toLowerCase() == 'international' || 
                    event.federationType.toLowerCase() == 'continental'
          ? await federationRepo.setMemberFederations(event.federationId, event.memberIds)
          : await federationRepo.setFederationAffiliations(event.federationId, event.memberIds);
      
      if (result.success) {
        emit(MembersAdded(message: result.message ?? 'Members added successfully'));
      } else {
        emit(MembersAddedError(message: result.message ?? 'Failed to add members'));
      }
    } catch (e) {
      emit(MembersAddedError(message: 'Error: $e'));
    }
  }
}
