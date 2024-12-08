import 'package:fortfitness/screens/dashboard/gym/model/location_claim_request.dart';
import 'package:fortfitness/screens/dashboard/gym/model/location_claim_response.dart';

import '../../../../components/handle_api_error.dart';
import '../../../../constants/constants.dart';
import '../../../../http_actions/api_result.dart';
import '../model/gym_location_response.dart';
import 'gym_location_datasource.dart';

class GymLocationRepository {
  GymLocationRepository({required GymLocationDatasource gymLocationDatasource})
      : _gymLocationDatasource = gymLocationDatasource;
  final GymLocationDatasource _gymLocationDatasource;

  Future<ApiResult<GymLocationResponse>> getProfile() async {
    try {
      final result = await _gymLocationDatasource.getGymLocation();

      GymLocationResponse gymLocationResponse =
          GymLocationResponse.fromJson(result);

      if (gymLocationResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: gymLocationResponse);
      } else {
        return ApiResult.failure(error: gymLocationResponse.message.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  Future<ApiResult<LocationClaimResponse>> claimLocation(
      {required LocationClaimRequest locationClaimRequest}) async {
    try {
      final result = await _gymLocationDatasource.claimLocation(
          locationClaimRequest: locationClaimRequest);

      LocationClaimResponse locationClaimResponse = LocationClaimResponse.fromJson(result);

      if (locationClaimResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: locationClaimResponse);
      } else {
        return ApiResult.failure(
            error: locationClaimResponse.message.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }
}
