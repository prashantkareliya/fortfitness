import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortfitness/components/custom_button.dart';
import 'package:fortfitness/constants/strings.dart';
import 'package:fortfitness/gen/assets.gen.dart';
import 'package:fortfitness/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/headerText.dart';
import 'sign_in/sign_in.dart';
import 'sign_up/sign_up_screen.dart';

class AuthSelectionScreen extends StatefulWidget {
  const AuthSelectionScreen({super.key});

  @override
  State<AuthSelectionScreen> createState() => _AuthSelectionScreenState();
}

class _AuthSelectionScreenState extends State<AuthSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonHeader(text1: "Welcome to"),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(LabelString.labelFortfitness,
                        style: GoogleFonts.workSans(
                            textStyle: TextStyle(
                                fontSize: 40.sp,
                                height: 1,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold))),
                    SizedBox(height: 15.sp),
                    Container(
                        width: query.width * 0.58,
                        height: 1.5,
                        color: AppColors.gray)
                  ],
                ),
                Expanded(
                    child: Image.asset(ImageString.imgGymBoyGirl,
                        height: query.height * 0.16)),
              ],
            ),
            SizedBox(height: query.height * 0.015),
            Center(
                child: Column(
              children: [
                Assets.images.logo5.image(height: query.height * 0.2),
                // Image.asset(Assets.images.logo5.path,
                //     height: query.height * 0.2),
                SizedBox(height: query.height * 0.11),
                SizedBox(
                    height: query.height * 0.072,
                    width: query.width * 0.55,
                    child: CustomButton(
                        imageName: ImageString.icSignIn,
                        title: ButtonString.btnSignIn,
                        onClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInScreen()));
                        },
                        fontColor: AppColors.whiteColor,
                        buttonColor: AppColors.primaryColor)),
                SizedBox(height: query.height * 0.11),
                Text(LabelString.labelNotAc,
                    style: GoogleFonts.workSans(
                        textStyle: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w400))),
                SizedBox(height: query.height * 0.011),
                SizedBox(
                    height: query.height * 0.072,
                    width: query.width * 0.55,
                    child: BorderButton(
                        imageName: ImageString.icSignUp,
                        btnString: ButtonString.btnSignUp,
                        onClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                        fontColor: AppColors.primaryColor))
              ],
            )),
          ],
        ),
      ),
    );
  }
}
