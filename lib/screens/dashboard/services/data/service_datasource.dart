
import 'package:flutter/material.dart';
import 'package:fortfitness/constants/constants.dart';
import 'package:fortfitness/http_actions/app_http.dart';
import 'package:fortfitness/screens/dashboard/services/model/claim_service_request.dart';

class ServiceDatasource extends HttpActions {
  Future<dynamic> getAllServices() async {
    final response = await getMethod(ApiEndPoint.service);
    debugPrint("All Services -  $response");
    return response;
  }

  Future<dynamic> claimService(
      {required ClaimServiceRequest claimServiceRequest}) async {
    final response = await postMethod(ApiEndPoint.claimService,
        data: claimServiceRequest.toJson());
    debugPrint("claim service -  $response");
    return response;
  }
}