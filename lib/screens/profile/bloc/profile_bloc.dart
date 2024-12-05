import 'package:bloc/bloc.dart';
import 'package:fortfitness/screens/profile/data/profile_repository.dart';
import 'package:fortfitness/screens/profile/model/profile_response.dart';
import 'package:fortfitness/screens/profile/model/update_profile_request.dart';
import 'package:fortfitness/screens/profile/model/update_profile_response.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc(this.profileRepository) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});

    on<GetProfileEvent>((event, emit) => getUserProfile(event, emit));
    on<UpdateProfileEvent>((event, emit) => updateProfile(event, emit));
  }

  getUserProfile(GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading(true));
    final response = await profileRepository.getProfile();
    response.when(success: (success) {
      emit(ProfileLoading(false));
      emit(ProfileLoaded(profileResponse: success));
    }, failure: (failure) {
      emit(ProfileLoading(false));
      emit(ProfileFailure(failure.toString()));
    });
  }

  updateProfile(UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(UpdateProfileLoading(true));
    final response = await profileRepository.updateProfile(
        updateProfileRequest: event.updateProfileRequest);
    response.when(success: (success) {
      emit(UpdateProfileLoading(false));
      emit(UpdateProfileLoaded(updateProfileResponse: success));
    }, failure: (failure) {
      emit(UpdateProfileLoading(false));
      emit(UpdateProfileFailure(failure.toString()));
    });
  }
}
