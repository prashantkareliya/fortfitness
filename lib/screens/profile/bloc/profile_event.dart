part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

//Get User event
class GetProfileEvent extends ProfileEvent {
  GetProfileEvent();
}

//Update user event
class UpdateProfileEvent extends ProfileEvent {
  final UpdateProfileRequest updateProfileRequest;
  UpdateProfileEvent(this.updateProfileRequest);
}
