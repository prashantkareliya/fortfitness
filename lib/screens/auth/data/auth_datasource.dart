import 'package:flutter/material.dart';
import 'package:fortfitness/http_actions/app_http.dart';
import 'package:fortfitness/screens/auth/model/forgot_password_request.dart';
import 'package:fortfitness/screens/auth/model/login_request.dart';
import 'package:fortfitness/screens/auth/model/regestration_request.dart';

import '../../../constants/constants.dart';

class AuthDatasource extends HttpActions {
  Future<dynamic> loginUser({required LoginRequest loginRequest}) async {
    final response = await postMethod(ApiEndPoint.login, data: loginRequest.toJson());
    debugPrint("Login User -  $response");
    return response;
  }

  Future<dynamic> registerUser(
      {required RegistrationRequest registrationRequest}) async {
    final response = await postMethod(ApiEndPoint.register, data: registrationRequest.toJson());
    debugPrint("Register User -  $response");
    return response;
  }

  Future<dynamic> forgotPassword(
      {required ForgotPasswordRequest forgotPasswordRequest}) async {
    final response = await postMethod(ApiEndPoint.forgotPassword, data: forgotPasswordRequest.toJson());
    debugPrint("forgot Password  -  $response");
    return response;
  }
}