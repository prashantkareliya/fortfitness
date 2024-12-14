import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/components/network_image.dart';
import 'package:fortfitness/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/strings.dart';
import '../../main.dart';
import '../auth/auth_selection.dart';
import '../profile/bloc/profile_bloc.dart';
import '../profile/data/profile_datasource.dart';
import '../profile/data/profile_repository.dart';
import '../profile/profile_screen.dart';
import 'discount/discount_screen.dart';
import 'gym/gyms_screen.dart';
import 'services/services_screen.dart';

class DashboardScreen extends StatelessWidget {
  String? from;
   DashboardScreen({super.key, this.from});

  //SharedPreferences? preferences;
  String? profileImage;
  ProfileBloc profileBloc =
      ProfileBloc(ProfileRepository(profileDatasource: ProfileDatasource()));

  void _getProfile(BuildContext context) {
    profileBloc.add(GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getProfile(context);
    });
    var query = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: from == "main" ? IconButton(
            onPressed: () async {
              showLogoutDialog(context);
            },
            icon: Icon(Icons.logout, color: AppColors.primaryColor)) : IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: SvgPicture.asset("assets/icons/back.svg")),
        title: Image.asset(ImageString.imgLogo5,
            height: query.height * 0.05),
        centerTitle: true,
        actions: [
            BlocConsumer<ProfileBloc, ProfileState>(
              bloc: profileBloc,
              listener: (context, state) {
                if (state is ProfileFailure) {}
                if (state is ProfileLoading) {}
                if (state is ProfileLoaded) {
                  profileImage = state.profileResponse.data!.image.toString();
                }
              },
              builder: (context, state) {
                return IconButton(
                    onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProfilePage()));
            },
            icon: ClipOval(
                child: SizedBox.fromSize(
                    size: Size.fromRadius(18.sp),
                    child: CustomCachedImage(
                        imageUrl: profileImage ??
                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                      fit: BoxFit.cover))));
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GymScreen()));
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
                    Text("Gym",  style: GoogleFonts.workSans(
                        textStyle: TextStyle(
                            fontSize: 28.sp,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w700))),
                    Image.asset("assets/images/gym.png", height: query.height * 0.09)
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
                        builder: (context) =>
                        const DiscountScreen()));
              },
              child: Container(
                height: query.height * 0.18,
                width: query.width / 1.25,
                decoration: BoxDecoration(
                    color: AppColors.grayTile,
                    borderRadius: BorderRadius.circular(15.0)
                ),
                padding: EdgeInsets.symmetric(horizontal: 35.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Discount",  style: GoogleFonts.workSans(
                        textStyle: TextStyle(
                            fontSize: 28.sp,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w700))),
                    Image.asset("assets/images/discount.png", height: query.height * 0.09)
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
                        builder: (context) =>
                        const ServicesScreen()));
              },
              child: Container(
                height: query.height * 0.18,
                width: query.width / 1.25,
                padding: EdgeInsets.symmetric(horizontal: 35.sp),
                decoration: BoxDecoration(
                    color: AppColors.grayTile,
                    borderRadius: BorderRadius.circular(15.0)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Services",  style: GoogleFonts.workSans(
                        textStyle: TextStyle(
                            fontSize: 28.sp,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w700))),
                    Image.asset("assets/images/service.png", height: query.height * 0.09)
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
        return const LogoutDialog();
      },
    );
  }
}

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
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
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.clear();
            Navigator.pushAndRemoveUntil(
                context,
                FadePageRoute(
                    builder: (context) => const AuthSelectionScreen()),
                (_) => false);
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
  }
}
