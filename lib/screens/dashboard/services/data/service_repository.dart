import 'package:fortfitness/components/handle_api_error.dart';
import 'package:fortfitness/http_actions/api_result.dart';
import 'package:fortfitness/screens/dashboard/services/data/service_datasource.dart';
import 'package:fortfitness/screens/dashboard/services/model/claim_service_request.dart';
import 'package:fortfitness/screens/dashboard/services/model/claim_service_response.dart';
import 'package:fortfitness/screens/dashboard/services/model/service_response_model.dart';

import '../../../../constants/constants.dart';

class ServiceRepository {
  ServiceRepository({required ServiceDatasource serviceDatasource})
      : _serviceDatasource = serviceDatasource;
  final ServiceDatasource _serviceDatasource;

  Future<ApiResult<ServiceResponse>> getService() async {
    try {
      final result = await _serviceDatasource.getAllServices();

      ServiceResponse serviceResponse = ServiceResponse.fromJson(result);

      if (serviceResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: serviceResponse);
      } else {
        return ApiResult.failure(error: serviceResponse.message.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  Future<ApiResult<ClaimServiceResponse>> claimService(
      {required ClaimServiceRequest claimServiceRequest}) async {
    try {
      final result = await _serviceDatasource.claimService(
          claimServiceRequest: claimServiceRequest);

      ClaimServiceResponse claimServiceResponse = ClaimServiceResponse.fromJson(result);

      if (claimServiceResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: claimServiceResponse);
      } else {
        return ApiResult.failure(
            error: claimServiceResponse.message.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }
}