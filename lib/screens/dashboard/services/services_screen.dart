import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/screens/dashboard/services/bloc/service_bloc.dart';
import 'package:fortfitness/screens/dashboard/services/data/service_datasource.dart';
import 'package:fortfitness/screens/dashboard/services/data/service_repository.dart';
import 'package:fortfitness/screens/dashboard/services/model/service_response_model.dart';
import 'package:fortfitness/screens/dashboard/services/service_detail.dart';
import 'package:fortfitness/utils/helpers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../components/appbar_custom.dart';
import '../../../components/progress_indicator.dart';
import '../../../utils/app_colors.dart';
import '../../profile/profile_screen.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  bool showSpinner = false;

  ServiceBloc serviceBloc =
      ServiceBloc(ServiceRepository(serviceDatasource: ServiceDatasource()));
  List<Data> serviceList = [];

  @override
  void initState() {
    super.initState();
    serviceBloc.add(GetServiceEvent());
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppbar(
        title: "Services",
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: SvgPicture.asset("assets/icons/back.svg")),
      ),
      body: BlocConsumer<ServiceBloc, ServiceState>(
        bloc: serviceBloc,
        listener: (context, state) {
          if (state is ServiceFailure) {
            showSpinner = false;
            Helpers.showSnackBar(context, state.error);
          }
          if (state is ServiceLoading) {
            showSpinner = true;
          }
          if (state is ServiceLoaded) {
            showSpinner = false;
            serviceList = state.serviceResponse.data!;
            Helpers.showSnackBar(context, state.serviceResponse.message ?? "");
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
                        itemCount: serviceList.isEmpty ? 0 : serviceList.length,
                        itemBuilder: (context, index) {
                          final service = serviceList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ServiceDetailScreen(serviceList[index])));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.sp),
                              child: Container(
                                height: query.height * 0.13,
                                width: query.width / 1.28,
                                decoration: BoxDecoration(
                                    color: AppColors.grayTile,
                                    borderRadius: BorderRadius.circular(15.sp)),
                                padding: EdgeInsets.only(right: 25.sp),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 20.sp),
                                    Image.network(service.logo ?? "", height: 70.sp,),
                                    SizedBox(width: 15.sp),
                                    Expanded(
                                      child: Text(service.name ?? "",
                                          maxLines: 2,
                                          style: GoogleFonts.workSans(
                                              textStyle: TextStyle(
                                                  fontSize: 28.sp,
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.w700))),
                                    ),
                                    const SizedBox.shrink()
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
