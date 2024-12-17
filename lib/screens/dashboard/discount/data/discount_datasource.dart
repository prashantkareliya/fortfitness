import 'package:flutter/material.dart';
import 'package:fortfitness/http_actions/app_http.dart';
import 'package:fortfitness/screens/dashboard/discount/model/discount_claim_request.dart';

import '../../../../constants/constants.dart';

class DiscountDatasource extends HttpActions {
  Future<dynamic> getDiscount() async {
    final response = await getMethod(ApiEndPoint.discount);
    debugPrint("discount -  $response");
    return response;
  }

  Future<dynamic> claimDiscount(
      {required DiscountClaimRequest discountClaimRequest}) async {
    final response = await postMultiPartMethod(ApiEndPoint.claimDiscount,
        data: discountClaimRequest.toJson());
    debugPrint("claim discount -  $response");
    return response;
  }
}
