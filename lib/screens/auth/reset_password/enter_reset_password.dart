import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/screens/auth/sign_in/sign_in.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/custom_button.dart';
import '../../../components/cutom_textfield.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';

class EnterNewPassword extends StatefulWidget {
  const EnterNewPassword({super.key});

  @override
  State<EnterNewPassword> createState() => _EnterNewPasswordState();
}

class _EnterNewPasswordState extends State<EnterNewPassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              RichText(
                  text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: "Reset your password and",
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    fontSize: 24.sp,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w400))),
                        const TextSpan(text: "\nget back on track!"),
                      ],
                      style: GoogleFonts.workSans(
                          textStyle: TextStyle(
                              fontSize: 36.sp,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold)))),
              SizedBox(height: 15.sp),
              Image.asset(ImageString.imgLine),
              SizedBox(height: 40.sp),
              Center(
                child: Column(
                  children: [
                    Image.asset(ImageString.imgLogo5,
                        height: query.height * 0.12),
                    const SizedBox(height: 40),
                    CustomTextField(
                      titleText: "New Password",
                      controller: newPasswordController,
                      isSecure: true,
                      keyBoardType: TextInputType.text,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: "New Password",
                        filled: true,
                        fillColor: const Color(0xFFF3F3F4),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: SvgPicture.asset(
                              "assets/icons/password.svg",
                              colorFilter: ColorFilter.mode(
                                  AppColors.primaryColor,
                                  BlendMode.srcIn)),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: SvgPicture.asset("assets/icons/eye.svg",
                              colorFilter: const ColorFilter.mode(
                                  Color(0xFFBABBBE), BlendMode.srcIn)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "ⓘ Please enter your password";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      titleText: "Confirm Password",
                      controller: confirmPasswordController,
                      isSecure: true,
                      keyBoardType: TextInputType.text,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: "Confirm Password",
                        filled: true,
                        fillColor: const Color(0xFFF3F3F4),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: SvgPicture.asset(
                              "assets/icons/password.svg",
                              colorFilter: ColorFilter.mode(
                                  AppColors.primaryColor,
                                  BlendMode.srcIn)),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: SvgPicture.asset("assets/icons/eye.svg",
                              colorFilter: const ColorFilter.mode(
                                  Color(0xFFBABBBE), BlendMode.srcIn)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "ⓘ Please enter your Confirm password";
                        } else if(newPasswordController.text != confirmPasswordController.text){
                          return "ⓘ New Password and Confirm password not matched";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40.sp),
                    SizedBox(
                        height: query.height * 0.072,
                        width: query.width * 0.6,
                        child: CustomButton(
                            imageName: SvgImageString.icPassword,
                            title: ButtonString.btnResetPassword,
                            onClick: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignInScreen()));
                            },
                            fontColor: AppColors.whiteColor,
                            buttonColor: AppColors.primaryColor)),
                    SizedBox(height: query.height * 0.09),
                    SvgPicture.asset("assets/icons/success.svg", height: 40.sp),
                    SizedBox(height: 5.sp),
                    Text("Password Reset Successfully",
                    style: GoogleFonts.workSans(
                        textStyle: TextStyle(
                            fontSize: 20.sp,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600)),)

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
