
import 'package:fortfitness/components/handle_api_error.dart';
import 'package:fortfitness/constants/constants.dart';
import 'package:fortfitness/http_actions/api_result.dart';
import 'package:fortfitness/screens/dashboard/gym/model/gym_location_response.dart';
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
}
