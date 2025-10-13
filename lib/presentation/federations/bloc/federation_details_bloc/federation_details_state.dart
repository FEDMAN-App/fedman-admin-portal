part of 'federation_details_bloc.dart';

@immutable
sealed class FederationDetailsState {}

final class FederationDetailsInitial extends FederationDetailsState {}




final class FederationLoading extends FederationDetailsState {}

final class FederationLoaded extends FederationDetailsState {
  final FederationModel federation;

  FederationLoaded({required this.federation});
}


final class GetFederationError extends FederationDetailsState {
  final String message;

  GetFederationError({required this.message});
}

final class FederationDeleting extends FederationDetailsState {}

final class FederationDeleted extends FederationDetailsState {
  final String message;

  FederationDeleted({required this.message});
}

final class DeleteFederationError extends FederationDetailsState {
  final String message;

  DeleteFederationError({required this.message});
}