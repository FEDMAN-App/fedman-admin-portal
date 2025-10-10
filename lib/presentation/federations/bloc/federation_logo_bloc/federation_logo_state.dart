part of 'federation_logo_bloc.dart';

@immutable
sealed class FederationLogoState {}

final class FederationLogoInitial extends FederationLogoState {}

final class FederationLogoLoading extends FederationLogoState {}

final class FederationLogoLoaded extends FederationLogoState {
  final String logoUrl;

  FederationLogoLoaded({required this.logoUrl});
}

final class FederationLogoError extends FederationLogoState {
  final String message;

  FederationLogoError({required this.message});
}

