part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

//Get Profile states
class ProfileLoading extends ProfileState {
  final bool isBusy;

  ProfileLoading(this.isBusy);
}

class ProfileLoaded extends ProfileState {
  ProfileResponse profileResponse;

  ProfileLoaded({required this.profileResponse});
}

class ProfileFailure extends ProfileState {
  final String error;

  ProfileFailure(this.error);
}

//Update Profile states
class UpdateProfileLoading extends ProfileState {
  final bool isBusy;

  UpdateProfileLoading(this.isBusy);
}

class UpdateProfileLoaded extends ProfileState {
  UpdateProfileResponse updateProfileResponse;

  UpdateProfileLoaded({required this.updateProfileResponse});
}

class UpdateProfileFailure extends ProfileState {
  final String error;

  UpdateProfileFailure(this.error);
}

//Logout states
class LogoutLoading extends ProfileState {
  final bool isBusy;
  LogoutLoading(this.isBusy);
}

class LogoutLoaded extends ProfileState {
  LogoutResponse logoutResponse;
  LogoutLoaded({required this.logoutResponse});
}

class LogoutFailure extends ProfileState {
  final String error;
  LogoutFailure(this.error);
}
