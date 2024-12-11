import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/components/custom_button.dart';
import 'package:fortfitness/screens/dashboard/services/bloc/service_bloc.dart';
import 'package:fortfitness/screens/dashboard/services/model/service_response_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../components/appbar_custom.dart';
import '../../../components/cutom_textfield.dart';
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
  final _formKey = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  ServiceBloc serviceBloc =
      ServiceBloc(ServiceRepository(serviceDatasource: ServiceDatasource()));
  bool showSpinner = false;

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
    timeController.dispose();
    _noteFocusNode.dispose();
  }

  bool _isDDFocused = false;
  final FocusNode _noteFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _noteFocusNode.addListener(() {
      setState(() {
        _isDDFocused = _noteFocusNode.hasFocus;
      });
    });
  }

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
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(18.sp),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          _selectDate(context);
                        },
                        child: IgnorePointer(
                          child: CustomTextField(
                            titleText: "Select Date",
                            controller: dateController,
                            isSecure: false,
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: "Select Date",
                              filled: true,
                              fillColor: const Color(0xFFF3F3F4),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Icon(Icons.calendar_month, color: AppColors.primaryColor),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "ⓘ Please select date";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: (){
                          _selectTime(context);
                        },
                        child: IgnorePointer(
                          child: CustomTextField(

                            titleText: "Select Time",
                            controller: timeController,
                            isSecure: false,
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: "Select Time",
                              filled: true,
                              fillColor: const Color(0xFFF3F3F4),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Icon(Icons.watch_later_outlined, color: AppColors.primaryColor),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "ⓘ Please select Time";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Notes",
                              style: GoogleFonts.workSans(
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w600))),
                          SizedBox(height: 4.sp),
                          Container(
                            padding: EdgeInsets.all(4.sp),
                            decoration: BoxDecoration(
                                color: _isDDFocused
                                    ? AppColors.primaryColor
                                    .withOpacity(0.2)
                                    : Colors.transparent,
                                borderRadius:
                                BorderRadius.circular(12.0)),
                            child: TextFormField(
                              controller: noteController,
                              focusNode: _noteFocusNode,
                              keyboardType: TextInputType.text,
                              maxLines: 4,
                              maxLength: 300,
                              style: GoogleFonts.workSans(
                                  textStyle: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w600)),
                              decoration: InputDecoration(
                                  counter: const SizedBox.shrink(),
                                  filled: true,
                                  fillColor: const Color(0xFFF3F3F4),
                                  hintText: 'Write notes...',
                                  hintStyle: GoogleFonts.workSans(
                                      color: const Color(0xFFBABBBE),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.primaryColor,
                                          width: 1.5),
                                      borderRadius:
                                      BorderRadius.circular(
                                          12.0) // Border radius
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.primaryColor,
                                          width: 1.5),
                                      borderRadius:
                                      BorderRadius.circular(12.0)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 1.5),
                                      borderRadius:
                                      BorderRadius.circular(12.0)),
                                  focusedErrorBorder:
                                  OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 1.5),
                                      borderRadius: BorderRadius
                                          .circular(12.0)),
                                  contentPadding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      SizedBox(
                          height: query.height * 0.072,
                          width: query.width * 0.6,
                          child: CustomButton(
                              title: ButtonString.btnBookNow,
                              onClick: () {
                                FocusScope.of(context).requestFocus(FocusNode());

                                if(_formKey.currentState!.validate()){
                                 ClaimServiceRequest claimServiceRequest =
                                 ClaimServiceRequest(
                                   serviceId: widget.serviceList!.id!.toString(),
                                   date: dateController.text.trim(),
                                   time: timeController.text.trim(),
                                   note: noteController.text,
                                 );
                                 serviceBloc.add(ClaimServiceEvent(claimServiceRequest));
                               }
                              },
                              fontColor: AppColors.whiteColor,
                              buttonColor: AppColors.primaryColor)),
                    ],
                  ),
                ),
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
        timeController.text = "${pickedTime.replacing().hour}:${pickedTime.replacing().minute}";
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
        dateController.text = pickedDate.toString();
        dateController.text =
            DateFormat('yyyy-MM-dd').format(DateTime.parse(dateController.text));
      });
    }
  }
}
