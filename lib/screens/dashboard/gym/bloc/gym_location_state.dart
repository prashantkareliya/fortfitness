part of 'gym_location_bloc.dart';

@immutable
sealed class GymLocationState {}

final class GymLocationInitial extends GymLocationState {}

//Get Gym location states states
class GetGymLocationLoading extends GymLocationState {
  final bool isBusy;

  GetGymLocationLoading(this.isBusy);
}

class GetGymLocationLoaded extends GymLocationState {
  GymLocationResponse gymLocationResponse;

  GetGymLocationLoaded({required this.gymLocationResponse});
}

class GetGymLocationFailure extends GymLocationState {
  final String error;

  GetGymLocationFailure(this.error);
}



//Claim location states
class ClaimLocationLoading extends GymLocationState {
  final bool isBusy;
  ClaimLocationLoading(this.isBusy);
}

class ClaimLocationLoaded extends GymLocationState {
  LocationClaimResponse locationClaimResponse;
  ClaimLocationLoaded({required this.locationClaimResponse});
}

class ClaimLocationFailure extends GymLocationState {
  final String error;
  ClaimLocationFailure(this.error);
}