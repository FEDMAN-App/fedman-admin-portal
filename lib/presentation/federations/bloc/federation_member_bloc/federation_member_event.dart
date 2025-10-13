part of 'federation_member_bloc.dart';

@immutable
sealed class FederationMemberEvent {}

final class GetFederationMembers extends FederationMemberEvent {
  final int federationId;
  final String federationType;
  
  GetFederationMembers({
    required this.federationId,
    required this.federationType,
  });
}

final class AddFederationMembers extends FederationMemberEvent {
  final int federationId;
  final String federationType;
  final List<int> memberIds;
  
  AddFederationMembers({
    required this.federationId,
    required this.federationType,
    required this.memberIds,
  });
}
