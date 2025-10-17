

import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/discipline_repo.dart';

part 'discipline_image_event.dart';
part 'discipline_image_state.dart';

class DisciplineImageBloc extends Bloc<DisciplineImageEvent, DisciplineImageState> {
  final DisciplineRepo disciplineRepo;

  DisciplineImageBloc({required this.disciplineRepo}) : super(DisciplineImageInitial()) {
    on<GetDisciplineImageRequested>(_onGetDisciplineImageRequested);
    on<UploadDisciplineImageRequested>(_onUploadDisciplineImageRequested);
    on<DeleteDisciplineImageRequested>(_onDeleteDisciplineImageRequested);
  }

  Future<void> _onGetDisciplineImageRequested(
    GetDisciplineImageRequested event,
    Emitter<DisciplineImageState> emit,
  ) async {
    try {
      emit(DisciplineImageLoading());
      final result = await disciplineRepo.getDisciplineImage(event.disciplineId);

      if (result.success && result.data != null) {
        emit(DisciplineImageLoaded(imageUrl: result.data!));
      } else {
        emit(DisciplineImageError(message: result.message ?? 'Failed to get discipline image'));
      }
    } catch (e) {
      emit(DisciplineImageError(message: 'Error: $e'));
    }
  }

  Future<void> _onUploadDisciplineImageRequested(
    UploadDisciplineImageRequested event,
    Emitter<DisciplineImageState> emit,
  ) async {
    try {
      emit(DisciplineImageUploading());
      final result = await disciplineRepo.uploadDisciplineImage(
      disciplineId:   event.disciplineId,
       logoFileBytes:  event.imageBytes,
       fileName: event.fileName,

      );

      if (result.success && result.data != null) {
        emit(DisciplineImageUploaded(
          imageUrl: result.data!,
          message: result.message ?? 'Image uploaded successfully',
        ));
      } else {
        emit(DisciplineImageError(message: result.message ?? 'Failed to upload image'));
      }
    } catch (e) {
      emit(DisciplineImageError(message: 'Error: $e'));
    }
  }

  Future<void> _onDeleteDisciplineImageRequested(
    DeleteDisciplineImageRequested event,
    Emitter<DisciplineImageState> emit,
  ) async {
    try {
      emit(DisciplineImageLoading());
      final result = await disciplineRepo.deleteDisciplineImage(event.disciplineId);

      if (result.success) {
        emit(DisciplineImageDeleted(message: result.message ?? 'Image deleted successfully'));
      } else {
        emit(DisciplineImageError(message: result.message ?? 'Failed to delete image'));
      }
    } catch (e) {
      emit(DisciplineImageError(message: 'Error: $e'));
    }
  }
}