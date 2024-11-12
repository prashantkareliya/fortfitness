import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

//Simple common button class
class CustomButton extends StatelessWidget {
  final String title;
  final String? imageName;
  final Function()? onClick;
  final Color? buttonColor;
  final Color? fontColor;

  const CustomButton(
      {super.key,
      required this.title,
      this.imageName,
      this.onClick,
      this.buttonColor,
      this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ElevatedButton(
          onPressed: onClick,
          clipBehavior: Clip.hardEdge,
          style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor ?? AppColors.primaryColor,
              splashFactory: NoSplash.splashFactory,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      color: fontColor)),
              SizedBox(width: 15.sp),
              if (imageName != null)
                Image.asset(
                  imageName ?? "",
                  height: 20.sp,
                )
            ],
          )),
    );
  }
}

//Border button class
class BorderButton extends StatelessWidget {
  final String btnString;
  final String? imageName;
  final Color? fontColor;

  final Function()? onClick;

  const BorderButton(
      {super.key,
      required this.btnString,
      this.onClick,
      this.imageName,
      this.fontColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.all<Color>(AppColors.primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    side:
                        BorderSide(color: AppColors.primaryColor, width: 1.5)))),
        onPressed: onClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(btnString,
                style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: fontColor)),
            SizedBox(width: 15.sp),
            if (imageName != null)
              Image.asset(
                imageName ?? "",
                height: 20.sp,
              )
          ],
        ));
  }
}
