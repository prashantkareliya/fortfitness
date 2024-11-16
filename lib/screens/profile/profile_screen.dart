import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/utils/extention_text.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/custom_button.dart';
import '../../components/headerText.dart';
import '../../constants/strings.dart';
import '../../utils/app_colors.dart';
import '../auth/sign_in/sign_in.dart';
import '../dashboard/dashboard_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  TextEditingController ddController = TextEditingController();
  TextEditingController mmController = TextEditingController();
  TextEditingController yyyyController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final FocusNode _DDFocusNode = FocusNode();
  final FocusNode _MMFocusNode = FocusNode();
  final FocusNode _YYYYFocusNode = FocusNode();

  bool _isNameFocused = false;
  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;

  bool _isDDFocused = false;
  bool _isMMFocused = false;
  bool _isYYYYFocused = false;

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(() {
      setState(() {
        _isNameFocused = _nameFocusNode.hasFocus;
      });
    });
    _emailFocusNode.addListener(() {
      setState(() {
        _isEmailFocused = _emailFocusNode.hasFocus;
      });
    });
    _passwordFocusNode.addListener(() {
      setState(() {
        _isPasswordFocused = _passwordFocusNode.hasFocus;
      });
    });


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
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    _DDFocusNode.dispose();
    _MMFocusNode.dispose();
    _YYYYFocusNode.dispose();

    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  CommonHeader(text2: "Profile", isBack: true),
                  SizedBox(height: 15.sp),
                  Image.asset(ImageString.imgLine),
                ],
              ),
              SizedBox(height: 15.sp),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.sp, right: 15.sp),
                    child: ClipOval(
                        child: SizedBox.fromSize(
                            size: Size.fromRadius(60.sp),
                            child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUyllrW-u-01_B8qMki4ybHzbhuBWhUq3pMA&s", fit: BoxFit.cover))),
                  ),
                  SvgPicture.asset("assets/icons/image_upload.svg", height: 60.sp,)
                ],
              ),
              SizedBox(height: 10.sp),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name",
                      style: GoogleFonts.workSans(
                          textStyle: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w600))),
                  SizedBox(height: 4.sp),
                  Container(
                    padding: EdgeInsets.all(4.sp),
                    decoration: BoxDecoration(
                        color: _isNameFocused
                            ? AppColors.primaryColor.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12.0)),
                    child: TextFormField(
                      controller: nameController,
                      focusNode: _nameFocusNode,
                      keyboardType: TextInputType.text,
                      style: GoogleFonts.workSans(
                          textStyle: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w600)),
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: "Name",
                        filled: true,
                        fillColor: const Color(0xFFF3F3F4),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(15.0),
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
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email Address",
                          style: GoogleFonts.workSans(
                              textStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600))),
                      SizedBox(height: 4.sp),
                      Container(
                        padding: EdgeInsets.all(4.sp),
                        decoration: BoxDecoration(
                            color: _isEmailFocused
                                ? AppColors.primaryColor.withOpacity(0.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12.0)),
                        child: TextFormField(
                          controller: emailController,
                          focusNode: _emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.workSans(
                              textStyle: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600)),
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: "example@mail.com",
                            filled: true,
                            fillColor: const Color(0xFFF3F3F4),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
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
                      Text("Change Password",
                          style: GoogleFonts.workSans(
                              textStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600))),
                      SizedBox(height: 4.sp),
                      Container(
                        padding: EdgeInsets.all(4.sp),
                        decoration: BoxDecoration(
                            color: _isPasswordFocused
                                ? AppColors.primaryColor.withOpacity(0.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12.0)),
                        child: TextFormField(
                          controller: passwordController,
                          focusNode: _passwordFocusNode,
                          keyboardType: TextInputType.text,
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
                      )
                    ],
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
                                keyboardType: TextInputType.text,
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
                                keyboardType: TextInputType.text,
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
                                keyboardType: TextInputType.text,
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
                  Center(
                    child: SizedBox(
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
                                      const DashboardScreen()));
                            },
                            fontColor: AppColors.whiteColor,
                            buttonColor: AppColors.primaryColor)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
