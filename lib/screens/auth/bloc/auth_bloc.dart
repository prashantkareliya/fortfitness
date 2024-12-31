import 'package:bloc/bloc.dart';
import 'package:fortfitness/screens/auth/model/forgot_password_request.dart';
import 'package:fortfitness/screens/auth/model/forgot_password_response.dart';
import 'package:fortfitness/screens/auth/model/login_request.dart';
import 'package:fortfitness/screens/auth/model/login_response.dart';
import 'package:fortfitness/screens/auth/model/regestration_response.dart';
import 'package:meta/meta.dart';

import '../data/auth_repository.dart';
import '../model/regestration_request.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<LoginUserEvent>((event, emit) => login(event, emit));
    on<RegistrationEvent>((event, emit) => registrationEvent(event, emit));
    on<ForgotPasswordEvent>((event, emit) => forgotPasswordEvent(event, emit));
  }

  login(LoginUserEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoading(true));
    final response =
        await authRepository.signInUser(loginRequest: event.loginRequest);
    response.when(success: (success) {
      emit(LoginLoading(false));
      emit(LoginLoaded(loginResponse: success));
    }, failure: (failure) {
      emit(LoginLoading(false));
      emit(LoginFailure(failure.toString()));
    });
  }

  registrationEvent(RegistrationEvent event, Emitter<AuthState> emit) async {
    emit(RegistrationLoading(true));
    final response = await authRepository.registerUser(
        registrationRequest: event.registrationRequest);
    response.when(success: (success) {
      emit(RegistrationLoading(false));
      emit(RegistrationLoaded(registrationResponse: success));
    }, failure: (failure) {
      emit(RegistrationLoading(false));
      emit(RegistrationFailure(failure.toString()));
    });
  }

  forgotPasswordEvent(
      ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    emit(FPLoading(true));
    final response = await authRepository.forgotPassword(
        forgotPasswordRequest: event.forgotPasswordRequest);
    response.when(success: (success) {
      emit(FPLoading(false));
      emit(FPLoaded(forgotPasswordResponse: success));
    }, failure: (failure) {
      emit(FPLoading(false));
      emit(FPFailure(failure.toString()));
    });
  }
}
