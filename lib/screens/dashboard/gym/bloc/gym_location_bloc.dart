import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fortfitness/constants/strings.dart';
import 'package:fortfitness/screens/dashboard/gym/model/gym_location_response.dart';
import 'package:fortfitness/screens/dashboard/gym/model/kisi_response.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/constants.dart';
import '../data/gym_location_repository.dart';

part 'gym_location_event.dart';
part 'gym_location_state.dart';

class GymLocationBloc extends Bloc<GymLocationEvent, GymLocationState> {
  final GymLocationRepository gymLocationRepository;
  String endPoint = Constants.of().endpoint;

  GymLocationBloc(this.gymLocationRepository) : super(GymLocationInitial()) {
    on<GymLocationEvent>((event, emit) {});
    on<GetGymLocationEvent>((event, emit) => getGymLocation(event, emit));
    on<KisiLocationEvent>((event, emit) => mapEventToState(event, emit));
    on<OpenLockEvent>((event, emit) => openGymLock(event, emit));
  }

  getGymLocation(
      GetGymLocationEvent event, Emitter<GymLocationState> emit) async {
    emit(GetGymLocationLoading(true));
    final response = await gymLocationRepository.getProfile();
    response.when(success: (success) {
      emit(GetGymLocationLoading(false));
      emit(GetGymLocationLoaded(gymLocationResponse: success));
    }, failure: (failure) {
      emit(GetGymLocationLoading(false));
      emit(GetGymLocationFailure(failure.toString()));
    });
  }

  mapEventToState(KisiLocationEvent event, emit) async {
   SharedPreferences? preferences = await SharedPreferences.getInstance();

    if (event is KisiLocationEvent) {
      emit(KisiLocationLoading(true));
      try {
        Map<String, String> headers = {
          'Content-Type': 'application/json', // Example header, can be customized
          'Authorization': 'Bearer ${preferences.getString(PreferenceString.accessToken).toString()}', // Optional, if you need auth
        };
        final response = await http.get(
            Uri.parse('${endPoint}location/${event.locationId}/locks'),
            headers: headers);

        if (response.statusCode == 200) {
          //KisiResponse kisiResponse = json.decode(response.body);
          Map<String, dynamic> responseData = json.decode(response.body);
          KisiResponse kisiResponse = KisiResponse.fromJson(responseData);
          emit(KisiLocationLoaded(kisiResponse: kisiResponse));
        } else {
          emit(KisiLocationFailure('Failed to load locks'));
        }
      } catch (e) {
        emit(KisiLocationFailure('An error occurred: $e'));
      }
    }
  }

  openGymLock(OpenLockEvent event, Emitter<GymLocationState> emit) async {
      SharedPreferences? preferences = await SharedPreferences.getInstance();

      if (event is OpenLockEvent) {
        emit(OpenLockLoading(true));
        try {
          Map<String, String> headers = {
            'Content-Type': 'application/json', // Example header, can be customized
            'Authorization': 'Bearer ${preferences.getString(PreferenceString.accessToken).toString()}', // Optional, if you need auth
          };
          final response = await http.post(
              Uri.parse('${endPoint}lock/:${event.lockId}/unlock'),
              headers: headers);

          if (response.statusCode == 200) {
            Map<String, dynamic> responseData = json.decode(response.body);
            KisiResponse kisiResponse = KisiResponse.fromJson(responseData);
            emit(OpenLockLoaded(kisiResponse: kisiResponse));
          } else {
            emit(OpenLockFailure('Failed to load locks'));
          }
        } catch (e) {
          emit(OpenLockFailure('An error occurred: $e'));
        }
      }
  }
}
