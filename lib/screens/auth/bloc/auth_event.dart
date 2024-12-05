part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

//User login event
class LoginUserEvent extends AuthEvent {
  final LoginRequest loginRequest;
  LoginUserEvent(this.loginRequest);
}

//User registration event
class RegistrationEvent extends AuthEvent {
  final RegistrationRequest registrationRequest;
  RegistrationEvent(this.registrationRequest);
}

//Forgot password event
class ForgotPasswordEvent extends AuthEvent {
  final ForgotPasswordRequest forgotPasswordRequest;
  ForgotPasswordEvent(this.forgotPasswordRequest);
}