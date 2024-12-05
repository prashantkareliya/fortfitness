part of 'gym_location_bloc.dart';

@immutable
sealed class GymLocationEvent {}


//Get All Gym locations
class GetGymLocationEvent extends GymLocationEvent {
  GetGymLocationEvent();
}