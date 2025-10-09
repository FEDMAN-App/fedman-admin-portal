import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'federations_event.dart';
part 'federations_state.dart';

class FederationsBloc extends Bloc<FederationsEvent, FederationsState> {
  FederationsBloc() : super(FederationsInitial()) {
    on<FederationsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
