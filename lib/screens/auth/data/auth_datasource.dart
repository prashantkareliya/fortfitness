import 'package:flutter/material.dart';
import 'package:fortfitness/http_actions/app_http.dart';
import 'package:fortfitness/screens/auth/model/login_request.dart';

import '../../../constants/constants.dart';

class AuthDatasource extends HttpActions {
  Future<dynamic> loginUser(
      {required LoginRequest loginRequest}) async {
    final response = await postMethod(ApiEndPoint.login, data: loginRequest.toJson());
    debugPrint("Login User -  $response");
    return response;
  }
}