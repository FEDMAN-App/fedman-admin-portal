import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'federation_details_event.dart';
part 'federation_details_state.dart';

class FederationDetailsBloc extends Bloc<FederationDetailsEvent, FederationDetailsState> {
  FederationDetailsBloc() : super(FederationDetailsInitial()) {
    on<FederationDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
