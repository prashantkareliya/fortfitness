import 'package:bloc/bloc.dart';
import 'package:fortfitness/screens/dashboard/services/model/claim_service_request.dart';
import 'package:fortfitness/screens/dashboard/services/model/claim_service_response.dart';
import 'package:fortfitness/screens/dashboard/services/model/service_response_model.dart';
import 'package:meta/meta.dart';

import '../data/service_repository.dart';

part 'service_event.dart';

part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceRepository serviceRepository;

  ServiceBloc(this.serviceRepository) : super(ServiceInitial()) {
    on<ServiceEvent>((event, emit) {});
    on<GetServiceEvent>((event, emit) => getServices(event, emit));
    on<ClaimServiceEvent>((event, emit) => claimService(event, emit));
  }

  getServices(GetServiceEvent event, Emitter<ServiceState> emit) async {
    emit(ServiceLoading(true));
    final response = await serviceRepository.getService();
    response.when(success: (success) {
      emit(ServiceLoading(false));
      emit(ServiceLoaded(serviceResponse: success));
    }, failure: (failure) {
      emit(ServiceLoading(false));
      emit(ServiceFailure(failure.toString()));
    });
  }

  claimService(ClaimServiceEvent event, Emitter<ServiceState> emit) async {
    emit(ClaimServiceLoading(true));
    final response = await serviceRepository.claimService(
        claimServiceRequest: event.claimServiceRequest);
    response.when(success: (success) {
      emit(ClaimServiceLoading(false));
      emit(ClaimServiceLoaded(claimServiceResponse: success));
    }, failure: (failure) {
      emit(ClaimServiceLoading(false));
      emit(ClaimServiceFailure(failure.toString()));
    });
  }
}
