import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortfitness/constants/strings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/profile/bloc/profile_bloc.dart';
import '../screens/profile/data/profile_datasource.dart';
import '../screens/profile/data/profile_repository.dart';
import '../screens/profile/profile_screen.dart';
import '../utils/app_colors.dart';
import '../utils/helpers.dart';
import '../utils/preferences.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color backgroundColor;
  final double height;

  String? profileImage;
  //SharedPreferences? preferences;

  CustomAppbar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.backgroundColor = Colors.blue,
    this.height = 60.0,
    this.profileImage
  });

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
    return SafeArea(
      child: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) {
          if (state is ProfileFailure) {}
          if (state is ProfileLoading) {}
          if (state is ProfileLoaded) {
            profileImage = state.profileResponse.data!.image.toString();
          }
        },
        builder: (context, state) {
          return Container(
            height: height,
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leading ??
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.workSans(
                    textStyle: TextStyle(
                        fontSize: 28.sp,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700)),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: actions ??
                  [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfilePage()));
                        },
                        icon: ClipOval(
                          child: SizedBox.fromSize(
                              size: Size.fromRadius(18.sp),
                              child: Image.network(profileImage ??
                                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                                  fit: BoxFit.cover)),
                        ))
                  ],
            ),
          ],
        ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
