import 'package:flutter/material.dart';

@immutable
class Constants {
  const Constants({required this.endpoint});

  factory Constants.of() {
    if (_instance != null) return _instance!;
    _instance = Constants._prd();
    return _instance!;
  }

  factory Constants._prd() {
    return const Constants(
      ///Base URl
      endpoint: 'http://143.110.244.228:8082/api/', //  staging server
        //   endpoint: '', // live server
);
  }

  static Constants? _instance;
  final String endpoint;
}

class ResponseStatus {
  static const bool failed = true;
  static const bool success = false;
}

class ApiEndPoint {
  //POST API endpoint
  static const String login = "user/login";
  static const String register = "user/register";
  static const String forgotPassword = "user/forgot-password";
  static const String claimService = "service/claim";
  static const String claimDiscount = "discount/claim";

  //GET API endpoint
  static const String getProfile = "user/profile";
  static const String location = "location";
  static const String service = "service";
  static const String discount = "discount";

  //PUT API endpoint
  static const String profileUpdate = "user/profile/update";






}