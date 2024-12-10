import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/screens/dashboard/gym/model/gym_location_response.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../components/appbar_custom.dart';
import '../../../components/progress_indicator.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import '../../profile/profile_screen.dart';
import 'bloc/gym_location_bloc.dart';
import 'data/gym_location_datasource.dart';
import 'data/gym_location_repository.dart';
import 'model/location_claim_request.dart';

class GymDetailScreen extends StatefulWidget {
  Locations? location;

  GymDetailScreen({super.key, this.location});

  @override
  State<GymDetailScreen> createState() => _GymDetailScreenState();
}

class _GymDetailScreenState extends State<GymDetailScreen> {
  int? selectDoor;
  bool showSpinner = false;

  GymLocationBloc gymLocationBloc = GymLocationBloc(
      GymLocationRepository(gymLocationDatasource: GymLocationDatasource()));

  @override
  void initState() {
    super.initState();
    LocationClaimRequest locationClaimRequest =
        LocationClaimRequest(locationId: widget.location?.id.toString());
    gymLocationBloc.add(ClaimLocationEvent(locationClaimRequest));
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppbar(
        title: widget.location?.name ?? "",
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: SvgPicture.asset("assets/icons/back.svg")),
      ),
      body: BlocConsumer<GymLocationBloc, GymLocationState>(
        bloc: gymLocationBloc,
        listener: (context, state) {
          if (state is ClaimLocationFailure) {
            showSpinner = false;
            Helpers.showSnackBar(context, state.error);
          }
          if (state is ClaimLocationLoading) {
            showSpinner = true;
          }
          if (state is ClaimLocationLoaded) {
            showSpinner = false;
            /*Helpers.showSnackBar(
                context, state.locationClaimResponse.message ?? "");*/
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: showSpinner,
            progressIndicator: SpinKitCircle(
                color: AppColors.primaryColor,
                size: 60.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.sp),
              child: SizedBox(
                width: query.width,
                child: Column(
                  children: [
                    SizedBox(height: 50.sp),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
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
                                    color: selectDoor == index
                                        ? AppColors.primaryColor
                                        : AppColors.grayTile,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(80.sp),
                                      topLeft: Radius.circular(25.sp),
                                      bottomRight: Radius.circular(25.sp),
                                      bottomLeft: Radius.circular(25.sp),
                                    )),
                                padding: EdgeInsets.only(right: 25.sp),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/door.svg",
                                      color: selectDoor == index
                                          ? AppColors.whiteColor
                                          : const Color(0xFF989898),
                                    ),
                                    Text("Open Door 2",
                                        style: GoogleFonts.workSans(
                                            textStyle: TextStyle(
                                                fontSize: 28.sp,
                                                color: selectDoor == index
                                                    ? AppColors.whiteColor
                                                    : AppColors.primaryColor,
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
        },
      ),
    );
  }
}
