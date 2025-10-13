import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'federation_document_event.dart';
part 'federation_document_state.dart';

class FederationDocumentBloc extends Bloc<FederationDocumentEvent, FederationDocumentState> {
  FederationDocumentBloc() : super(FederationDocumentInitial()) {
    on<FederationDocumentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
