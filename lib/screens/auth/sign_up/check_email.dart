import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/components/headerText.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/custom_button.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import '../sign_in/sign_in.dart';

class CheckConfirEmailScreen extends StatelessWidget {
  const CheckConfirEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonHeader(
                  text1: "Power up your Gym",
                  text2: "\nSign up now!",
                ),
                SizedBox(height: 15.sp),
                Image.asset(ImageString.imgLine),
              ],
            ),

            Column(
              children: [
                SvgPicture.asset("assets/icons/confirm_email.svg",
                    colorFilter:
                    ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn)),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: Text("Check your inbox to confirm your email!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.workSans(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp)),
                ),
                const SizedBox(height: 50),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.072,
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: CustomButton(
                        imageName: ImageString.icSignIn,
                        title: ButtonString.btnSignIn,
                        onClick: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const SignInScreen()));
                        },
                        fontColor: AppColors.whiteColor,
                        buttonColor: AppColors.primaryColor)),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.12)
          ],
        ),
      ),
    );
  }
}
