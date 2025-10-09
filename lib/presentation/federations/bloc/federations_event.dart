part of 'federations_bloc.dart';

@immutable
sealed class FederationsEvent {}

class GetFederationsRequested extends FederationsEvent {
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
