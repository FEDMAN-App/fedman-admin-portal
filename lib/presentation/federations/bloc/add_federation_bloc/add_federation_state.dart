part of 'add_federation_bloc.dart';

@immutable
sealed class AddFederationState {}

final class AddFederationInitial extends AddFederationState {}

final class AddFederationLoading extends AddFederationState {}

final class AddFederationLoaded extends AddFederationState {
  final FederationModel federation;

  AddFederationLoaded({required this.federation});
}

final class AddFederationSuccess extends AddFederationState {
  final FederationModel federation;
  final String message;
  final bool isUpdate;

  AddFederationSuccess({
    required this.federation,
    required this.message,
    required this.isUpdate,
  });
}

final class AddFederationError extends AddFederationState {
  final String message;

  AddFederationError({required this.message});
}


final class FederationsLoading extends AddFederationState {}

final class FederationsSuccess extends AddFederationState {
  final List<FederationModel> federations;
  final String message;
  final int total;
  final int page;
  final int limit;
  final int totalPages;
  final bool isLoadingMore;

  FederationsSuccess({
    required this.federations,
    required this.message,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
    this.isLoadingMore = false,
  });

  FederationsSuccess copyWith({
    List<FederationModel>? federations,
    String? message,
    int? total,
    int? page,
    int? limit,
    int? totalPages,
    bool? isLoadingMore,
  }) {
    return FederationsSuccess(
      federations: federations ?? this.federations,
      message: message ?? this.message,
      total: total ?? this.total,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      totalPages: totalPages ?? this.totalPages,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
final class FederationsError extends AddFederationState {
  final String message;

  FederationsError({required this.message});
}

// File Upload States
final class FileUploadLoading extends AddFederationState {
  final String fileType; // 'logo' or 'documents'

  FileUploadLoading({required this.fileType});
}

final class FileUploadSuccess extends AddFederationState {
  final String fileType; // 'logo' or 'documents'
  final String message;
  final String? fileUrl;

  FileUploadSuccess({
    required this.fileType,
    required this.message,
    this.fileUrl,
  });
}

final class FileUploadError extends AddFederationState {
  final String fileType; // 'logo' or 'documents'
  final String message;

  FileUploadError({
    required this.fileType,
    required this.message,
  });
}