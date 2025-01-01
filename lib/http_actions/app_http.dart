import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:fortfitness/utils/helpers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../constants/strings.dart';

class HttpActions {
  String endPoint = Constants.of().endpoint;
  http.Client _client = http.Client();

  Future<dynamic> postMethod(String url,
      {dynamic data, Map<String, String>? headers}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = getSessionData(
          headers ?? {}, preferences.getString(PreferenceString.accessToken));

      debugPrint("data $data");
      debugPrint(Uri.parse(endPoint + url).toString());
      http.Response response = await http.post(Uri.parse(endPoint + url),
          body: data, headers: headers);
      if (response.statusCode == 401) {
        logout();
      }
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Future<dynamic> getMethod(String url, {Map<String, String>? headers}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = getSessionData(
          headers ?? {}, preferences.getString(PreferenceString.accessToken));

      http.Response response =
          await http.get(Uri.parse(endPoint + url), headers: headers);
      if (response.statusCode == 401) {
        logout();
      }
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Future<dynamic> getMethodWithQueryParam(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    bool shouldCancelRequest = false,
  }) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = getSessionData(headers ?? {});

      String finalUrl = endPoint + url;
      if (queryParams != null) {
        queryParams.forEach((key, value) {
          if (key == queryParams.keys.first) {
            finalUrl = "$finalUrl?$key=$value";
          } else {
            finalUrl = "$finalUrl&$key=$value";
          }
        });
      }
      log("URl -- $finalUrl");
      log(DateTime.now().microsecondsSinceEpoch.toString());
      if (shouldCancelRequest) {
        _client.close();
        _client = http.Client();
      }
      try {
        http.Response response =
            await _client.get(Uri.parse(finalUrl), headers: headers);
        log("After Response URl -- $finalUrl");
        log(DateTime.now().microsecondsSinceEpoch.toString());
        if (response.statusCode == 401) {
          logout();
        }
        return jsonDecode(utf8.decode(response.bodyBytes));
      } catch (e) {
        return "Please check your internet connection";
      }
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Future<dynamic> postMethodWithQueryParam(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    bool shouldCancelRequest = false,
  }) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = getSessionData(headers ?? {});

