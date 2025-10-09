part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final FedmanUserModel user;
  final String message;

  UserSuccess({
    required this.user,
    required this.message,
  });
}

final class UserError extends UserState {
  final String message;

  UserError({required this.message});
}
