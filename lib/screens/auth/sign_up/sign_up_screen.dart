import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/utils/extention_text.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/custom_button.dart';
import '../../../components/cutom_textfield.dart';
import '../../../components/headerText.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import '../sign_in/sign_in.dart';
import 'check_email.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController ddController = TextEditingController();
  TextEditingController mmController = TextEditingController();
  TextEditingController yyyyController = TextEditingController();



  final FocusNode _DDFocusNode = FocusNode();
  final FocusNode _MMFocusNode = FocusNode();
  final FocusNode _YYYYFocusNode = FocusNode();

  bool _isNameFocused = false;
  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;
  bool _isConfirmPasswordFocused = false;

  bool _isDDFocused = false;
  bool _isMMFocused = false;
  bool _isYYYYFocused = false;

  @override
  void initState() {
    super.initState();

    _DDFocusNode.addListener(() {
      setState(() {
        _isDDFocused = _DDFocusNode.hasFocus;
      });
    });

    _MMFocusNode.addListener(() {
      setState(() {
        _isMMFocused = _MMFocusNode.hasFocus;
      });
    });

    _YYYYFocusNode.addListener(() {
      setState(() {
        _isYYYYFocused = _YYYYFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _DDFocusNode.dispose();
    _MMFocusNode.dispose();
    _YYYYFocusNode.dispose();

    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonHeader(text2: "Sign Up now!"),
                ],
              ),
              SizedBox(height: 15.sp),
              Image.asset(ImageString.imgLine),
              SizedBox(height: 20.sp),
              CustomTextField(
                titleText: "Name",
                controller: nameController,
                keyBoardType: TextInputType.name,
                isSecure: false,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Name",
                  filled: true,
                  fillColor: const Color(0xFFF3F3F4),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0),
                    child: SvgPicture.asset(
                        "assets/icons/name.svg",
                        colorFilter: ColorFilter.mode(
                            AppColors.primaryColor,
                            BlendMode.srcIn)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "ⓘ Please enter your name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                titleText: "Email Address",
                controller: emailController,
                keyBoardType: TextInputType.emailAddress,
                isSecure: false,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Email Address",
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
              const SizedBox(height: 20),
              CustomTextField(
                titleText: "Password",
                controller: passwordController,
                keyBoardType: TextInputType.text,
                isSecure: true,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Password",
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
                keyBoardType: TextInputType.text,
                isSecure: true,
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
                  } else if(passwordController.text != confirmPasswordController.text){
                    return "ⓘ New Password and Confirm password not matched";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date of Birth",
                      style: GoogleFonts.workSans(
                          textStyle: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w600))),
                  SizedBox(height: 4.sp),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.all(4.sp),
                          decoration: BoxDecoration(
                              color: _isDDFocused
                                  ? AppColors.primaryColor.withOpacity(0.2)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: TextFormField(
                            controller: ddController,
                            focusNode: _DDFocusNode,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w600)),
                            decoration: InputDecoration(
                                fillColor: AppColors.whiteColor,
                                filled: true,
                                hintText: 'DD',
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
                                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10)
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "ⓘ Please enter date";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 8.sp),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.all(4.sp),
                          decoration: BoxDecoration(
                              color: _isMMFocused
                                  ? AppColors.primaryColor.withOpacity(0.2)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: TextFormField(
                            controller: mmController,
                            focusNode: _MMFocusNode,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,

                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w600)),
                            decoration: InputDecoration(
                                fillColor: AppColors.whiteColor,
                                filled: true,
                                hintText: 'MM',
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
                                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10)
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "ⓘ Please enter date";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 8.sp),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.all(4.sp),
                          decoration: BoxDecoration(
                              color: _isYYYYFocused
                                  ? AppColors.primaryColor.withOpacity(0.2)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: TextFormField(
                            controller: yyyyController,
                            focusNode: _YYYYFocusNode,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w600)),
                            decoration: InputDecoration(
                                fillColor: AppColors.whiteColor,
                                filled: true,
                                hintText: 'YYYY',
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
                                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10)
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "ⓘ Please enter date";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.072,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: CustomButton(
                      imageName: ImageString.icSignIn,
                      title: ButtonString.btnSubmit,
                      onClick: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const CheckConfirEmailScreen()));
                      },
                      fontColor: AppColors.whiteColor,
                      buttonColor: AppColors.primaryColor)),
              const SizedBox(height: 30),
              RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: LabelString.alreadyAccount,
                          style: GoogleFonts.workSans(
                              textStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.blackColor,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w500))),
                      TextSpan(
                        text: ButtonString.btnSignIn,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const SignInScreen()));
                          },
                      ),
                    ],
                    style: GoogleFonts.workSans(
                        textStyle: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline)),
                  )),

            ],
          ),
        ),
      ),
    );
  }
}
