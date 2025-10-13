import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:fedman_admin_app/core/utils/error_handler.dart';
import 'package:fedman_admin_app/core/utils/logger_service.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

import '../../data/models/federation_model.dart';
import '../../data/repositories/federation_repo.dart';

part 'add_federation_event.dart';
part 'add_federation_state.dart';

class AddFederationBloc extends Bloc<AddFederationEvent, AddFederationState> {
  final FederationRepo federationRepo;
  List<int> memberFederationIds = [];
  List<int> parentFederationIds = [];

  AddFederationBloc({required this.federationRepo}) : super(AddFederationInitial()) {
    on<CreateFederationRequested>(_onCreateFederationRequested);
    on<UpdateFederationRequested>(_onUpdateFederationRequested);
    on<LoadFederationForEditRequested>(_onLoadFederationForEditRequested);
    on<GetFederationsRequested>(_onGetFederationsRequested);
    on<LoadMoreFederationsRequested>(_onLoadMoreFederationsRequested);
    on<UploadFederationLogoRequested>(_onUploadFederationLogoRequested);
    on<UploadFederationDocumentsRequested>(_onUploadFederationDocumentsRequested);
    on<UploadMultipleFederationDocumentsRequested>(_onUploadMultipleFederationDocumentsRequested);
  }

  String? _validateFederation(FederationModel federation) {
    if (federation.name.trim().isEmpty) {
      return 'Please enter federation name';
    }

    if (federation.country.trim().isEmpty) {
      return 'Please select Country';
    }

    if (federation.city.trim().isEmpty) {
      return 'Please select City';
    }

    if (federation.streetAddress.trim().isEmpty) {
      return 'Please add street address';
    }

    if (federation.postCode.trim().isEmpty) {
      return 'Please add postal code';
    }

    // Logo validation - required for federation creation
    if (federation.fedLogo == null || federation.fedLogo!.isEmpty) {
      return 'Please provide a federation logo';
    }

    // Validation for International and Continental federations
    if (federation.type.apiValue == 'INTERNATIONAL' || 
        federation.type.apiValue == 'CONTINENTAL') {
      if (memberFederationIds.isEmpty) {
        return '${federation.type.displayName} federations must have at least one member federation';
      }
    }else if(federation.type.apiValue == 'NO_TYPE_SELECTED') {
      return 'Please select federation type';
    }

    return null; // No validation errors
  }


  Future<void> _onGetFederationsRequested(
      GetFederationsRequested event,
      Emitter<AddFederationState> emit,
      ) async {
    try {
      emit(FederationsLoading());

      final result = await federationRepo.getFederations(
        page: event.page,
        search: event.search,
        federationType: event.federationType,
        country: event.country,
      );

      if (result.success && result.data != null) {
        final paginatedData = result.data!;
        emit(FederationsSuccess(
          federations: paginatedData.items,
          message: result.message ?? 'Federations loaded successfully',
          total: paginatedData.total,
          page: paginatedData.page,
          limit: paginatedData.limit,
          totalPages: paginatedData.totalPages,
        ));
      } else {
        emit(FederationsError(message: result.message ?? 'Failed to load federations'));
      }
    } catch (e) {
      final error = ErrorHandler.handleError(e);
      GetIt.I.get<LoggerService>().e(error);
      emit(FederationsError(message: 'Error loading federations: $error'));
    }
  }

  Future<void> _onLoadMoreFederationsRequested(
    LoadMoreFederationsRequested event,
    Emitter<AddFederationState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is! FederationsSuccess) return;

      emit(currentState.copyWith(isLoadingMore: true));

      final result = await federationRepo.getFederations(
        page: event.page,
        search: event.search,
        federationType: event.federationType,
        country: event.country,
      );

