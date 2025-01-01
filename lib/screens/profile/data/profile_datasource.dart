import 'package:flutter/material.dart';
import 'package:fortfitness/screens/profile/model/update_profile_request.dart';

import '../../../constants/constants.dart';
import '../../../http_actions/app_http.dart';

class ProfileDatasource extends HttpActions {
  Future<dynamic> getUserProfile() async {
    final response = await getMethod(ApiEndPoint.getProfile);
    debugPrint("User Profile -  $response");
    return response;
  }

  Future<dynamic> updateProfile(
      {required UpdateProfileRequest updateProfileRequest}) async {
    final response = await putMultiPartMethod(ApiEndPoint.profileUpdate,
        data: await updateProfileRequest.toJson());
    debugPrint("Update User -  $response");
    return response;
  }
}
