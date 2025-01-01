import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/components/network_image.dart';
import 'package:fortfitness/screens/dashboard/services/model/service_response_model.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/appbar_custom.dart';
import '../../../components/custom_button.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import 'claim_service_page.dart';

class ServiceDetailScreen extends StatefulWidget {
  Data? serviceList;

  ServiceDetailScreen(this.serviceList, {super.key});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
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
              if (widget.serviceList?.logo != null)
                CustomCachedImage(
                    imageUrl: widget.serviceList?.logo ?? "",
                    height: query.height * 0.18),
              SizedBox(height: 30.sp),
              if (widget.serviceList?.description != "")
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.grayTile,
                      borderRadius: BorderRadius.circular(15.sp)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                  child: Html(
                    data: widget.serviceList!.description ?? "",
                  ),
                ),
              SizedBox(height: 15.sp),
              Row(
                children: [
                  SizedBox(
                      width: 35,
                      child: SvgPicture.asset("assets/icons/location.svg",
                          height: 25.sp)),
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
              if (widget.serviceList!.startTime != null &&
                  widget.serviceList!.endTime != null)
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            width: 35,
                            child: SvgPicture.asset("assets/icons/time.svg",
                                height: 25.sp)),
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
              widget.serviceList!.pdf != null
                  ? Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                width: 35,
                                child: SvgPicture.asset(
                                    "assets/icons/service.svg",
                                    height: 25.sp)),
                            SizedBox(width: 15.sp),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  final url =
                                      widget.serviceList!.pdf.toString();
                                  final serviceName =
                                      widget.serviceList!.name.toString();
                                  /* if (await launchUrl(Uri.parse(url!),
                                      mode: LaunchMode.platformDefault)) {
                                    throw Exception('Could not launch $url');
                                  }*/
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              WebPdf(url, serviceName)));
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
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                  height: query.height * 0.072,
                  width: query.width * 0.5,
                  child: CustomButton(
                      imageName: ImageString.icSignIn,
                      title: ButtonString.btnBook,
                      onClick: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ClaimServicePage(widget.serviceList)));
                      },
                      fontColor: AppColors.whiteColor,
                      buttonColor: AppColors.primaryColor)),
            ],
          ),
        ),
      ),
    );
  }
}

class WebPdf extends StatelessWidget {
  String url;
  String serviceName;

  WebPdf(this.url, this.serviceName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: serviceName ?? "",
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: SvgPicture.asset("assets/icons/back.svg")),
      ),
      body: const PDF(swipeHorizontal: true).cachedFromUrl(
        url.toString(),
        placeholder: (progress) => Center(child: Text('$progress %')),
        errorWidget: (error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
