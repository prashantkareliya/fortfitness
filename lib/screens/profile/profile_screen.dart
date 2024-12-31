import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/screens/auth/bloc_user/user_bloc.dart';
import 'package:fortfitness/screens/profile/bloc/profile_bloc.dart';
import 'package:fortfitness/screens/profile/data/profile_datasource.dart';
import 'package:fortfitness/screens/profile/data/profile_repository.dart';
import 'package:fortfitness/screens/profile/model/update_profile_request.dart';
import 'package:fortfitness/utils/extention_text.dart';
import 'package:fortfitness/utils/preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../components/custom_button.dart';
import '../../components/cutom_textfield.dart';
import '../../components/headerText.dart';
import '../../components/network_image.dart';
import '../../components/progress_indicator.dart';
import '../../constants/strings.dart';
import '../../utils/app_colors.dart';
import '../../utils/helpers.dart';
import '../dashboard/dashboard_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileBloc profileBloc =
      ProfileBloc(ProfileRepository(profileDatasource: ProfileDatasource()));

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController ddController = TextEditingController();
  TextEditingController mmController = TextEditingController();
  TextEditingController yyyyController = TextEditingController();
  String profileImage =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";

  final FocusNode _DDFocusNode = FocusNode();
  final FocusNode _MMFocusNode = FocusNode();
  final FocusNode _YYYYFocusNode = FocusNode();

  bool _isDDFocused = false;
  bool _isMMFocused = false;
  bool _isYYYYFocused = false;

  final _formKey = GlobalKey<FormState>();

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
    profileBloc.add(GetProfileEvent());
  }

  @override
  void dispose() {
    _DDFocusNode.dispose();
    _MMFocusNode.dispose();
    _YYYYFocusNode.dispose();

    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool showSpinner = false;
  File? _image1;

  //String? base64String;

  File? file;
  final ImagePicker _picker = ImagePicker();
  String dtiCertificate = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      listener: (context, state) {
        if (state is ProfileFailure) {
          showSpinner = false;
          Helpers.showSnackBar(context, state.error);
        }
        if (state is ProfileLoading) {
          showSpinner = true;
        }
        if (state is ProfileLoaded) {
          showSpinner = false;
          //Helpers.showSnackBar(context, state.profileResponse.message ?? "");
          nameController.text = state.profileResponse.data!.name ?? "";
          emailController.text = state.profileResponse.data!.email ?? "";
          ddController.text = state.profileResponse.data!.dob!.substring(8, 10);
          mmController.text = state.profileResponse.data!.dob!.substring(5, 7);
          yyyyController.text =
              state.profileResponse.data!.dob!.substring(0, 4);
          profileImage = state.profileResponse.data!.image!.toString();
          preferences.setPreference(PreferenceString.userImage,
              state.profileResponse.data!.image.toString());
        }

        if (state is UpdateProfileFailure) {
          showSpinner = false;
          Helpers.showSnackBar(context, state.error);
        }
        if (state is UpdateProfileLoading) {
          showSpinner = true;
        }
        if (state is UpdateProfileLoaded) {
          /*Helpers.showSnackBar(
              context, state.updateProfileResponse.message ?? "");*/

          context.read<UserBloc>().add(GetUserEvent());
          Future.delayed(const Duration(seconds: 2), () {
            showSpinner = false;
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => DashboardScreen(from: "main")));
          });
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: showSpinner,
          progressIndicator:
              SpinKitCircle(color: AppColors.primaryColor, size: 60.0),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.sp),
              child: SingleChildScrollView(
                  child: Column(children: [
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
                    _image1 != null
                        ? Padding(
                            padding:
                                EdgeInsets.only(bottom: 10.sp, right: 15.sp),
                            child: ClipOval(
                                child: SizedBox.fromSize(
                                    size: Size.fromRadius(60.sp),
                                    child: Image.file(_image1!,
                                        fit: BoxFit.cover))),
                          )
                        : Padding(
                            padding:
                                EdgeInsets.only(bottom: 10.sp, right: 15.sp),
                            child: ClipOval(
                                child: SizedBox.fromSize(
                                    size: Size.fromRadius(60.sp),
                                    child: CustomCachedImage(
                                        imageUrl:
                                            Uri.parse(profileImage).toString(),
                                        fit: BoxFit.cover))),
                          ),
                    PopupMenuButton<String>(
                      offset: const Offset(-30, 50),
                      onSelected: handleClick,
                      popUpAnimationStyle: AnimationStyle(
                          reverseCurve: Curves.ease,
                          curve: Curves.ease,
                          reverseDuration: const Duration(milliseconds: 500),
                          duration: const Duration(milliseconds: 500)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      surfaceTintColor: AppColors.primaryColor,
                      child: SvgPicture.asset("assets/icons/image_upload.svg",
                          height: 60.sp),
                      itemBuilder: (BuildContext context) {
                        return {'📸 Camera', '📽️ Gallery', "✖ Remove"}
                            .map((String choice) {
                          return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice,
                                  style: GoogleFonts.workSans(
                                      textStyle: TextStyle(
                                          fontSize: 16.sp,
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.normal))));
                        }).toList();
                      },
                    )
                  ],
                ),
                SizedBox(height: 10.sp),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        titleText: "Name",
                        controller: nameController,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: "Name",
                          filled: true,
                          fillColor: const Color(0xFFF3F3F4),
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: SvgPicture.asset("assets/icons/name.svg",
                                colorFilter: ColorFilter.mode(
                                    AppColors.primaryColor, BlendMode.srcIn)),
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
                      IgnorePointer(
                        child: CustomTextField(
                          titleText: "Email Address",
                          controller: emailController,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: "Email Address",
                            filled: true,
                            fillColor: const Color(0xFFF3F3F4),
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: SvgPicture.asset("assets/icons/email.svg",
                                  colorFilter: ColorFilter.mode(
                                      AppColors.primaryColor, BlendMode.srcIn)),
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
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /* IgnorePointer(
                            child: CustomTextField(
                              titleText: "Change Password",
                              controller: passwordController,
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: "******** ",
                                filled: true,
                                fillColor: const Color(0xFFF3F3F4),
                                prefixIcon: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 15.0),
                                  child: SvgPicture.asset(
                                      "assets/icons/password.svg",
                                      colorFilter: ColorFilter.mode(
                                          AppColors.primaryColor, BlendMode.srcIn)),
                                ),
                                suffixIcon: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 15.0),
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
                          ),*/
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
                                        keyboardType: TextInputType.text,
                                        maxLines: 1,
                                        maxLength: 2,
                                        style: GoogleFonts.workSans(
                                            textStyle: TextStyle(
                                                fontSize: 16.sp,
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w600)),
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
                                        keyboardType: TextInputType.text,
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
                                        keyboardType: TextInputType.text,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.workSans(
                                            textStyle: TextStyle(
                                                fontSize: 16.sp,
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w600)),
                                        maxLines: 1,
                                        maxLength: 4,
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
                          const SizedBox(height: 30),
                          Center(
                            child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.072,
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: CustomButton(
                                    imageName: ImageString.icSignIn,
                                    title: ButtonString.btnSubmit,
                                    onClick: () async {
                                      if (_formKey.currentState!.validate()) {
                                        UpdateProfileRequest
                                            updateProfileRequest =
                                            UpdateProfileRequest(
                                                image: _image1 != null
                                                    ? _image1!.path
                                                    : "",
                                                isChangeImage:
                                                    _image1 == null ? "1" : "0",
                                                dob:
                                                    "${yyyyController.text.trim()}-${mmController.text.trim()}-${ddController.text.trim()}");
                                        profileBloc.add(UpdateProfileEvent(
                                            updateProfileRequest));
                                      }
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    },
                                    fontColor: AppColors.whiteColor,
                                    buttonColor: AppColors.primaryColor)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]))),
        );
      },
    ));
  }

  void handleClick(String value) {
    switch (value) {
      case '📸 Camera':
        pickLocalImage(value);
        break;
      case '📽️ Gallery':
        pickLocalImage(value);
        break;
      case '✖ Remove':
        pickLocalImage(value);
        break;
    }
  }

  Future<void> pickLocalImage(String option) async {
    try {
      final XFile? image;
      if (option == "📸 Camera") {
        image = await _picker.pickImage(source: ImageSource.camera);
      } else if (option == "📽️ Gallery") {
        image = await _picker.pickImage(source: ImageSource.gallery);
      } else {
        preferences.removeKeyFromPreference(PreferenceString.userImage);
        image = null;
        _image1 = null;
        profileImage =
            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
        setState(() {});
      }

      if (image != null) {
        File imageFile = File(image.path);
        setState(() {
          _image1 = imageFile;
        });
      } else {
        print("No image selected");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<String> convertImageUrlToBase64(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        Uint8List bytes = response.bodyBytes;
        String base64String = base64Encode(bytes);
        return base64String;
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      print("Error: $e");
      return '';
    }
  }
}
