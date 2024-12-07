part of 'service_bloc.dart';

@immutable
sealed class ServiceEvent {}

//Get All services event
class GetServiceEvent extends ServiceEvent {
  GetServiceEvent();
}


//Update user event
class ClaimServiceEvent extends ServiceEvent {
  final ClaimServiceRequest claimServiceRequest;
  ClaimServiceEvent(this.claimServiceRequest);
}
