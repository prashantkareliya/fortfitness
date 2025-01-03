import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/screens/auth/model/regestration_request.dart';
import 'package:fortfitness/utils/extention_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../components/custom_button.dart';
import '../../../components/cutom_textfield.dart';
import '../../../components/headerText.dart';
import '../../../components/progress_indicator.dart';
import '../../../constants/strings.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import '../bloc/auth_bloc.dart';
import '../data/auth_datasource.dart';
import '../data/auth_repository.dart';
import '../sign_in/sign_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  AuthBloc authBloc =
      AuthBloc(AuthRepository(authDatasource: AuthDatasource()));

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController ddController = TextEditingController();
  TextEditingController mmController = TextEditingController();
  TextEditingController yyyyController = TextEditingController();

  final FocusNode _DDFocusNode = FocusNode();
  final FocusNode _MMFocusNode = FocusNode();
  final FocusNode _YYYYFocusNode = FocusNode();

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

    fNameController.dispose();
    lNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool showSpinner = false;
  bool password = true;
  bool confirmPassword = true;

  bool _isButtonDisabled = false;

  Future<void> _onButtonPressed() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isButtonDisabled = true;
      });
      RegistrationRequest registrationRequest = RegistrationRequest(
          firstName: fNameController.text,
          lastName: lNameController.text,
          email: emailController.text.trim(),
          password: passwordController.text,
          dob:
              "${yyyyController.text}-${mmController.text}-${ddController.text}",
          role: "receptionist");
      authBloc.add(RegistrationEvent(registrationRequest));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is RegistrationFailure) {
            showSpinner = false;
            _isButtonDisabled = false;
            Helpers.showSnackBar(context, state.error);
          }
          if (state is RegistrationLoading) {
            showSpinner = true;
          }
          if (state is RegistrationLoaded) {
            showSpinner = false;

            Helpers.showSnackBar(
                context, state.registrationResponse.errorMessage ?? "");
            if (state.registrationResponse.error == false) {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => const SignInScreen(),
                ),
                (route) => false,
              );
            }
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: showSpinner,
            progressIndicator:
                SpinKitCircle(color: AppColors.primaryColor, size: 60.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CommonHeader(text2: "Sign Up now!"),
                      ],
                    ),
                    SizedBox(height: 10.sp),
                    Image.asset(ImageString.imgLine),
                    SizedBox(height: 10.sp),
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          CustomTextField(
                            titleText: "First name",
                            controller: fNameController,
                            keyBoardType: TextInputType.name,
                            isSecure: false,
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: "First name",
                              filled: true,
                              fillColor: const Color(0xFFF3F3F4),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Assets.icons.name.svg(
                                    colorFilter: ColorFilter.mode(
                                        AppColors.primaryColor,
                                        BlendMode.srcIn)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "ⓘ Please enter your first name";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          CustomTextField(
                            titleText: "Last name",
                            controller: lNameController,
                            keyBoardType: TextInputType.name,
                            isSecure: false,
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: "Last name",
                              filled: true,
                              fillColor: const Color(0xFFF3F3F4),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Assets.icons.name.svg(
                                    colorFilter: ColorFilter.mode(
                                        AppColors.primaryColor,
                                        BlendMode.srcIn)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "ⓘ Please enter your last name";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
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
                                child: Assets.icons.email.svg(
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
                          const SizedBox(height: 15),
                          CustomTextField(
                            titleText: "Password",
                            controller: passwordController,
                            keyBoardType: TextInputType.text,
                            isSecure: password,
                            onChange: (v) {
                              setState(() {});
                            },
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: "Password",
                              filled: true,
                              fillColor: const Color(0xFFF3F3F4),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: SvgPicture.asset(
                                    "assets/icons/password.svg",
                                    colorFilter: ColorFilter.mode(
                                        AppColors.primaryColor,
                                        BlendMode.srcIn)),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      password = !password;
                                    });
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/eye.svg",
                                      colorFilter: ColorFilter.mode(
                                          password
                                              ? const Color(0xFFBABBBE)
                                              : AppColors.primaryColor,
                                          BlendMode.srcIn)),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "ⓘ Please enter your password";
                              }
                              return null;
                            },
                          ),
                          Visibility(
                              visible: passwordController.text.isNotEmpty,
                              child: passwordContainsMethod()),
                          const SizedBox(height: 15),
                          CustomTextField(
                            titleText: "Confirm Password",
                            controller: confirmPasswordController,
                            keyBoardType: TextInputType.text,
                            isSecure: confirmPassword,
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: "Confirm Password",
                              filled: true,
                              fillColor: const Color(0xFFF3F3F4),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: SvgPicture.asset(
                                    "assets/icons/password.svg",
                                    colorFilter: ColorFilter.mode(
                                        AppColors.primaryColor,
                                        BlendMode.srcIn)),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      confirmPassword = !confirmPassword;
                                    });
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/eye.svg",
                                      colorFilter: ColorFilter.mode(
                                          confirmPassword
                                              ? const Color(0xFFBABBBE)
                                              : AppColors.primaryColor,
                                          BlendMode.srcIn)),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "ⓘ Please enter your Confirm password";
                              } else if (passwordController.text !=
                                  confirmPasswordController.text) {
                                return "ⓘ Password and Confirm password not matched";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
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
                                    flex: 3,
                                    child: Container(
                                      padding: EdgeInsets.all(4.sp),
                                      decoration: BoxDecoration(
                                          color: _isDDFocused
                                              ? AppColors.primaryColor
                                                  .withOpacity(0.2)
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
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
                                        maxLines: 1,
                                        maxLength: 2,
                                        decoration: InputDecoration(
                                          counter: const SizedBox.shrink(),
                                          fillColor: AppColors.whiteColor,
                                          filled: true,
                                          hintText: 'DD',
                                          hintStyle: GoogleFonts.workSans(
                                              color: const Color(0xFFBABBBE),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.primaryColor,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      12.0) // Border radius
                                              ),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.primaryColor,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.red,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.red,
                                                      width: 1.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0)),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 10),
                                          errorStyle: GoogleFonts.workSans(
                                              textStyle: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: AppColors.errorRed,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Enter Date";
                                          } else if (int.parse(value) > 31) {
                                            return "Not valid";
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
                                          color: _isMMFocused
                                              ? AppColors.primaryColor
                                                  .withOpacity(0.2)
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
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
                                        maxLines: 1,
                                        maxLength: 2,
                                        decoration: InputDecoration(
                                          counter: const SizedBox.shrink(),
                                          fillColor: AppColors.whiteColor,
                                          filled: true,
                                          hintText: 'MM',
                                          hintStyle: GoogleFonts.workSans(
                                              color: const Color(0xFFBABBBE),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.primaryColor,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      12.0) // Border radius
                                              ),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.primaryColor,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.red,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.red,
                                                      width: 1.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0)),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 10),
                                          errorStyle: GoogleFonts.workSans(
                                              textStyle: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: AppColors.errorRed,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Enter Month";
                                          } else if (int.parse(value) > 12) {
                                            return "Not valid";
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
                                              ? AppColors.primaryColor
                                                  .withOpacity(0.2)
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
                                      child: TextFormField(
                                        controller: yyyyController,
                                        focusNode: _YYYYFocusNode,
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        maxLength: 4,
                                        style: GoogleFonts.workSans(
                                            textStyle: TextStyle(
                                                fontSize: 16.sp,
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w600)),
                                        decoration: InputDecoration(
                                          counter: const SizedBox.shrink(),
                                          fillColor: AppColors.whiteColor,
                                          filled: true,
                                          hintText: 'YYYY',
                                          hintStyle: GoogleFonts.workSans(
                                              color: const Color(0xFFBABBBE),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.primaryColor,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      12.0) // Border radius
                                              ),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.primaryColor,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.red,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.red,
                                                      width: 1.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0)),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 10),
                                          errorStyle: GoogleFonts.workSans(
                                              textStyle: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: AppColors.errorRed,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Enter Year";
                                          } else if (int.parse(value) > 2024) {
                                            return "Not valid";
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
                          const SizedBox(height: 10),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.072,
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: CustomButton(
                                  imageName: ImageString.icSignIn,
                                  title: ButtonString.btnSubmit,
                                  onClick: _onButtonPressed,
                                  fontColor: AppColors.whiteColor,
                                  buttonColor: AppColors.primaryColor)),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
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
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Column passwordContainsMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text("Your password must contain:",
              style: GoogleFonts.workSans(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: AppColors.blackColor))),
        ),

        //This condition for check length
        if (passwordController.text.length <= 8)
          PasswordContains(
              icon: Icons.close,
              textMsg: "Must be at 8 characters long",
              iconColor: AppColors.blackColor.withOpacity(0.4),
              textColor: AppColors.blackColor.withOpacity(0.4))
        else
          PasswordContains(
              icon: Icons.done,
              textMsg: "Must be at 8 characters long",
              iconColor: AppColors.primaryColor,
              textColor: AppColors.blackColor),

        //This condition for check lowercase
        if (!passwordController.text.contains(RegExp(r'[a-z]')))
          PasswordContains(
              icon: Icons.close,
              textMsg: "Should contain lowercase",
              iconColor: AppColors.blackColor.withOpacity(0.4),
              textColor: AppColors.blackColor.withOpacity(0.4))
        else
          PasswordContains(
              icon: Icons.done,
              textMsg: "Should contain lowercase",
              iconColor: AppColors.primaryColor,
              textColor: AppColors.blackColor),

        //This condition for check numbers
        if (!passwordController.text.contains(RegExp(r'[0-9]')))
          PasswordContains(
            icon: Icons.close,
            textMsg: "Should contain numbers",
            iconColor: AppColors.blackColor.withOpacity(0.4),
            textColor: AppColors.blackColor.withOpacity(0.4),
          )
        else
          PasswordContains(
              icon: Icons.done,
              textMsg: "Should contain numbers",
              iconColor: AppColors.primaryColor,
              textColor: AppColors.blackColor),

        //This condition for check special character
        if (!passwordController.text.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]')))
          PasswordContains(
              icon: Icons.close,
              textMsg: "Should contain special characters",
              iconColor: AppColors.blackColor.withOpacity(0.4),
              textColor: AppColors.blackColor.withOpacity(0.4))
        else
          PasswordContains(
              icon: Icons.done,
              textMsg: "Should contain special characters",
              iconColor: AppColors.primaryColor,
              textColor: AppColors.blackColor),
      ],
    );
  }
}

class PasswordContains extends StatelessWidget {
  IconData? icon;
  String? textMsg;
  Color? textColor;
  Color? iconColor;

  PasswordContains(
      {this.icon, this.textMsg, this.textColor, this.iconColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.sp, horizontal: 12.sp),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 18.sp),
          SizedBox(width: 8.sp),
          Text(
            textMsg ?? "",
            style: GoogleFonts.workSans(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: textColor)),
          ),
        ],
      ),
    );
  }
}
