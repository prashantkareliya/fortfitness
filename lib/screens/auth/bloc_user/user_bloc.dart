import 'package:bloc/bloc.dart';
import 'package:fortfitness/screens/profile/data/profile_repository.dart';
import 'package:fortfitness/screens/profile/model/profile_response.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ProfileRepository profileRepository;

  UserBloc(this.profileRepository) : super(const UserState()) {
    on<UserEvent>((event, emit) {});
    on<GetUserEvent>(getUserProfile);
  }

  getUserProfile(GetUserEvent event, Emitter<UserState> emit) async {
    final response = await profileRepository.getProfile();
    response.when(success: (success) {
      emit(state.copyWith(profileResponse: success));
    }, failure: (failure) {
      emit(state.copyWith(error: failure));
    });
  }
}