      String finalUrl = endPoint + url;
      if (queryParams != null) {
        queryParams.forEach((key, value) {
          if (key == queryParams.keys.first) {
            finalUrl = "$finalUrl?$key=$value";
          } else {
            finalUrl = "$finalUrl&$key=$value";
          }
        });
      }
      log("URl -- $finalUrl");
      log(DateTime.now().microsecondsSinceEpoch.toString());
      if (shouldCancelRequest) {
        _client.close();
        _client = http.Client();
      }
      try {
        http.Response response =
            await _client.post(Uri.parse(finalUrl), headers: headers);
        log("After Response URl -- $finalUrl");
        log(DateTime.now().microsecondsSinceEpoch.toString());
        if (response.statusCode == 401) {
          logout();
        }
        return jsonDecode(utf8.decode(response.bodyBytes));
      } catch (e) {
        return "Please check your internet connection";
      }
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Future<dynamic> patchMethod(String url,
      {dynamic data, Map<String, String>? headers}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = getSessionData(headers ?? {});

      http.Response response = await http.patch(Uri.parse(endPoint + url),
          body: data, headers: headers);
      if (response.statusCode == 401) {
        logout();
      }
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Future<dynamic> putMethod(String url,
      {dynamic data, Map<String, String>? headers}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = getSessionData(
          headers ?? {}, preferences.getString(PreferenceString.accessToken));

      http.Response response = await http.put(Uri.parse(endPoint + url),
          body: data, headers: headers);
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Future<dynamic> deleteMethod(String url,
      {dynamic data, Map<String, String>? headers}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = getSessionData(headers ?? {});

      http.Response response = await http.delete(Uri.parse(endPoint + url),
          body: data, headers: headers);
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Future<dynamic> deleteMethodWithQueryParam(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    bool shouldCancelRequest = false,
  }) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = getSessionData(headers ?? {});

      String finalUrl = endPoint + url;
      if (queryParams != null) {
        queryParams.forEach((key, value) {
          if (key == queryParams.keys.first) {
            finalUrl = "$finalUrl?$key=$value";
          } else {
            finalUrl = "$finalUrl&$key=$value";
          }
        });
      }
      log("URl -- $finalUrl");
      log(DateTime.now().microsecondsSinceEpoch.toString());
      if (shouldCancelRequest) {
        _client.close();
        _client = http.Client();
      }
      try {
        http.Response response =
            await _client.delete(Uri.parse(finalUrl), headers: headers);
        log("After Response URl -- $finalUrl");
        log(DateTime.now().microsecondsSinceEpoch.toString());
        return jsonDecode(utf8.decode(response.bodyBytes));
      } catch (e) {
        return "Please check your internet connection";
      }
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Future<dynamic> postMultiPartMethod(String url,
      {data, Map<String, String>? headers}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = getSessionData(
          headers ?? {}, preferences.getString(PreferenceString.accessToken));

      debugPrint("data $data");
      debugPrint(Uri.parse(endPoint + url).toString());
      var request = http.MultipartRequest('POST', Uri.parse(endPoint + url));

      data.forEach((key, value) async {
        if (key.toString().contains("receipt")) {
          if (value != "") {
            request.files
                .add(await http.MultipartFile.fromPath('receipt', value));
          }
        } else {
          request.fields["$key"] = value.toString();
        }
      });
      print(request);
      request.headers.addAll(headers);

      try {
        //Send request
        var streamedResponse = await request
            .send()
            .timeout(const Duration(seconds: 1400), onTimeout: () {
          // ignore: null_argument_to_non_null_type
          return Future.value(null);
        });
        try {
          final apiResponse = await http.Response.fromStream(streamedResponse);
          //Generate response from streamedResponse
          String enCodedStr = utf8.decode(apiResponse.bodyBytes);
          if (apiResponse.statusCode == 401) {
            logout();
          }
          return jsonDecode(enCodedStr);
        } catch (e) {
          //Throw error if getting any issue
          return Future.error(e.toString());
        }
      } catch (e) {
        //Throw error if getting any issue
        return Future.error(e.toString());
      }
    }
  }

  Future<dynamic> putMultiPartMethod(String url,
      {data, Map<String, String>? headers}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = getSessionData(
          headers ?? {}, preferences.getString(PreferenceString.accessToken));
      debugPrint("data $data");
      debugPrint(Uri.parse(endPoint + url).toString());
      var request = http.MultipartRequest('PUT', Uri.parse(endPoint + url));

      data.forEach((key, value) async {
        if (value.runtimeType == http.MultipartFile) {
          request.files.add(value);
        } else {
          request.fields["$key"] = value.toString();
        }
      });

      print(request);
      request.headers.addAll(headers);

      try {
        //Send request
        var streamedResponse = await request
            .send()
            .timeout(const Duration(seconds: 1400), onTimeout: () {
          // ignore: null_argument_to_non_null_type
          return Future.value(null);
        });
        try {
          final apiResponse = await http.Response.fromStream(streamedResponse);
          //Generate response from streamedResponse
          String enCodedStr = utf8.decode(apiResponse.bodyBytes);
          if (apiResponse.statusCode == 401) {
            logout();
          }
          return jsonDecode(enCodedStr);
        } catch (e) {
          //Throw error if getting any issue
          return Future.error(e.toString());
        }
      } catch (e) {
        //Throw error if getting any issue
        return Future.error(e.toString());
      }
    }
  }

  Map<String, String> getSessionData(Map<String, String> headers,
      [String? token]) {
    headers["content-type"] =
        "application/x-www-form-urlencoded; charset=utf-8";
    headers["Authorization"] = "Bearer $token";
    return headers;
  }

  /*Future<Map<String, String>> getHeaders() async {
    // Simulate some asynchronous operation to get headers
    await Future.delayed(Duration(seconds: 1));
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer your_api_token'
    };
  }
*/

  Future<List<ConnectivityResult>> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult;
  }

  /*Future<dynamic> checkResponseAndRedirectUser(http.Response response) async {
    BaseResponse baseResponse = BaseResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    if(baseResponse.redirect == true){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Navigator.pushAndRemoveUntil<dynamic>(
        navigatorKey.currentContext!, MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const SplashLoginScreen(),), (route) => false,);
      return Future.error("Session timeout, Need to login again.");
    } else if(baseResponse.isError) {

      return Future.error(baseResponse.message.toString());
    } else {
      return Future.value(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }*/
}
