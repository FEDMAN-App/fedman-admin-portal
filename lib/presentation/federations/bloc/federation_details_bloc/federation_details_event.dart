part of 'federation_details_bloc.dart';

@immutable
sealed class FederationDetailsEvent {}


class GetFederationRequested extends FederationDetailsEvent{

 final int id;

  GetFederationRequested(this.id);
}

class DeleteFederationRequested extends FederationDetailsEvent{

 final int id;

  DeleteFederationRequested(this.id);
}
