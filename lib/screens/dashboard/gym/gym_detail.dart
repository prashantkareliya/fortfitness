import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/screens/dashboard/gym/model/gym_location_response.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:fortfitness/components/appbar_custom.dart';
import 'package:fortfitness/components/progress_indicator.dart';
import 'package:fortfitness/utils/app_colors.dart';
import 'package:fortfitness/utils/helpers.dart';
import 'bloc/gym_location_bloc.dart';
import 'data/gym_location_datasource.dart';
import 'data/gym_location_repository.dart';
import 'model/kisi_response.dart';

class GymDetailScreen extends StatefulWidget {
  Locations? location;

  GymDetailScreen({super.key, this.location});

  @override
  State<GymDetailScreen> createState() => _GymDetailScreenState();
}

class _GymDetailScreenState extends State<GymDetailScreen> {
  bool showSpinner = false;

  GymLocationBloc gymLocationBloc = GymLocationBloc(
      GymLocationRepository(gymLocationDatasource: GymLocationDatasource()));

  List<KisiData> locksList = [];

  @override
  void initState() {
    super.initState();
    gymLocationBloc.add(KisiLocationEvent(widget.location!.placeId.toString()));
  }


  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppbar(
        title: widget.location?.name ?? "",
        fontSize: 20.0,
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: SvgPicture.asset("assets/icons/back.svg")),
      ),
      body: BlocConsumer<GymLocationBloc, GymLocationState>(
        bloc: gymLocationBloc,
        listener: (context, state) {
          if (state is KisiLocationFailure) {
            showSpinner = false;
            Helpers.showSnackBar(context, state.error);
          }
          if (state is KisiLocationLoading) {
            showSpinner = true;
          }
          if (state is KisiLocationLoaded) {
            showSpinner = false;
            locksList = state.kisiResponse.data!;
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
                    if(locksList.isEmpty)
                      Text("No data found",
                        style: GoogleFonts.workSans(
                          textStyle: TextStyle(
                              fontSize: 22.sp,
                              color:  AppColors.primaryColor,
                              fontWeight: FontWeight.w700)),)
                      else
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: locksList.isEmpty ? 0 : locksList.length,
                        itemBuilder: (context, index) {
                          final locks = locksList[index];
                          return GestureDetector(
                            onTap: () { },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.sp),
                              child: Container(
                                height: query.height * 0.14,
                                width: query.width / 1.28,
                                decoration: BoxDecoration(
                                    color: AppColors.grayTile,
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
                                      color: const Color(0xFF989898),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Text("Open - ${locks.name}",
                                          maxLines: 2,
                                          style: GoogleFonts.workSans(
                                          textStyle: TextStyle(
                                                  fontSize: 22.sp,
                                                  color:  AppColors.primaryColor,
                                                  fontWeight: FontWeight.w700))),
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
        },
      ),
    );
  }
}
