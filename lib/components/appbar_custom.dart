import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortfitness/components/network_image.dart';
import 'package:fortfitness/screens/auth/bloc_user/user_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/profile/profile_screen.dart';
import '../utils/app_colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color backgroundColor;
  final double height;
  final double? fontSize;

  String? profileImage;
  //SharedPreferences? preferences;

  CustomAppbar(
      {super.key,
      required this.title,
      this.actions,
      this.leading,
      this.backgroundColor = Colors.blue,
      this.height = 60.0,
      this.profileImage,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<UserBloc, UserState>(
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
                    maxLines: 2,
                    style: GoogleFonts.workSans(
                        textStyle: TextStyle(
                            fontSize: fontSize ?? 28.0,
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
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfilePage()));
                            },
                            icon: ClipOval(
                              child: SizedBox.fromSize(
                                  size: Size.fromRadius(18.sp),
                                  child: CustomCachedImage(
                                      imageUrl: state
                                              .profileResponse?.data?.image ??
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
