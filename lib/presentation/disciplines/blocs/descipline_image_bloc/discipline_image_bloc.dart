import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'discipline_image_event.dart';
part 'discipline_image_state.dart';

class DisciplineImageBloc extends Bloc<DisciplineImageEvent, DisciplineImageState> {
  DisciplineImageBloc() : super(DisciplineImageInitial()) {
    on<DisciplineImageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
