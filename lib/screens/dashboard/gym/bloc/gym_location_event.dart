part of 'gym_location_bloc.dart';

@immutable
sealed class GymLocationEvent {}


//Get All Gym locations
class GetGymLocationEvent extends GymLocationEvent {
  GetGymLocationEvent();
}

//Kisi location  event
class KisiLocationEvent extends GymLocationEvent {
  final String locationId;
  KisiLocationEvent(this.locationId);
}



//open lock event
class OpenLockEvent extends GymLocationEvent {
  final String lockId;
  OpenLockEvent(this.lockId);
}