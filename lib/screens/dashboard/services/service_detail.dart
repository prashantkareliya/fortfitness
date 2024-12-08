import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/screens/dashboard/discount/discount_screen.dart';
import 'package:fortfitness/screens/dashboard/services/data/service_datasource.dart';
import 'package:fortfitness/screens/dashboard/services/data/service_repository.dart';
import 'package:fortfitness/screens/dashboard/services/model/claim_service_request.dart';
import 'package:fortfitness/screens/dashboard/services/model/service_response_model.dart';
import 'package:fortfitness/utils/helpers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';

import '../../../components/appbar_custom.dart';
import '../../../components/custom_button.dart';
import '../../../components/progress_indicator.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import '../../profile/profile_screen.dart';
import '../dashboard_screen.dart';
import 'bloc/service_bloc.dart';

class ServiceDetailScreen extends StatefulWidget {
  Data? serviceList;

  ServiceDetailScreen(this.serviceList, {super.key});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  bool isDownloading = false;
  String downloadProgress = "0%";

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
              padding: EdgeInsets.symmetric(horizontal: 18.sp),
              child: SizedBox(
                width: query.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.sp),
                    Image.network(widget.serviceList?.logo ?? "",
                        height: query.height * 0.07),
                    SizedBox(height: 30.sp),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.grayTile,
                      borderRadius: BorderRadius.circular(15.sp)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
                  child: Column(
                    children: [
                          /* for (String point in [
                        'Lorem ipsum dolor sit amet, consectetur.',
                        'Aliquam tincidunt mauris eu risus.',
                        'Vestibulum auctor dapibus neque.',
                        'Nunc dignissim risus id metus.',
                        'Cras ornare tristique elit.',
                        'Vivamus vestibulum nulla nec ante.',
                        'Praesent placerat risus quis eros.',
                        'Fusce pellentesque suscipit nibh.'
                      ])*/
                          Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.brightness_1, size: 6),
                              const SizedBox(width: 8),
                                Expanded(
                                    child: Text(
                                        widget.serviceList?.description ??
                                            "Description N/A",
                                        style: GoogleFonts.workSans(
                                            textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w400)))),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 15.sp),
                Row(
                  children: [
                    SizedBox(
                      width: 35,
                        child: SvgPicture.asset("assets/icons/location.svg", height: 25.sp)),
                    SizedBox(width: 15.sp),
                    Expanded(
                          child: Text(widget.serviceList?.address ?? "",
                              style: GoogleFonts.workSans(
                              textStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w400))),
                    )
                  ],
                ),
                SizedBox(height: 5.sp),
                const Divider(color: Color(0xFFD9D9DA)),
                SizedBox(height: 5.sp),
                Row(
                  children: [
                    SizedBox(
                        width: 35,
                        child: SvgPicture.asset("assets/icons/time.svg", height: 25.sp)),
                    SizedBox(width: 15.sp),
                    Expanded(
                          child: Text(
                              "Opening hour ${widget.serviceList?.startTime?.substring(0, 5)} - ${widget.serviceList?.endTime?.substring(0, 5)}",
                              style: GoogleFonts.workSans(
                              textStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w400))),
                    )
                  ],
                ),
                SizedBox(height: 5.sp),
                const Divider(color: Color(0xFFD9D9DA)),
                SizedBox(height: 5.sp),
                    isDownloading
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(),
                              const SizedBox(height: 10),
                              Text("Downloading: $downloadProgress"),
                            ],
                          )
                        : Row(
                  children: [
                    SizedBox(
                        width: 35,
                        child: SvgPicture.asset("assets/icons/service.svg", height: 25.sp)),
                    SizedBox(width: 15.sp),
                    Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    if (widget.serviceList!.pdf == null) {
                                      Helpers.showSnackBar(context,
                                          "Service menu is not available");
                                    } else {
                                      downloadPDF(
                                          widget.serviceList!.pdf.toString(),
                                          "${widget.serviceList?.name}.pdf");
                                    }
                                  },
                                  child: Text("Service Menu Download PDF Now!",
                                      style: GoogleFonts.workSans(
                                          textStyle: TextStyle(
                                              fontSize: 14.sp,
                                              color: AppColors.blackColor,
                                              fontWeight: FontWeight.w400))),
                                ),
                              )
                  ],
                ),
                SizedBox(height: 5.sp),
                const Divider(color: Color(0xFFD9D9DA)),
                SizedBox(height: 25.sp),
                SizedBox(
                    height: query.height * 0.072,
                    width: query.width * 0.5,
                    child: CustomButton(
                        imageName: ImageString.icSignIn,
                        title: ButtonString.btnSubmit,
                        onClick: () {
                          ClaimServiceRequest claimServiceRequest = ClaimServiceRequest(
                            serviceId: widget.serviceList!.id!.toString()
                          );
                          serviceBloc.add(ClaimServiceEvent(claimServiceRequest));
                        },
                        fontColor: AppColors.whiteColor,
                        buttonColor: AppColors.primaryColor)),
              ],
            ),
                    ),
            ),
          );
        },
      ),
    );
  }

  Future<void> downloadPDF(String url, String fileName) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      String filePath = "${directory.path}/$fileName";

      // Start downloading
      setState(() {
        isDownloading = true;
      });

      final http.Client client = http.Client();
      final http.Request request = http.Request('GET', Uri.parse(url));
      final http.StreamedResponse response = await client.send(request);

      final file = File(filePath);
      final fileSink = file.openWrite();

      int downloadedBytes = 0;
      final int totalBytes = response.contentLength ?? -1;

      await for (var chunk in response.stream) {
        fileSink.add(chunk);
        downloadedBytes += chunk.length;

        if (totalBytes != -1) {
          setState(() {
            downloadProgress =
                "${((downloadedBytes / totalBytes) * 100).toStringAsFixed(0)}%";
          });
        }
      }
      await fileSink.close();
      setState(() {
        isDownloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("PDF downloaded to: $filePath"),
      ));
    } catch (e) {
      setState(() {
        isDownloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to download PDF: $e"),
      ));
    }
  }
}
