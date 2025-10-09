part of 'federations_bloc.dart';

@immutable
sealed class FederationsState {}

final class FederationsInitial extends FederationsState {}

final class FederationsLoading extends FederationsState {}

final class FederationsSuccess extends FederationsState {
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

final class FederationsError extends FederationsState {
  final String message;

   FederationsError({required this.message});
}
