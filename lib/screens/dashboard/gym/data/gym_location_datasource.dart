import 'package:flutter/material.dart';
import 'package:fortfitness/screens/dashboard/gym/model/unlock_request.dart';

import '../../../../constants/constants.dart';
import '../../../../http_actions/app_http.dart';

class GymLocationDatasource extends HttpActions {
  Future<dynamic> getGymLocation() async {
    final response = await getMethod(ApiEndPoint.location);
    debugPrint("Get Gym location -  $response");
    return response;
  }
}
