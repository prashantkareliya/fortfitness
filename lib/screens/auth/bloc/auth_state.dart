part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

//User Login states
class LoginLoading extends AuthState {
  final bool isBusy;
  LoginLoading(this.isBusy);
}

class LoginLoaded extends AuthState {
  LoginResponse loginResponse;
  LoginLoaded({required this.loginResponse});
}

class LoginFailure extends AuthState {
  final String error;
  LoginFailure(this.error);
}

//User Registration Password states
class RegistrationLoading extends AuthState {
  final bool isBusy;
  RegistrationLoading(this.isBusy);
}

class RegistrationLoaded extends AuthState {
  RegistrationResponse registrationResponse;
  RegistrationLoaded({required this.registrationResponse});
}

class RegistrationFailure extends AuthState {
  final String error;
  RegistrationFailure(this.error);
}

//Forgot Password states
class FPLoading extends AuthState {
  final bool isBusy;
  FPLoading(this.isBusy);
}

class FPLoaded extends AuthState {
  ForgotPasswordResponse forgotPasswordResponse;
  FPLoaded({required this.forgotPasswordResponse});
}

class FPFailure extends AuthState {
  final String error;
  FPFailure(this.error);
}
