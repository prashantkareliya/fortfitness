import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';
import '../../profile/profile_screen.dart';
import 'discount_detail.dart';

class DiscountScreen extends StatefulWidget {
  const DiscountScreen({super.key});

  @override
  State<DiscountScreen> createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
  int? selectDiscount;
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
        title: Text("Discount",
            style: GoogleFonts.workSans(
                textStyle: TextStyle(
                    fontSize: 28.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700))),
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35.sp),
        child: SizedBox(
          width: query.width,
          child: Column(
            children: [
              SizedBox(height: 50.sp),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectDiscount = index;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const DiscountDetailScreen()));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.sp),
                        child: Container(
                          height: query.height * 0.13,
                          width: query.width / 1.28,
                          decoration: BoxDecoration(
                              color: selectDiscount == index ? AppColors.primaryColor : AppColors.grayTile,
                              borderRadius: BorderRadius.circular(15.sp)
                          ),
                          padding: EdgeInsets.only(left: 20.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Disc ${index + 1}",
                                  style: GoogleFonts.workSans(
                                      textStyle: TextStyle(
                                          fontSize: 28.sp,
                                          color: selectDiscount == index ? AppColors.whiteColor : AppColors.primaryColor,
                                          fontWeight: FontWeight.w700))),
                              Padding(
                                padding: EdgeInsets.all(5.sp),
                                child: Container(
                                  height: query.height * 0.13,
                                  width: query.width * 0.26,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(15.sp)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("20% ",
                                          style: GoogleFonts.workSans(
                                              textStyle: TextStyle(
                                                  fontSize: 28.sp,
                                                  height: 0.8,
                                                  color: AppColors.whiteColor,
                                                  fontWeight: FontWeight.bold))),
                                  Text("OFF",
                                    style: GoogleFonts.workSans(
                                        textStyle: TextStyle(
                                            height: 1.0,
                                            fontSize: 22.sp,
                                            color: AppColors.whiteColor,
                                            fontWeight: FontWeight.normal)))
                                    ],
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                    );
                  }),

            ],
          ),
        ),
      ),
    );
  }
}
