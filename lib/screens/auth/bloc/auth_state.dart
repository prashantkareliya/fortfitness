part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

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
