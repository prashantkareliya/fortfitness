import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortfitness/components/network_image.dart';
import 'package:fortfitness/screens/auth/bloc_user/user_bloc.dart';
import 'package:fortfitness/utils/app_colors.dart';
import 'package:fortfitness/utils/helpers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/strings.dart';
import '../../main.dart';
import '../auth/auth_selection.dart';
import '../profile/bloc/profile_bloc.dart';
import '../profile/profile_screen.dart';
import 'discount/discount_screen.dart';
import 'gym/gyms_screen.dart';
import 'services/services_screen.dart';

class DashboardScreen extends StatefulWidget {
  String? from;

  DashboardScreen({super.key, this.from});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? profileImage;

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: /*from == "main" ?*/ IconButton(
              onPressed: () async {
                showLogoutDialog(context);
              },
              icon: Icon(Icons.logout, color: AppColors.primaryColor)),
          title: Image.asset(ImageString.imgLogo5, height: query.height * 0.05),
          centerTitle: true,
          actions: [
            BlocConsumer<ProfileBloc, ProfileState>(
              bloc: profileBloc,
              listener: (context, state) async {
                if (state is ProfileFailure) {
                  logout();
                }
                if (state is ProfileLoading) {}
                if (state is ProfileLoaded) {
                  profileImage = state.profileResponse.data!.image.toString();
                }
                if (state is LogoutLoading) {}
                if (state is LogoutLoaded) {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.clear();
                  await FirebaseMessaging.instance.deleteToken();
                  Navigator.pushAndRemoveUntil(
                      context,
                      FadePageRoute(
                          builder: (context) => const AuthSelectionScreen()),
                      (_) => false);
                }
                if (state is LogoutFailure) {
                  Helpers.showSnackBar(context, state.error);
                }
              },
              builder: (context, state) {
                return BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    return IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfilePage()));
                        },
                        icon: ClipOval(
                            child: SizedBox.fromSize(
                                size: Size.fromRadius(18.sp),
                                child: CustomCachedImage(
                                    imageUrl: state
                                            .profileResponse?.data?.image ??
                                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                                    fit: BoxFit.cover))));
                  },
                );
              },
            )
          ]),
      body: SizedBox(
        width: query.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: query.height * 0.08),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GymScreen()));
              },
              child: Container(
                height: query.height * 0.18,
                width: query.width / 1.25,
                decoration: BoxDecoration(
                    color: AppColors.grayTile,
                    borderRadius: BorderRadius.circular(15.0)),
                padding: EdgeInsets.symmetric(horizontal: 35.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Gym",
                        style: GoogleFonts.workSans(
                            textStyle: TextStyle(
                                fontSize: 28.sp,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w700))),
                    Image.asset("assets/images/gym.png",
                        height: query.height * 0.09)
                  ],
                ),
              ),
            ),
            SizedBox(height: 25.sp),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DiscountScreen()));
              },
              child: Container(
                height: query.height * 0.18,
                width: query.width / 1.25,
                decoration: BoxDecoration(
                    color: AppColors.grayTile,
                    borderRadius: BorderRadius.circular(15.0)),
                padding: EdgeInsets.symmetric(horizontal: 35.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Discount",
                        style: GoogleFonts.workSans(
                            textStyle: TextStyle(
                                fontSize: 28.sp,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w700))),
                    Image.asset("assets/images/discount.png",
                        height: query.height * 0.09)
                  ],
                ),
              ),
            ),
            SizedBox(height: 25.sp),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ServicesScreen()));
              },
              child: Container(
                height: query.height * 0.18,
                width: query.width / 1.25,
                padding: EdgeInsets.symmetric(horizontal: 35.sp),
                decoration: BoxDecoration(
                    color: AppColors.grayTile,
                    borderRadius: BorderRadius.circular(15.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Services",
                        style: GoogleFonts.workSans(
                            textStyle: TextStyle(
                                fontSize: 28.sp,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w700))),
                    Image.asset("assets/images/service.png",
                        height: query.height * 0.09)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          surfaceTintColor: AppColors.primaryColor,
          title: Text("Confirm Logout",
              style: GoogleFonts.workSans(
                  textStyle: TextStyle(
                      fontSize: 28.sp,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700))),
          content: Text("Are you sure you want to logout?",
              style: GoogleFonts.workSans(
                  textStyle: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.normal))),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel",
                  style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.normal))),
            ),
            ElevatedButton(
              clipBehavior: Clip.hardEdge,
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  splashFactory: NoSplash.splashFactory,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)))),
              onPressed: () async {
                Navigator.pop(context, "logout");
              },
              child: Text("Logout",
                  style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.normal))),
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null) {
        profileBloc.add(LogoutEvent());
      }
    });
  }
}