      if (result.success && result.data != null) {
        final paginatedData = result.data!;
        final updatedFederations = [...currentState.federations, ...paginatedData.items];
        
        emit(FederationsSuccess(
          federations: updatedFederations,
          message: result.message ?? 'More federations loaded successfully',
          total: paginatedData.total,
          page: paginatedData.page,
          limit: paginatedData.limit,
          totalPages: paginatedData.totalPages,
          isLoadingMore: false,
        ));
      } else {
        emit(currentState.copyWith(isLoadingMore: false));
        emit(FederationsError(message: result.message ?? 'Failed to load more federations'));
      }
    } catch (e) {
      final currentState = state;
      if (currentState is FederationsSuccess) {
        emit(currentState.copyWith(isLoadingMore: false));
      }
      final error = ErrorHandler.handleError(e);
      GetIt.I.get<LoggerService>().e(error);
      emit(FederationsError(message: 'Error loading more federations: $error'));
    }
  }

  Future<void> _onCreateFederationRequested(
    CreateFederationRequested event,
    Emitter<AddFederationState> emit,
  ) async {
    try {
      emit(AddFederationLoading());

      // Validate federation data
      final validationError = _validateFederation(event.federation);
      if (validationError != null) {
        emit(AddFederationError(message: validationError));
        return;
      }

      // Create federation with appropriate federation IDs
      final federationToCreate = event.federation.copyWith(
        memberFederationIds: (event.federation.type.apiValue == 'INTERNATIONAL' ||
                                         event.federation.type.apiValue == 'CONTINENTAL') 
                                         ? memberFederationIds 
                                         : [],
        parentFederationIds: (event.federation.type.apiValue == 'NATIONAL' ||
                                         event.federation.type.apiValue == 'REGIONAL') 
                                         ? parentFederationIds 
                                         : [],
      );

      final result = await federationRepo.createFederation(federationToCreate);

      if (result.success && result.data != null) {
        // // Clear the lists after successful creation
        // memberFederationIds.clear();
        // parentFederationIds.clear();
        
        emit(AddFederationSuccess(
          federation: result.data!,
          message: result.message ?? 'Federation created successfully',
          isUpdate: false,
        ));
      } else {
        emit(AddFederationError(message: result.message ?? 'Failed to create federation'));
      }
    } catch (e) {
      final error = ErrorHandler.handleError(e);
      GetIt.I.get<LoggerService>().e(error);
      emit(AddFederationError(message: 'Error creating federation: $error'));
    }
  }

  Future<void> _onUpdateFederationRequested(
    UpdateFederationRequested event,
    Emitter<AddFederationState> emit,
  ) async {
    try {
      emit(AddFederationLoading());

      // Validate federation data
      final validationError = _validateFederation(event.federation);
      if (validationError != null) {
        emit(AddFederationError(message: validationError));
        return;
      }

      final result = await federationRepo.updateFederation(event.federationId, event.federation);

      if (result.success && result.data != null) {
        emit(AddFederationSuccess(
          federation: result.data!,
          message: result.message ?? 'Federation updated successfully',
          isUpdate: true,
        ));
      } else {
        emit(AddFederationError(message: result.message ?? 'Failed to update federation'));
      }
    } catch (e) {
      final error = ErrorHandler.handleError(e);
      GetIt.I.get<LoggerService>().e(error);
      emit(AddFederationError(message: 'Error updating federation: $error'));
    }
  }

  Future<void> _onLoadFederationForEditRequested(
    LoadFederationForEditRequested event,
    Emitter<AddFederationState> emit,
  ) async {
    try {
      emit(AddFederationLoading());

      final result = await federationRepo.getFederationById(event.federationId);

      if (result.success && result.data != null) {

        emit(AddFederationLoaded(federation: result.data!));
      } else {
        emit(AddFederationError(message: result.message ?? 'Failed to load federation'));
      }
    } catch (e) {
      final error = ErrorHandler.handleError(e);
      GetIt.I.get<LoggerService>().e(error);
      emit(AddFederationError(message: 'Error loading federation: $error'));
    }
  }

  Future<void> _onUploadFederationLogoRequested(
    UploadFederationLogoRequested event,
    Emitter<AddFederationState> emit,
  ) async {
    try {
      emit(FileUploadLoading(fileType: 'logo'));

      final result = await federationRepo.uploadFederationLogo(
        federationId: event.federationId,
        logoFileBytes: event.logoFileBytes,
        fileName: event.fileName,
      );

      if (result.success) {
        emit(FileUploadSuccess(
          fileType: 'logo',
          message: result.message ?? 'Logo uploaded successfully',
          fileUrl: result.data,
        ));
      } else {
        emit(FileUploadError(
          fileType: 'logo',
          message: result.message ?? 'Failed to upload logo',
        ));
      }
    } catch (e) {
      final error = ErrorHandler.handleError(e);
      GetIt.I.get<LoggerService>().e(error);
      emit(FileUploadError(
        fileType: 'logo',
        message: 'Error uploading logo: $error',
      ));
    }
  }

  Future<void> _onUploadFederationDocumentsRequested(
    UploadFederationDocumentsRequested event,
    Emitter<AddFederationState> emit,
  ) async {
    try {
      emit(FileUploadLoading(fileType: 'documents'));

      final result = await federationRepo.uploadFederationDocuments(
        federationId: event.federationId,
        documentsFileBytes: event.documentsFileBytes,
        fileName: event.fileName,
      );

      if (result.success) {
        emit(FileUploadSuccess(
          fileType: 'documents',
          message: result.message ?? 'Documents uploaded successfully',
          fileUrl: result.data,
        ));
      } else {
        emit(FileUploadError(
          fileType: 'documents',
          message: result.message ?? 'Failed to upload documents',
        ));
      }
    } catch (e) {
      final error = ErrorHandler.handleError(e);
      GetIt.I.get<LoggerService>().e(error);
      emit(FileUploadError(
        fileType: 'documents',
        message: 'Error uploading documents: $error',
      ));
    }
  }

  Future<void> _onUploadMultipleFederationDocumentsRequested(
    UploadMultipleFederationDocumentsRequested event,
    Emitter<AddFederationState> emit,
  ) async {
    try {
      emit(FileUploadLoading(fileType: 'documents'));

      // Upload all documents sequentially
      for (final document in event.documents) {
        final result = await federationRepo.uploadFederationDocuments(
          federationId: event.federationId,
          documentsFileBytes: document.bytes,
          fileName: document.fileName,
        );

        if (!result.success) {
          emit(FileUploadError(
            fileType: 'documents',
            message: result.message ?? 'Failed to upload document "${document.fileName}"',
          ));
          return;
        }
      }

      // All documents uploaded successfully
      emit(FileUploadSuccess(
        fileType: 'documents',
        message: 'All documents uploaded successfully (${event.documents.length} files)',
        fileUrl: null,
      ));
    } catch (e) {
      final error = ErrorHandler.handleError(e);
      GetIt.I.get<LoggerService>().e(error);
      emit(FileUploadError(
        fileType: 'documents',
        message: 'Error uploading documents: $error',
      ));
    }
  }
}
