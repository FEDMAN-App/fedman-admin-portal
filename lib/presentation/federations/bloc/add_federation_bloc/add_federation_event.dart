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

class LoadMoreFederationsRequested extends AddFederationEvent {
  final int page;
  final String? search;
  final String? federationType;
  final String? country;

  LoadMoreFederationsRequested({
    required this.page,
    this.search,
    this.federationType,
    this.country,
  });
}

class UploadFederationLogoRequested extends AddFederationEvent {
  final int federationId;
  final Uint8List logoFileBytes;
  final String? fileName;

  UploadFederationLogoRequested({
    required this.federationId,
    required this.logoFileBytes,
    this.fileName,
  });
}

class UploadFederationDocumentsRequested extends AddFederationEvent {
  final int federationId;
  final Uint8List documentsFileBytes;
  final String? fileName;

  UploadFederationDocumentsRequested({
    required this.federationId,
    required this.documentsFileBytes,
    this.fileName,
  });
}

class UploadMultipleFederationDocumentsRequested extends AddFederationEvent {
  final int federationId;
  final List<({Uint8List bytes, String? fileName})> documents;

  UploadMultipleFederationDocumentsRequested({
    required this.federationId,
    required this.documents,
  });
}
