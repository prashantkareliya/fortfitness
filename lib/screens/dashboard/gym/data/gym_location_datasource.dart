import 'package:flutter/material.dart';
import 'package:fortfitness/screens/dashboard/gym/model/location_claim_request.dart';

import '../../../../constants/constants.dart';
import '../../../../http_actions/app_http.dart';

class GymLocationDatasource extends HttpActions {
  Future<dynamic> getGymLocation() async {
    final response = await getMethod(ApiEndPoint.location);
    debugPrint("Get Gym location -  $response");
    return response;
  }


  Future<dynamic> claimLocation(
      {required LocationClaimRequest locationClaimRequest}) async {
    final response = await postMethod(ApiEndPoint.claimLocation,
        data: locationClaimRequest.toJson());
    debugPrint("claim location -  $response");
    return response;
  }
}
