import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/screens/profile/profile_screen.dart';
import 'package:fortfitness/utils/extention_text.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/custom_button.dart';
import '../../../components/headerText.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import '../sign_in/sign_in.dart';
import 'enter_reset_password.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();

  bool _isFocused1 = false;

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {
        _isFocused1 = _focusNode1.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
    body:  Padding(
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
                    const SizedBox(height: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email Address",
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w600))),
                        SizedBox(height: 8.sp),
                        Container(
                          padding: EdgeInsets.all(4.sp),
                          decoration: BoxDecoration(
                              color: _isFocused1
                                  ? AppColors.primaryColor.withOpacity(0.2)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: TextFormField(
                            controller: emailController,
                            focusNode: _focusNode1,
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w600)),
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: "examle@email.com",
                              filled: true,
                              fillColor: const Color(0xFFF3F3F4),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: SvgPicture.asset(
                                    "assets/icons/email.svg",
                                    colorFilter: ColorFilter.mode(
                                        AppColors.primaryColor,
                                        BlendMode.srcIn)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "ⓘ Please enter your email";
                              } else if (!emailController.text.isValidEmail) {
                                return "ⓘ Enter valid email address";
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 40),
                    SizedBox(
                        height: query.height * 0.072,
                        width: query.width * 0.5,
                        child: CustomButton(
                            imageName: ImageString.icSignIn,
                            title: ButtonString.btnSubmit,
                            onClick: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> EnterNewPassword()));
                            },
                            fontColor: AppColors.whiteColor,
                            buttonColor: AppColors.primaryColor)),
                    SizedBox(height: query.height * 0.12),
                    SvgPicture.asset("assets/icons/confirm_email.svg",
                        height: query.height * 0.04,
                        colorFilter:
                        ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn)),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: Text("Check your inbox to confirm your email!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.workSans(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp)),
                    ),
                  ],
                ),
              )
            ],
          ),
      ),
    ),
    );
  }
}