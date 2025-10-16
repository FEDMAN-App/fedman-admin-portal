import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_discipline_event.dart';
part 'create_discipline_state.dart';

class CreateDisciplineBloc extends Bloc<CreateDisciplineEvent, CreateDisciplineState> {
  CreateDisciplineBloc() : super(CreateDisciplineInitial()) {
    on<CreateDisciplineEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
