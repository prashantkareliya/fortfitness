import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fortfitness/constants/constants.dart';
import 'package:fortfitness/main.dart';
import 'package:fortfitness/screens/auth/auth_selection.dart';
import 'package:fortfitness/screens/profile/data/profile_repository.dart';
import 'package:fortfitness/screens/profile/model/logout_response.dart';
import 'package:fortfitness/screens/profile/model/profile_response.dart';
import 'package:fortfitness/screens/profile/model/update_profile_request.dart';
import 'package:fortfitness/screens/profile/model/update_profile_response.dart';
import 'package:fortfitness/utils/helpers.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../constants/strings.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  String endPoint = Constants.of().endpoint;

  ProfileBloc(this.profileRepository) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});

    on<GetProfileEvent>((event, emit) => getUserProfile(event, emit));
    on<UpdateProfileEvent>((event, emit) => updateProfile(event, emit));
    on<LogoutEvent>((event, emit) => logoutEvent(event, emit));
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

  logoutEvent(LogoutEvent event, Emitter<ProfileState> emit) async {
    SharedPreferences? preferences = await SharedPreferences.getInstance();

    if (event is LogoutEvent) {

      emit(LogoutLoading(true));
      try {
        Map<String, String> headers = {
          'Authorization': 'Bearer ${preferences.getString(PreferenceString.accessToken).toString()}',
        };
        final response = await http.put(
            Uri.parse('$endPoint${ApiEndPoint.logout}'),
            headers: headers);

        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = json.decode(response.body);
          LogoutResponse logoutResponse = LogoutResponse.fromJson(responseData);
          emit(LogoutLoaded(logoutResponse: logoutResponse));
        } else if(response.statusCode == 401) {
          await logout();
        } else {
          emit(LogoutFailure("Logout failed"));
        }
      } catch (e) {
        emit(LogoutFailure('An error occurred: $e'));
      }
    }
  }
}
