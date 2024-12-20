import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/screens/dashboard/gym/bloc/gym_location_bloc.dart';
import 'package:fortfitness/screens/dashboard/gym/data/gym_location_datasource.dart';
import 'package:fortfitness/screens/dashboard/gym/data/gym_location_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../components/appbar_custom.dart';
import '../../../components/custom_button.dart';
import '../../../components/progress_indicator.dart';
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
        appBar: CustomAppbar(
          title: "Gyms",
          backgroundColor: AppColors.whiteColor,
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: SvgPicture.asset("assets/icons/back.svg")),
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
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: showSpinner,
              progressIndicator: SpinKitCircle(
                  color: AppColors.primaryColor,
                  size: 60.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 35.0),
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: gymLocation.isEmpty ? 0 : gymLocation.length,
                    itemBuilder: (context, index) {
                      final location = gymLocation[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 50.sp),
                        child: Center(
                          child: Stack(
                            children: [
                              Container(
                                height: query.height * 0.25,
                                width: query.width / 1.25,
                                decoration: BoxDecoration(
                                    color: AppColors.grayTile,
                                    borderRadius: BorderRadius.circular(20.0)),
                                padding: EdgeInsets.symmetric(horizontal: 35.sp),
                                margin: EdgeInsets.only(top: 40.sp, bottom: 25),
                              ),
                              Positioned(
                                top: 0,
                                left: 20,
                                child: Container(
                                  height: query.height * 0.13,
                                  width: query.width / 3.5,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(25.sp),
                                      border: Border.all(color: AppColors.primaryColor)),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: query.width,
                                        height: 39.sp,
                                        decoration: BoxDecoration(
                                            color: AppColors.whiteColor,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25.sp),
                                                topRight: Radius.circular(25.sp))),
                                        child: Center(
                                          child: Text("Active Member",
                                              style: GoogleFonts.workSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: AppColors.primaryColor,
                                                      fontWeight: FontWeight.w600))),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                            location.activeMembers.toString(),
                                            style: GoogleFonts.workSans(
                                                textStyle: TextStyle(
                                                    fontSize: 34.sp,
                                                    color: AppColors.whiteColor,
                                                    fontWeight: FontWeight.w700))),
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
                                        onClick: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      GymDetailScreen(location: location)));
                                        },
                                        fontColor: AppColors.whiteColor,
                                        buttonColor: AppColors.primaryColor)),
                              ),
                              Positioned(
                                left: 0,
                                bottom: 75,
                                child: Container(
                                  color: AppColors.whiteColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.sp, vertical: 8.sp),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/datetime.svg",
                                        height: 22.sp),
                                      SizedBox(width: 10.sp),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text("9 December",
                                              style: GoogleFonts.workSans(
                                                  textStyle: TextStyle(
                                                      height: 1,
                                                      fontSize: 10.sp,
                                                      color: AppColors.blackColor,
                                                      fontWeight: FontWeight.w600))),
                                          Text(
                                              "${location.startTime ?? "N/A"} - ${location.endTime ?? "N/A"}",
                                              style: GoogleFonts.workSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 8.sp,
                                                      color: AppColors.blackColor,
                                                      fontWeight: FontWeight.w400))),
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
                                            maxLines: 2,
                                            style: GoogleFonts.workSans(
                                                textStyle: TextStyle(
                                                    height: 1.0,
                                                    fontSize: 16.sp,
                                                    color: AppColors.primaryColor,
                                                    fontWeight: FontWeight.w700))),
                                      ),
                                      SizedBox(
                                        width: 0.35.sw,
                                        child: Text(location.description ?? "",
                                            maxLines: 2,
                                            style: GoogleFonts.workSans(
                                                textStyle: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: AppColors.blackColor,
                                                    fontWeight: FontWeight.w400))),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            );
          },
        ));
  }
}
