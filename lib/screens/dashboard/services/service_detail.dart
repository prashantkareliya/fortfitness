import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/screens/dashboard/discount/discount_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/custom_button.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import '../../profile/profile_screen.dart';

class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen({super.key});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
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
        title: Text("services 1",
            style: GoogleFonts.workSans(
                textStyle: TextStyle(
                    fontSize: 28.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700))),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProfilePage()));
            },
            icon: ClipOval(
                child: SizedBox.fromSize(
                    size: Size.fromRadius(18.sp),
                    child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUyllrW-u-01_B8qMki4ybHzbhuBWhUq3pMA&s", fit: BoxFit.cover))),
          ),
          SizedBox(width: 5.sp),

        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.sp),
        child: Container(
          width: query.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.sp),
              Image.asset("assets/images/image_demo.png", height: query.height * 0.07),
              SizedBox(height: 30.sp),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.grayTile,
                    borderRadius: BorderRadius.circular(15.sp)
                ),
                padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
                child: Column(
                  children: [
                    for (String point in [
                      'Lorem ipsum dolor sit amet, consectetur.',
                      'Aliquam tincidunt mauris eu risus.',
                      'Vestibulum auctor dapibus neque.',
                      'Nunc dignissim risus id metus.',
                      'Cras ornare tristique elit.',
                      'Vivamus vestibulum nulla nec ante.',
                      'Praesent placerat risus quis eros.',
                      'Fusce pellentesque suscipit nibh.'
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.brightness_1, size: 6),
                            const SizedBox(width: 8),
                            Expanded(child: Text(point, style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w400)))),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 15.sp),
              Row(
                children: [
                  SizedBox(
                    width: 35,
                      child: SvgPicture.asset("assets/icons/location.svg", height: 25.sp)),
                  SizedBox(width: 15.sp),
                  Expanded(
                    child: Text("123 st. lorem ipsum, Nr. location, City, State, Pin 3000345",
                        style: GoogleFonts.workSans(
                            textStyle: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400))),
                  )
                ],
              ),
              SizedBox(height: 5.sp),
              const Divider(color: Color(0xFFD9D9DA)),
              SizedBox(height: 5.sp),
              Row(
                children: [
                  SizedBox(
                      width: 35,
                      child: SvgPicture.asset("assets/icons/time.svg", height: 25.sp)),
                  SizedBox(width: 15.sp),
                  Expanded(
                    child: Text("Opening hour 8 AM - 8 PM",
                        style: GoogleFonts.workSans(
                            textStyle: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400))),
                  )
                ],
              ),
              SizedBox(height: 5.sp),
              const Divider(color: Color(0xFFD9D9DA)),
              SizedBox(height: 5.sp),
              Row(

                children: [
                  SizedBox(
                      width: 35,
                      child: SvgPicture.asset("assets/icons/service.svg", height: 25.sp)),
                  SizedBox(width: 15.sp),
                  Expanded(
                    child: Text("Service Menu Download PDF Now!",
                        style: GoogleFonts.workSans(
                            textStyle: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400))),
                  )
                ],
              ),
              SizedBox(height: 5.sp),
              const Divider(color: Color(0xFFD9D9DA)),
              SizedBox(height: 25.sp),
              SizedBox(
                  height: query.height * 0.072,
                  width: query.width * 0.5,
                  child: CustomButton(
                      imageName: ImageString.icSignIn,
                      title: ButtonString.btnSubmit,
                      onClick: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DiscountScreen()));
                      },
                      fontColor: AppColors.whiteColor,
                      buttonColor: AppColors.primaryColor)),
            ],
          ),
        ),
      ),
    );
  }
}
