import 'package:fortfitness/screens/profile/data/profile_datasource.dart';
import 'package:fortfitness/screens/profile/model/profile_response.dart';
import 'package:fortfitness/screens/profile/model/update_profile_request.dart';
import 'package:fortfitness/screens/profile/model/update_profile_response.dart';

import '../../../components/handle_api_error.dart';
import '../../../constants/constants.dart';
import '../../../http_actions/api_result.dart';

class ProfileRepository {
  ProfileRepository({required ProfileDatasource profileDatasource})
      : _profileDatasource = profileDatasource;
  final ProfileDatasource _profileDatasource;

  Future<ApiResult<ProfileResponse>> getProfile() async {
    try {
      final result = await _profileDatasource.getUserProfile();

      ProfileResponse profileResponse = ProfileResponse.fromJson(result);

      if (profileResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: profileResponse);
      } else {
        return ApiResult.failure(error: profileResponse.message.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  Future<ApiResult<UpdateProfileResponse>> updateProfile(
      {required UpdateProfileRequest updateProfileRequest}) async {
    try {
      final result = await _profileDatasource.updateProfile(
          updateProfileRequest: updateProfileRequest);

      UpdateProfileResponse updateProfileResponse =
          UpdateProfileResponse.fromJson(result);

      if (updateProfileResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: updateProfileResponse);
      } else {
        return ApiResult.failure(
            error: updateProfileResponse.message.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }
}
