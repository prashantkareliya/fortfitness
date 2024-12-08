import 'package:bloc/bloc.dart';
import 'package:fortfitness/screens/dashboard/gym/model/gym_location_response.dart';
import 'package:fortfitness/screens/dashboard/gym/model/location_claim_request.dart';
import 'package:fortfitness/screens/dashboard/gym/model/location_claim_response.dart';
import 'package:meta/meta.dart';

import '../data/gym_location_repository.dart';

part 'gym_location_event.dart';
part 'gym_location_state.dart';

class GymLocationBloc extends Bloc<GymLocationEvent, GymLocationState> {
  final GymLocationRepository gymLocationRepository;

  GymLocationBloc(this.gymLocationRepository) : super(GymLocationInitial()) {
    on<GymLocationEvent>((event, emit) {});
    on<GetGymLocationEvent>((event, emit) => getGymLocation(event, emit));
    on<ClaimLocationEvent>((event, emit) => claimLocation(event, emit));
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

  claimLocation(
      ClaimLocationEvent event, Emitter<GymLocationState> emit) async {
    emit(ClaimLocationLoading(true));
    final response = await gymLocationRepository.claimLocation(
        locationClaimRequest: event.locationClaimRequest);
    response.when(success: (success) {
      emit(ClaimLocationLoading(false));
      emit(ClaimLocationLoaded(locationClaimResponse: success));
    }, failure: (failure) {
      emit(ClaimLocationLoading(false));
      emit(ClaimLocationFailure(failure.toString()));
    });
  }
}
