part of 'federation_document_bloc.dart';

@immutable
sealed class FederationDocumentEvent {}
class GetFederationDocumentRequested extends FederationDocumentEvent {
  final String docId;
  final int fedId;

  GetFederationDocumentRequested({required this.docId,required this.fedId});


}


class DeleteFederationDocumentRequested extends FederationDocumentEvent {
  final String docId;
  final int fedId;

  DeleteFederationDocumentRequested({required this.docId,required this.fedId});
}

class UploadFederationDocumentRequested extends FederationDocumentEvent {
  final int fedId;
  final Uint8List fileBytes;
  final String fileName;

  UploadFederationDocumentRequested({
    required this.fedId,
    required this.fileBytes,
    required this.fileName,
  });
}