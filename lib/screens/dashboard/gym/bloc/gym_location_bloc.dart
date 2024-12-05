import 'package:bloc/bloc.dart';
import 'package:fortfitness/screens/dashboard/gym/model/gym_location_response.dart';
import 'package:meta/meta.dart';

import '../data/gym_location_repository.dart';

part 'gym_location_event.dart';

part 'gym_location_state.dart';

class GymLocationBloc extends Bloc<GymLocationEvent, GymLocationState> {
  final GymLocationRepository gymLocationRepository;

  GymLocationBloc(this.gymLocationRepository) : super(GymLocationInitial()) {
    on<GymLocationEvent>((event, emit) {});
    on<GetGymLocationEvent>((event, emit) => getGymLocation(event, emit));
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
}
