import 'package:bloc/bloc.dart';
import 'package:fortfitness/screens/dashboard/discount/model/discount_claim_request.dart';
import 'package:fortfitness/screens/dashboard/discount/model/discount_claim_response.dart';
import 'package:fortfitness/screens/dashboard/discount/model/get_discount_response.dart';
import 'package:meta/meta.dart';

import '../data/discount_repository.dart';

part 'discount_event.dart';

part 'discount_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  final DiscountRepository discountRepository;

  DiscountBloc(this.discountRepository) : super(DiscountInitial()) {
    on<DiscountEvent>((event, emit) {});
    on<GetDiscountEvent>((event, emit) => getDiscount(event, emit));
    on<ClaimDiscountEvent>((event, emit) => discountClaim(event, emit));
  }

  getDiscount(GetDiscountEvent event, Emitter<DiscountState> emit) async {
    emit(DiscountLoading(true));
    final response = await discountRepository.getDiscount();
    response.when(success: (success) {
      emit(DiscountLoading(false));
      emit(DiscountLoaded(discountResponse: success));
    }, failure: (failure) {
      emit(DiscountLoading(false));
      emit(DiscountFailure(failure.toString()));
    });
  }

  discountClaim(ClaimDiscountEvent event, Emitter<DiscountState> emit) async {
    emit(ClaimDiscountLoading(true));
    final response = await discountRepository.claimDiscount(
        discountClaimRequest: event.discountClaimRequest);
    response.when(success: (success) {
      emit(ClaimDiscountLoading(false));
      emit(ClaimDiscountLoaded(discountClaimResponse: success));
    }, failure: (failure) {
      emit(ClaimDiscountLoading(false));
      emit(ClaimDiscountFailure(failure.toString()));
    });
  }
}
