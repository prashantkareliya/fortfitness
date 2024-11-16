import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/screens/dashboard/services/service_detail.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';
import '../../profile/profile_screen.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  int? selectService;
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
        title: Text("Services",
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
                          selectService = index;
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ServiceDetailScreen()));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.sp),
                        child: Container(
                          height: query.height * 0.13,
                          width: query.width / 1.28,
                          decoration: BoxDecoration(
                              color: selectService == index ? AppColors.primaryColor : AppColors.grayTile,
                              borderRadius: BorderRadius.circular(15.sp)
                          ),
                          padding: EdgeInsets.only(right: 25.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset("assets/icons/door.svg", color: selectService == index ? AppColors.whiteColor : const Color(0xFF989898),),
                              Text("Service ${index + 1}",
                                  style: GoogleFonts.workSans(
                                      textStyle: TextStyle(
                                          fontSize: 28.sp,
                                          color: selectService == index ? AppColors.whiteColor : AppColors.primaryColor,
                                          fontWeight: FontWeight.w700)))
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
