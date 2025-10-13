

import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:fedman_admin_app/presentation/federations/data/models/document_model.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/federation_repo.dart';

part 'federation_document_event.dart';
part 'federation_document_state.dart';

class FederationDocumentBloc extends Bloc<FederationDocumentEvent, FederationDocumentState> {
  final FederationRepo federationRepo;
  FederationDocumentBloc(this.federationRepo) : super(FederationDocumentInitial()) {
    on<GetFederationDocumentRequested>(_onGetFederationDocumentRequested);
    on<DeleteFederationDocumentRequested>(_onRemoveFederationDocumentRequested);
    on<UploadFederationDocumentRequested>(_onUploadFederationDocumentRequested);
  }


  Future<void> _onGetFederationDocumentRequested(
      GetFederationDocumentRequested event,
      Emitter<FederationDocumentState> emit,
      ) async {
    try {
      emit(FederationDocumentLoading());

      final result = await federationRepo.getFederationDoc(docId:event.docId,fedId:event.fedId);

      if (result.success && result.data != null) {
        emit(FederationDocumentLoaded(documentUrl: result.data!));
      } else {
        emit(FederationDocumentError(message: result.message ?? 'Failed to load federation logo'));
      }
    } catch (e) {
      emit(FederationDocumentError(message: 'Error loading federation logo: $e'));
    }
  }



  Future<void> _onRemoveFederationDocumentRequested(
      DeleteFederationDocumentRequested event,
      Emitter<FederationDocumentState> emit,
      ) async {
    try {
      emit(FederationDocumentRemoveLoading());

      final result = await federationRepo.deleteFederationDoc(docId:event.docId,fedId:event.fedId);

      if (result.success && result.data != null) {
        emit(FederationDocumentRemoved());
      } else {
        emit(FederationDocumentRemoveError(message: result.message ?? 'Failed to delete document'));
      }
    } catch (e) {
      emit(FederationDocumentRemoveError(message: 'Error deleting document: $e'));
    }
  }

  Future<void> _onUploadFederationDocumentRequested(
      UploadFederationDocumentRequested event,
      Emitter<FederationDocumentState> emit,
      ) async {
    try {
      emit(FederationDocumentUploadLoading());


      final result = await federationRepo.uploadFederationDocuments(
        federationId: event.fedId,
        fileName: event.fileName,
        documentsFileBytes: event.fileBytes
      );

      if (result.success) {

        final docsResult = await federationRepo.getFederationDocs(
            fedId: event.fedId,


        );
        if(docsResult.success){

        emit(FederationDocumentUploaded(message: result.message ?? 'Document uploaded successfully',docs: docsResult.data ??[]));
        }else{
          emit(FederationDocumentUploadError(message: docsResult.message ?? "Docs couldn't fetch"));
        }
      } else {
        emit(FederationDocumentUploadError(message: result.message ?? 'Failed to upload document'));
      }
    } catch (e) {
      emit(FederationDocumentUploadError(message: 'Error uploading document: $e'));
    }
  }
}
