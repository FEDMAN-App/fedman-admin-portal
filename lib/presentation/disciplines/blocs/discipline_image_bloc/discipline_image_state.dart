part of 'discipline_image_bloc.dart';

@immutable
sealed class DisciplineImageState {}

final class DisciplineImageInitial extends DisciplineImageState {}

final class DisciplineImageLoading extends DisciplineImageState {}

final class DisciplineImageUploading extends DisciplineImageState {}

final class DisciplineImageLoaded extends DisciplineImageState {
  final String imageUrl;

   DisciplineImageLoaded({required this.imageUrl});
}

final class DisciplineImageUploaded extends DisciplineImageState {
  final String imageUrl;
  final String message;

   DisciplineImageUploaded({
    required this.imageUrl,
    required this.message,
  });
}

final class DisciplineImageDeleted extends DisciplineImageState {
  final String message;

   DisciplineImageDeleted({required this.message});
}

final class DisciplineImageError extends DisciplineImageState {
  final String message;

   DisciplineImageError({required this.message});
}