import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/components/cutom_textfield.dart';
import 'package:fortfitness/constants/strings.dart';
import 'package:fortfitness/screens/auth/bloc/auth_bloc.dart';
import 'package:fortfitness/screens/auth/data/auth_datasource.dart';
import 'package:fortfitness/screens/auth/data/auth_repository.dart';
import 'package:fortfitness/screens/auth/model/login_request.dart';
import 'package:fortfitness/screens/auth/sign_up/sign_up_screen.dart';
import 'package:fortfitness/screens/dashboard/dashboard_screen.dart';
import 'package:fortfitness/utils/extention_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../components/custom_button.dart';
import '../../../components/headerText.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import '../../../utils/preferences.dart';
import '../reset_password/reset_password.dart';

/*InputDecoration kTextFieldDecoration = InputDecoration(
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
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18));*/

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController(text: "ajaykorat16@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "Ajay@123");

  AuthBloc authBloc = AuthBloc(AuthRepository(authDatasource: AuthDatasource()));

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is LoginFailure) {
            showSpinner = false;
            Helpers.showSnackBar(context, state.error);
          }
          if(state is LoginLoading) {
            showSpinner = true;
          }
          if (state is LoginLoaded) {
            showSpinner = false;
            Helpers.showSnackBar(context, state.loginResponse.message ?? "");
            preferences.setPreference(PreferenceString.userEmail, state.loginResponse.data?.user!.email.toString());
            preferences.setPreference(PreferenceString.accessToken, state.loginResponse.data?.token.toString());
            preferences.setPreference(PreferenceString.userId, state.loginResponse.data?.user!.id.toString());
            Navigator.push(context, MaterialPageRoute(builder: (context)=> DashboardScreen(from: "main")));
          }
        },
        builder: (context, state) {
        return ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonHeader(text1: "Welcome back", text2: "\nAgain!!!"),
                SizedBox(height: 15.sp),
                Image.asset(ImageString.imgLine),
                SizedBox(height: 40.sp),
            Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    Image.asset(ImageString.imgLogo5,
                        height: query.height * 0.12),
                    const SizedBox(height: 40),
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
                    const SizedBox(height: 40),
                    SizedBox(
                        height: query.height * 0.072,
                        width: query.width * 0.55,
                        child: CustomButton(
                            imageName: ImageString.icSignIn,
                            title: ButtonString.btnSignIn,
                            onClick: () {
                              if(_formKey.currentState!.validate()){
                                LoginRequest loginRequest = LoginRequest(
                                    email: emailController.text.trim(),
                                    password: passwordController.text
                                );
                                authBloc.add(LoginUserEvent(loginRequest));
                              }
                            },
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
                            TextSpan(
                              text: ButtonString.btnSignUp,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const SignUpScreen()));
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
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const ResetPasswordScreen()));
                      },
                      child: Text(LabelString.labelForgotPassword,
                          style: GoogleFonts.workSans(
                              textStyle: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryColor,
                              ))),
                    )
                  ],
                ),
              ),
            )
              ],
            ),
          ),
        ),
      );
  },
),
    );
  }


}
