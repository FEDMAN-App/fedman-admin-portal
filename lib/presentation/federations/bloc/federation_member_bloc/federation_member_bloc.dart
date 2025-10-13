import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'federation_member_event.dart';
part 'federation_member_state.dart';

class FederationMemberBloc extends Bloc<FederationMemberEvent, FederationMemberState> {
  FederationMemberBloc() : super(FederationMemberInitial()) {
    on<FederationMemberEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
