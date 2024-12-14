import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/components/network_image.dart';
import 'package:fortfitness/screens/dashboard/services/data/service_datasource.dart';
import 'package:fortfitness/screens/dashboard/services/data/service_repository.dart';
import 'package:fortfitness/screens/dashboard/services/model/service_response_model.dart';
import 'package:fortfitness/utils/helpers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../components/appbar_custom.dart';
import '../../../components/custom_button.dart';
import '../../../components/progress_indicator.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import 'bloc/service_bloc.dart';
import 'claim_service_page.dart';

class ServiceDetailScreen extends StatefulWidget {
  Data? serviceList;

  ServiceDetailScreen(this.serviceList, {super.key});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  bool isDownloading = false;
  String downloadProgress = "0%";

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.sp),
        child: SizedBox(
          width: query.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.sp),
              if(widget.serviceList?.logo != null)
                CustomCachedImage(
                    imageUrl: widget.serviceList?.logo ?? "",
                    height: query.height * 0.18),
              SizedBox(height: 30.sp),
              if(widget.serviceList?.description != "")
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.grayTile,
                      borderRadius: BorderRadius.circular(15.sp)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                  child: Html(
                    data: widget.serviceList!.description ?? "",
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
              if(widget.serviceList!.startTime != null && widget.serviceList!.endTime != null)
                Column(
                  children: [
                    Row(
                    children: [
                      SizedBox(
                          width: 35,
                          child: SvgPicture.asset("assets/icons/time.svg", height: 25.sp)),
                      SizedBox(width: 15.sp),
                      Expanded(
                        child: Text(
                            "Opening hour ${widget.serviceList?.startTime?.substring(0, 5) ?? ""} - ${widget.serviceList?.endTime?.substring(0, 5) ?? ""}",
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
                  ],
                ),


              isDownloading
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 10),
                  Text("Downloading: $downloadProgress"),
                ],
              )
                  : widget.serviceList!.pdf != null ? Column(
                    children: [
                      Row(
                        children: [
                      SizedBox(
                          width: 35,
                          child: SvgPicture.asset("assets/icons/service.svg", height: 25.sp)),
                      SizedBox(width: 15.sp),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                              downloadPDF(
                                  widget.serviceList!.pdf.toString(),
                                  "${widget.serviceList?.name}.pdf");
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
                    ],
                  ) : const SizedBox.shrink(),

              SizedBox(
                  height: query.height * 0.072,
                  width: query.width * 0.5,
                  child: CustomButton(
                      imageName: ImageString.icSignIn,
                      title: ButtonString.btnBook,
                      onClick:  () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ClaimServicePage(widget.serviceList)));
                      },
                      fontColor: AppColors.whiteColor,
                      buttonColor: AppColors.primaryColor)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> downloadPDF(String url, String fileName) async {
    await Permission.storage.request();
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      //String filePath = "/storage/emulated/0/Download/$fileName";
      String filePath = Platform.isIOS ? '${directory.path}/$fileName' : '/storage/emulated/0/Download/$fileName';


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
