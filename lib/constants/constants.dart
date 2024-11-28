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
      endpoint: 'http://143.110.244.228:8082/api/user/', //  staging server
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
  static const String login = "login";

}