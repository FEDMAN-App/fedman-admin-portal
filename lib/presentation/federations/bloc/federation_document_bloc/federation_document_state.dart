part of 'federation_document_bloc.dart';

@immutable
sealed class FederationDocumentState {}

final class FederationDocumentInitial extends FederationDocumentState {}
final class FederationDocumentLoading extends FederationDocumentState {}

final class FederationDocumentLoaded extends FederationDocumentState {
  final String documentUrl;

  FederationDocumentLoaded({required this.documentUrl});
}

final class FederationDocumentError extends FederationDocumentState {
  final String message;

  FederationDocumentError({required this.message});
}



final class FederationDocumentRemoveLoading extends FederationDocumentState {}

final class FederationDocumentRemoved extends FederationDocumentState {

}

final class FederationDocumentRemoveError extends FederationDocumentState {
  final String message;

  FederationDocumentRemoveError({required this.message});
}

final class FederationDocumentUploadLoading extends FederationDocumentState {}

final class FederationDocumentUploaded extends FederationDocumentState {
  final String message;
final List<DocumentModel> docs;
  FederationDocumentUploaded({required this.message, required this.docs});
}

final class FederationDocumentUploadError extends FederationDocumentState {
  final String message;

  FederationDocumentUploadError({required this.message});
}