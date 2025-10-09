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

  FederationsSuccess({
    required this.federations,
    required this.message,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });
}
final class FederationsError extends AddFederationState {
  final String message;

  FederationsError({required this.message});
}