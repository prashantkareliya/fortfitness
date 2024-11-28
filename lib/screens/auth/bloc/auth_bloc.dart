import 'package:bloc/bloc.dart';
import 'package:fortfitness/screens/auth/model/login_request.dart';
import 'package:fortfitness/screens/auth/model/login_response.dart';
import 'package:meta/meta.dart';

import '../data/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<LoginUserEvent>((event, emit) => login(event, emit));
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
}
