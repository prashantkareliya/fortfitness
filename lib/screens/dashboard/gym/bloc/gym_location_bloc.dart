import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fortfitness/constants/strings.dart';
import 'package:fortfitness/screens/dashboard/gym/model/gym_location_response.dart';
import 'package:fortfitness/screens/dashboard/gym/model/kisi_response.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/gym_location_repository.dart';

part 'gym_location_event.dart';
part 'gym_location_state.dart';

class GymLocationBloc extends Bloc<GymLocationEvent, GymLocationState> {
  final GymLocationRepository gymLocationRepository;

  GymLocationBloc(this.gymLocationRepository) : super(GymLocationInitial()) {
    on<GymLocationEvent>((event, emit) {});
    on<GetGymLocationEvent>((event, emit) => getGymLocation(event, emit));
    on<KisiLocationEvent>((event, emit) => mapEventToState(event, emit));
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
            Uri.parse('http://143.110.244.228:8082/api/location/${event.locationId}/locks'),
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
}
