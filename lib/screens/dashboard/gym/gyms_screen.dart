import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/screens/dashboard/gym/bloc/gym_location_bloc.dart';
import 'package:fortfitness/screens/dashboard/gym/data/gym_location_datasource.dart';
import 'package:fortfitness/screens/dashboard/gym/data/gym_location_repository.dart';
import 'package:fortfitness/screens/profile/profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../components/custom_button.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import 'gym_detail.dart';
import 'model/gym_location_response.dart';

class GymScreen extends StatefulWidget {
  GymScreen({super.key});

  @override
  State<GymScreen> createState() => _GymScreenState();
}

class _GymScreenState extends State<GymScreen> {
  bool showSpinner = false;

  GymLocationBloc gymLocationBloc = GymLocationBloc(
      GymLocationRepository(gymLocationDatasource: GymLocationDatasource()));

  @override
  void initState() {
    super.initState();
    gymLocationBloc.add(GetGymLocationEvent());
  }

  List<Locations> gymLocation = [];
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
        title: Text("Gyms",
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
        body: BlocConsumer<GymLocationBloc, GymLocationState>(
          bloc: gymLocationBloc,
          listener: (context, state) {
            if (state is GetGymLocationFailure) {
              showSpinner = false;
              Helpers.showSnackBar(context, state.error);
            }
            if (state is GetGymLocationLoading) {
              showSpinner = true;
            }
            if (state is GetGymLocationLoaded) {
              showSpinner = false;
              gymLocation = state.gymLocationResponse.data!.locations!;
              Helpers.showSnackBar(
                  context, state.gymLocationResponse.message ?? "");
            }
          },
          builder: (context, state) {
            return showSpinner ? Center(child: CircularProgressIndicator()) : Column(
              children: [
                SizedBox(height: 30.sp),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: gymLocation.isEmpty ? 0 : gymLocation.length,
                      itemBuilder: (context, index) {
                        final location = gymLocation[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 50.sp),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          GymDetailScreen()));
                            },
                            child: Center(
                              child: Stack(
                                children: [
                                  Container(
                                    height: query.height * 0.25,
                                    width: query.width / 1.25,
                                    decoration: BoxDecoration(
                                        color: AppColors.grayTile,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 35.sp),
                                    margin: EdgeInsets.only(
                                        top: 40.sp, bottom: 25),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 20,
                                    child: Container(
                                      height: query.height * 0.13,
                                      width: query.width / 3.5,
                                      decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(25.sp),
                                          border: Border.all(
                                              color: AppColors.primaryColor)),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: query.width,
                                            height: 39.sp,
                                            decoration: BoxDecoration(
                                                color: AppColors.whiteColor,
                                                borderRadius:
                                                    BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                25.sp),
                                                        topRight:
                                                            Radius.circular(
                                                                25.sp))),
                                            child: Center(
                                              child: Text("Active Member",
                                                  style: GoogleFonts.workSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 10.sp,
                                                          color: AppColors
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w600))),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                                location.activeMembers
                                                    .toString(),
                                                style: GoogleFonts.workSans(
                                                    textStyle: TextStyle(
                                                        fontSize: 34.sp,
                                                        color: AppColors
                                                            .whiteColor,
                                                        fontWeight: FontWeight
                                                            .w700))),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 70,
                                    child: SizedBox(
                                        height: query.height * 0.06,
                                        width: query.width * 0.45,
                                        child: CustomButton(
                                            imageName: ImageString.icSignIn,
                                            title: ButtonString.btnEnter,
                                            onClick: () {},
                                            fontColor: AppColors.whiteColor,
                                            buttonColor:
                                                AppColors.primaryColor)),
                                  ),
                                  Positioned(
                                    left: 0,
                                    bottom: 75,
                                    child: Container(
                                      color: AppColors.whiteColor,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.sp, vertical: 8.sp),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/datetime.svg",
                                            height: 22.sp,
                                          ),
                                          SizedBox(width: 10.sp),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("9 December",
                                                  style: GoogleFonts.workSans(
                                                      textStyle: TextStyle(
                                                          height: 1,
                                                          fontSize: 10.sp,
                                                          color: AppColors
                                                              .blackColor,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w600))),
                                              Text("5 AM - 12 PM",
                                                  style: GoogleFonts.workSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 8.sp,
                                                          color: AppColors
                                                              .blackColor,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w400))),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 80,
                                      right: 20,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/location1.svg",
                                              height: 22.sp),
                                          SizedBox(
                                            width: 0.35.sw,
                                            child: Text(location.name ?? "",
                                                style: GoogleFonts.workSans(
                                                    textStyle: TextStyle(
                                                        fontSize: 24.sp,
                                                        color: AppColors
                                                            .primaryColor,
                                                        fontWeight: FontWeight
                                                            .w700))),
                                          ),
                                          SizedBox(
                                            width: 0.35.sw,
                                            child: Text(
                                                location.description ?? "",
                                                style: GoogleFonts.workSans(
                                                    textStyle: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: AppColors
                                                            .blackColor,
                                                        fontWeight: FontWeight
                                                            .w400))),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          },
        ));
  }
}
