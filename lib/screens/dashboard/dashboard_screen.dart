import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/strings.dart';
import '../profile/profile_screen.dart';
import 'discount/discount_screen.dart';
import 'gym/gyms_screen.dart';
import 'services/services_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: SvgPicture.asset("assets/icons/back.svg")),
        title: Image.asset(ImageString.imgLogo5,
            height: query.height * 0.05),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
            },
            icon: ClipOval(
                child: SizedBox.fromSize(
                    size: Size.fromRadius(18.sp),
                    child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUyllrW-u-01_B8qMki4ybHzbhuBWhUq3pMA&s", fit: BoxFit.cover))),
          ),
          SizedBox(width: 5.sp),
        ],
      ),
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
                        builder: (context) =>
                        const GymScreen()));
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
}
