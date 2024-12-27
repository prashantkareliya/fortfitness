import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fortfitness/main.dart';
import 'package:fortfitness/screens/auth/auth_selection.dart';
import 'package:fortfitness/screens/profile/bloc/profile_bloc.dart';
import 'package:fortfitness/screens/profile/data/profile_datasource.dart';
import 'package:fortfitness/screens/profile/data/profile_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_colors.dart';

ProfileBloc profileBloc = ProfileBloc(ProfileRepository(profileDatasource: ProfileDatasource()));

class Helpers {



  static PageRoute pageRouteBuilder(widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }

  static void showSnackBar(BuildContext context, String msg,
      {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: isError ? Colors.red : AppColors.blackColor,
          content: Text(
            msg,
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }


  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.errorRed.withOpacity(0.9),
        textColor: AppColors.whiteColor,
        fontSize: 16.0);
  }

}

logout() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  await FirebaseMessaging.instance.deleteToken();
  Navigator.pushAndRemoveUntil(
      navigatorKey.currentContext!,
      FadePageRoute(
          builder: (context) => const AuthSelectionScreen()),
          (_) => false);
}