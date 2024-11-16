import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

class CommonHeader extends StatelessWidget {
  CommonHeader({super.key, this.text1, this.text2, this.isBack});

  String? text1 = "";
  String? text2 = "";
  bool? isBack;
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: text1 ?? "",
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    fontSize: 28.sp,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w400))),
                        TextSpan(text: text2 ?? ""),
                      ],
                      style: GoogleFonts.workSans(
                          textStyle: TextStyle(
                              fontSize: 40.sp,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold)))),
              isBack == true ? GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                  child: SvgPicture.asset("assets/icons/back.svg")) : const SizedBox.shrink(),
            ],
          )
        ]);
  }
}
