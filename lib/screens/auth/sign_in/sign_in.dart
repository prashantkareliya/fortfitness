import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/constants/strings.dart';
import 'package:fortfitness/utils/extention_text.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/custom_button.dart';
import '../../../components/headerText.dart';
import '../../../utils/app_colors.dart';

InputDecoration kTextFieldDecoration = InputDecoration(
    hintText: 'Enter value',
    hintStyle: GoogleFonts.workSans(
        color: const Color(0xFFBABBBE),
        fontWeight: FontWeight.w600,
        fontSize: 16.sp),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(12.0) // Border radius
        ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(12.0)),
    errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
        borderRadius: BorderRadius.circular(12.0)),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
        borderRadius: BorderRadius.circular(12.0)),
    prefixIcon: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SvgPicture.asset("assets/svg/email.svg",
          colorFilter:
              ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn)),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18));

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  bool _isFocused1 = false;
  bool _isFocused2 = false;

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {
        _isFocused1 = _focusNode1.hasFocus;
      });
    });
    _focusNode2.addListener(() {
      setState(() {
        _isFocused2 = _focusNode2.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonHeader(text1: "Welcome back", text2: "\nAgain!!!"),
              SizedBox(height: 15.sp),
              Image.asset(ImageString.imgLine),
              SizedBox(height: 40.sp),
              Center(
                child: Column(
                  children: [
                    Image.asset(ImageString.imgLogo5,
                        height: query.height * 0.12),
                    const SizedBox(height: 40),
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
                              hintText: "Email Address",
                              filled: true,
                              fillColor: const Color(0xFFF3F3F4),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
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
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Password",
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w600))),
                        SizedBox(height: 8.sp),
                        Container(
                          padding: EdgeInsets.all(4.sp),
                          decoration: BoxDecoration(
                              color: _isFocused2
                                  ? AppColors.primaryColor.withOpacity(0.2)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: TextFormField(
                            controller: passwordController,
                            focusNode: _focusNode2,
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w600)),
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: "Password",
                              filled: true,
                              fillColor: const Color(0xFFF3F3F4),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                    "assets/icons/password.svg",
                                    colorFilter: ColorFilter.mode(
                                        AppColors.primaryColor,
                                        BlendMode.srcIn)),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset("assets/icons/eye.svg",
                                    colorFilter: const ColorFilter.mode(
                                        Color(0xFFBABBBE), BlendMode.srcIn)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "ⓘ Please enter your email";
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
                        width: query.width * 0.55,
                        child: CustomButton(
                            imageName: ImageString.icSignIn,
                            title: ButtonString.btnSignIn,
                            onClick: () {},
                            fontColor: AppColors.whiteColor,
                            buttonColor: AppColors.primaryColor)),
                    const SizedBox(height: 40),
                    RichText(
                        text: TextSpan(
                            children: <TextSpan>[
                          TextSpan(
                              text: LabelString.labelNotAc1,
                              style: GoogleFonts.workSans(
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.blackColor,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w500))),
                          const TextSpan(text: ButtonString.btnSignUp),
                        ],
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline)))),
                    const SizedBox(height: 20),
                    Text(LabelString.labelForgotPassword,
                        style: GoogleFonts.workSans(
                            textStyle: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryColor,
                        )))
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
