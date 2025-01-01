import 'package:fortfitness/screens/auth/data/auth_datasource.dart';
import 'package:fortfitness/screens/auth/model/forgot_password_request.dart';
import 'package:fortfitness/screens/auth/model/forgot_password_response.dart';
import 'package:fortfitness/screens/auth/model/login_request.dart';
import 'package:fortfitness/screens/auth/model/login_response.dart';
import 'package:fortfitness/screens/auth/model/regestration_request.dart';
import 'package:fortfitness/screens/auth/model/regestration_response.dart';

import '../../../components/handle_api_error.dart';
import '../../../constants/constants.dart';
import '../../../http_actions/api_result.dart';

class AuthRepository {
  AuthRepository({required AuthDatasource authDatasource})
      : _authDatasource = authDatasource;
  final AuthDatasource _authDatasource;

  Future<ApiResult<LoginResponse>> signInUser(
      {required LoginRequest loginRequest}) async {
    try {
      final result =
          await _authDatasource.loginUser(loginRequest: loginRequest);

      LoginResponse loginResponse = LoginResponse.fromJson(result);

      if (loginResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: loginResponse);
      } else {
        return ApiResult.failure(error: loginResponse.message.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  Future<ApiResult<RegistrationResponse>> registerUser(
      {required RegistrationRequest registrationRequest}) async {
    try {
      final result = await _authDatasource.registerUser(
          registrationRequest: registrationRequest);

      RegistrationResponse registrationResponse =
          RegistrationResponse.fromJson(result);

      if (registrationResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: registrationResponse);
      } else {
        return ApiResult.failure(
            error: registrationResponse.message.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  Future<ApiResult<ForgotPasswordResponse>> forgotPassword(
      {required ForgotPasswordRequest forgotPasswordRequest}) async {
    try {
      final result = await _authDatasource.forgotPassword(
          forgotPasswordRequest: forgotPasswordRequest);

      ForgotPasswordResponse forgotPasswordResponse =
          ForgotPasswordResponse.fromJson(result);

      if (forgotPasswordResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: forgotPasswordResponse);
      } else {
        return ApiResult.failure(
            error: forgotPasswordResponse.message.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }
}
