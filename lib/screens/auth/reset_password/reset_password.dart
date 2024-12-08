import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/screens/auth/model/forgot_password_request.dart';
import 'package:fortfitness/screens/auth/sign_in/sign_in.dart';
import 'package:fortfitness/utils/extention_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../components/custom_button.dart';
import '../../../components/cutom_textfield.dart';
import '../../../components/progress_indicator.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import '../bloc/auth_bloc.dart';
import '../data/auth_datasource.dart';
import '../data/auth_repository.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  AuthBloc authBloc =
      AuthBloc(AuthRepository(authDatasource: AuthDatasource()));

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

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is FPFailure) {
            showSpinner = false;
            Helpers.showSnackBar(context, state.error);
          }
          if (state is FPLoading) {
            showSpinner = true;
          }
          if (state is FPLoaded) {
            showSpinner = false;
            Helpers.showSnackBar(
                context, state.forgotPasswordResponse.message ?? "");
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: showSpinner,
            progressIndicator: SpinKitCircle(
                color: AppColors.primaryColor,
                size: 60.0),
            child: Padding(
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
                    Form(
                      key: _formKey,
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(ImageString.imgLogo5,
                                height: query.height * 0.12),
                            const SizedBox(height: 50),
                            CustomTextField(
                              titleText: "Email Address",
                              controller: emailController,
                              isSecure: false,
                              keyBoardType: TextInputType.emailAddress,
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
                            const SizedBox(height: 40),
                            SizedBox(
                                height: query.height * 0.072,
                                width: query.width * 0.5,
                                child: CustomButton(
                                    imageName: ImageString.icSignIn,
                                    title: ButtonString.btnSubmit,
                                    onClick: () {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      if (_formKey.currentState!.validate()) {
                                        ForgotPasswordRequest
                                            forgotPasswordRequest =
                                            ForgotPasswordRequest(
                                                email: emailController.text
                                                    .trim());
                                        authBloc.add(ForgotPasswordEvent(
                                            forgotPasswordRequest));
                                      }
                                    },
                                    fontColor: AppColors.whiteColor,
                                    buttonColor: AppColors.primaryColor)),
                            SizedBox(height: query.height * 0.12),
                            SvgPicture.asset("assets/icons/confirm_email.svg",
                                height: query.height * 0.04,
                                colorFilter: ColorFilter.mode(
                                    AppColors.primaryColor, BlendMode.srcIn)),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.4,
                              child: Text(
                                  "Check your inbox to confirm your email!",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.workSans(
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.sp)),
                            ),
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
