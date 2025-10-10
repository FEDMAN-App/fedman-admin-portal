part of 'federation_logo_bloc.dart';

@immutable
sealed class FederationLogoEvent {}

class GetFederationLogoRequested extends FederationLogoEvent {
  final int federationId;

  GetFederationLogoRequested({required this.federationId});
}
