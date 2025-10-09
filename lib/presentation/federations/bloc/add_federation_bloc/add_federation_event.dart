part of 'add_federation_bloc.dart';

@immutable
sealed class AddFederationEvent {}

class CreateFederationRequested extends AddFederationEvent {
  final FederationModel federation;

  CreateFederationRequested({required this.federation});
}

class UpdateFederationRequested extends AddFederationEvent {
  final int federationId;
  final FederationModel federation;

  UpdateFederationRequested({
    required this.federationId,
    required this.federation,
  });
}

class LoadFederationForEditRequested extends AddFederationEvent {
  final int federationId;

  LoadFederationForEditRequested({required this.federationId});
}

class GetFederationsRequested extends AddFederationEvent {
  final int page;
  final String? search;
  final String? federationType;
  final String? country;

  GetFederationsRequested({
    this.page = 1,
    this.search,
    this.federationType,
    this.country,
  });
}
