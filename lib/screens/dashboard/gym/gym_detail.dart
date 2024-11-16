import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';
import '../../profile/profile_screen.dart';

class GymDetailScreen extends StatefulWidget {
  const GymDetailScreen({super.key});

  @override
  State<GymDetailScreen> createState() => _GymDetailScreenState();
}

class _GymDetailScreenState extends State<GymDetailScreen> {
  int? selectDoor;

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
        title: Text("Sliema",
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
                  itemCount: 3,
                  itemBuilder: (context, index){
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectDoor = index;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.sp),
                    child: Container(
                      height: query.height * 0.14,
                      width: query.width / 1.28,
                      decoration: BoxDecoration(
                          color: selectDoor == index ? AppColors.primaryColor : AppColors.grayTile,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(80.sp),
                            topLeft: Radius.circular(25.sp),
                            bottomRight: Radius.circular(25.sp),
                            bottomLeft: Radius.circular(25.sp),
                          )
                      ),
                      padding: EdgeInsets.only(right: 25.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset("assets/icons/door.svg", color: selectDoor == index ? AppColors.whiteColor : const Color(0xFF989898),),
                          Text("Open Door 2",
                              style: GoogleFonts.workSans(
                                  textStyle: TextStyle(
                                      fontSize: 28.sp,
                                      color: selectDoor == index ? AppColors.whiteColor : AppColors.primaryColor,
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
