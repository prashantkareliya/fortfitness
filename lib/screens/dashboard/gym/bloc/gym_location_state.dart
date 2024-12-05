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
