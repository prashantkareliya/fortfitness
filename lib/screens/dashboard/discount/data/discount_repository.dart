import 'package:fortfitness/screens/dashboard/discount/data/discount_datasource.dart';
import 'package:fortfitness/screens/dashboard/discount/model/discount_claim_request.dart';
import 'package:fortfitness/screens/dashboard/discount/model/discount_claim_response.dart';
import 'package:fortfitness/screens/dashboard/discount/model/get_discount_claim_detail_response.dart';
import 'package:fortfitness/screens/dashboard/discount/model/get_discount_response.dart';

import '../../../../components/handle_api_error.dart';
import '../../../../constants/constants.dart';
import '../../../../http_actions/api_result.dart';

class DiscountRepository {
  DiscountRepository({required DiscountDatasource discountDatasource})
      : _discountDatasource = discountDatasource;
  final DiscountDatasource _discountDatasource;

  Future<ApiResult<DiscountResponse>> getDiscount() async {
    try {
      final result = await _discountDatasource.getDiscount();

      DiscountResponse discountResponse = DiscountResponse.fromJson(result);

      if (discountResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: discountResponse);
      } else {
        return ApiResult.failure(error: discountResponse.message.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  Future<ApiResult<DiscountClaimResponse>> claimDiscount(
      {required DiscountClaimRequest discountClaimRequest}) async {
    try {
      final result = await _discountDatasource.claimDiscount(
          discountClaimRequest: discountClaimRequest);

      DiscountClaimResponse discountClaimResponse =
          DiscountClaimResponse.fromJson(result);

      if (discountClaimResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: discountClaimResponse);
      } else {
        return ApiResult.failure(
            error: discountClaimResponse.message.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  Future<ApiResult<GetDiscountClaimResponse>> getDiscountClaimRepo() async {
    try {
      final result = await _discountDatasource.getDiscountClaim();

      GetDiscountClaimResponse getDiscountClaimResponse = GetDiscountClaimResponse.fromJson(result);

      if (getDiscountClaimResponse.error == ResponseStatus.success) {
        return ApiResult.success(data: getDiscountClaimResponse);
      } else {
        return ApiResult.failure(error: getDiscountClaimResponse.message.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }
}
