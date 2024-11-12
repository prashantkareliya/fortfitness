import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class ProgressDialogUtils {
  static BuildContext? getBuildContext;

  ///common method for showing progress dialog
  static void showProgressDialog(context, {isCancellable = false}) async {
    showDialog(
      context: context,
      barrierColor: const Color.fromARGB(63, 39, 39, 39),
      builder: (context) {
        getBuildContext = context;
        return Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: AppColors.primaryColor,
            ),
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: CircularProgressIndicator(strokeWidth: 3.sp, color: AppColors.blackColor),
            ),
          ),
        );
      },
      barrierDismissible: isCancellable,
    );
  }

  ///common method for hiding progress dialog
  static void hideProgressDialog() {
    //debugPrint(getBuildContext);
    if (getBuildContext != null) {
      Navigator.pop(getBuildContext!);
    }
    getBuildContext = null;
  }
}


class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: AppColors.primaryColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: CircularProgressIndicator(strokeWidth: 3.sp, color: AppColors.blackColor),
        )));
  }
}