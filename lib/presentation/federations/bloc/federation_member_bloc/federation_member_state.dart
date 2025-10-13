part of 'federation_member_bloc.dart';

@immutable
sealed class FederationMemberState {}

final class FederationMemberInitial extends FederationMemberState {}

final class MembersLoading extends FederationMemberState {}

final class MembersLoaded extends FederationMemberState {
  final List<FederationMemberModel> members;

   MembersLoaded({required this.members});
}

final class MembersError extends FederationMemberState {
  final String message;

   MembersError({required this.message});
}

final class MembersAdding extends FederationMemberState {}

final class MembersAdded extends FederationMemberState {
  final String message;
  
   MembersAdded({required this.message});
}

final class MembersAddedError extends FederationMemberState {
  final String message;
  
   MembersAddedError({required this.message});
}
