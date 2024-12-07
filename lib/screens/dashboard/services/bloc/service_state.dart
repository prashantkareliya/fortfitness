part of 'service_bloc.dart';

@immutable
sealed class ServiceState {}

final class ServiceInitial extends ServiceState {}

//Get all services states
class ServiceLoading extends ServiceState {
  final bool isBusy;
  ServiceLoading(this.isBusy);
}

class ServiceLoaded extends ServiceState {
  ServiceResponse serviceResponse;
  ServiceLoaded({required this.serviceResponse});
}

class ServiceFailure extends ServiceState {
  final String error;
  ServiceFailure(this.error);
}

//Claim services states
class ClaimServiceLoading extends ServiceState {
  final bool isBusy;
  ClaimServiceLoading(this.isBusy);
}

class ClaimServiceLoaded extends ServiceState {
  ClaimServiceResponse claimServiceResponse;
  ClaimServiceLoaded({required this.claimServiceResponse});
}

class ClaimServiceFailure extends ServiceState {
  final String error;
  ClaimServiceFailure(this.error);
}