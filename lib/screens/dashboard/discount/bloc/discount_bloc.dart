import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:fortfitness/constants/constants.dart';
import 'package:fortfitness/constants/strings.dart';
import 'package:fortfitness/screens/dashboard/discount/model/discount_claim_request.dart';
import 'package:fortfitness/screens/dashboard/discount/model/discount_claim_response.dart';
import 'package:fortfitness/screens/dashboard/discount/model/get_discount_claim_detail_response.dart';
import 'package:fortfitness/screens/dashboard/discount/model/get_discount_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../data/discount_repository.dart';

part 'discount_event.dart';

part 'discount_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  final DiscountRepository discountRepository;
  String endPoint = Constants.of().endpoint;

  DiscountBloc(this.discountRepository) : super(DiscountInitial()) {
    on<DiscountEvent>((event, emit) {});
    on<GetDiscountEvent>((event, emit) => getDiscount(event, emit));
    on<ClaimDiscountEvent>((event, emit) => discountClaim(event, emit));
    on<DiscountClaimEvent>((event, emit) => getDiscountClaimDetail(event, emit));

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

  getDiscountClaimDetail(DiscountClaimEvent event, Emitter<DiscountState> emit) async {
    SharedPreferences? preferences = await SharedPreferences.getInstance();

    emit(GetClaimDiscountLoading(true));
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
        'Authorization':
        'Bearer ${preferences.getString(PreferenceString.accessToken).toString()}',
      };
      final response = await http.get(
          Uri.parse('${endPoint}user/discount/${event.discountId}/lock'),
          headers: headers);
      Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        GetDiscountClaimResponse getDiscountClaimResponse = GetDiscountClaimResponse.fromJson(responseData);
        emit(GetClaimDiscountLoaded(getDiscountClaimResponse: getDiscountClaimResponse));
      } else {
        emit(GetClaimDiscountFailure('You are too far away.'));
      }
    } catch (e) {
      emit(GetClaimDiscountFailure('An error occurred: $e'));
    }
  }
}
