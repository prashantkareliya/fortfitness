import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/components/custom_button.dart';
import 'package:fortfitness/screens/dashboard/services/bloc/service_bloc.dart';
import 'package:fortfitness/screens/dashboard/services/model/service_response_model.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../components/appbar_custom.dart';
import '../../../components/progress_indicator.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import '../dashboard_screen.dart';
import 'data/service_datasource.dart';
import 'data/service_repository.dart';
import 'model/claim_service_request.dart';

class ClaimServicePage extends StatefulWidget {
  Data? serviceList;

  ClaimServicePage(this.serviceList, {super.key});

  @override
  State<ClaimServicePage> createState() => _ClaimServicePageState();
}

class _ClaimServicePageState extends State<ClaimServicePage> {
  String selectDate = "Select Date";
  String selectTime = "Select Time";

  ServiceBloc serviceBloc =
      ServiceBloc(ServiceRepository(serviceDatasource: ServiceDatasource()));
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppbar(
        title: widget.serviceList?.name ?? "",
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: SvgPicture.asset("assets/icons/back.svg")),
      ),
      body: BlocConsumer<ServiceBloc, ServiceState>(
        bloc: serviceBloc,
        listener: (context, state) {
          if (state is ClaimServiceFailure) {
            showSpinner = false;
            Helpers.showSnackBar(context, state.error);
          }
          if (state is ClaimServiceLoading) {
            showSpinner = true;
          }
          if (state is ClaimServiceLoaded) {
            showSpinner = false;
            Helpers.showSnackBar(
                context, state.claimServiceResponse.message ?? "");
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => DashboardScreen()));
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: showSpinner,
            progressIndicator: SpinKitCircle(
                color: AppColors.primaryColor,
                size: 60.0),
            child: Padding(
              padding: EdgeInsets.all(18.sp),
              child: Column(
                children: [
                  SizedBox(
                      //String formattedDate = DateFormat('MM/dd/yyyy hh:mm a').format(now);
                      height: query.height * 0.072,
                      child: CustomButton(
                        buttonColor: AppColors.grayTile,
                        title: selectDate,
                        onClick: () {
                          _selectDate(context);
                        },
                        fontColor: AppColors.blackColor,
                      )),
                  SizedBox(height: query.height * 0.02),
                  SizedBox(
                      height: query.height * 0.072,
                      child: CustomButton(
                        buttonColor: AppColors.grayTile,
                        title: selectTime,
                        onClick: () {
                          _selectTime(context);
                        },
                        fontColor: AppColors.blackColor,
                      )),
                  SizedBox(height: query.height * 0.05),
                  SizedBox(
                      height: query.height * 0.072,
                      width: query.width * 0.6,
                      child: CustomButton(
                          title: ButtonString.btnClaimService,
                          onClick: () {
                            ClaimServiceRequest claimServiceRequest =
                                ClaimServiceRequest(
                              serviceId: widget.serviceList!.id!.toString(),
                                  date: selectDate,
                                  time: selectTime);
                            serviceBloc.add(ClaimServiceEvent(claimServiceRequest));
                          },
                          fontColor: AppColors.whiteColor,
                          buttonColor: AppColors.primaryColor)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    );

    if (pickedTime != null) {
      print(
          'Selected Time: ${pickedTime.replacing().hour} : ${pickedTime.replacing().minute}');
      setState(() {
        selectTime =
            "${pickedTime.replacing().hour}:${pickedTime.replacing().minute}";
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime(2101);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null && pickedDate != initialDate) {
      setState(() {
        selectDate = pickedDate.toString();
        selectDate =
            DateFormat('yyyy-MM-dd').format(DateTime.parse(selectDate));
      });
    }
  }
}
