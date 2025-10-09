part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class GetUserRequested extends UserEvent {
  final String userId;

  GetUserRequested({required this.userId});
}
