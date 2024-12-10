import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/screens/dashboard/discount/model/get_discount_response.dart';
import 'package:fortfitness/screens/dashboard/discount/upload_receipt.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/appbar_custom.dart';
import '../../../components/custom_button.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
class DiscountDetailScreen extends StatefulWidget {
  Data discount;

  DiscountDetailScreen(this.discount, {super.key});

  @override
  State<DiscountDetailScreen> createState() => _DiscountDetailScreenState();
}

class _DiscountDetailScreenState extends State<DiscountDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppbar(
        title: widget.discount.name ?? "",
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
              SizedBox(height: 30.sp),
              Container(
                height: query.height * 0.13,
                width: query.width / 1.28,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(15.sp)
                ),
                padding: EdgeInsets.only(left: 20.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.discount.logo != null)
                      Image.network(widget.discount.logo ?? "",
                          height: query.height * 0.08),
                    SizedBox(width: 10.sp),
                    Expanded(
                      child: Text(widget.discount.address ?? "",
                          maxLines: 2,
                          style: GoogleFonts.workSans(
                              textStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w500))),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.sp),
                      child: Container(
                        height: query.height * 0.13,
                        width: query.width * 0.26,
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(15.sp)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "${widget.discount.discount.toString().substring(0, 2) ?? ""}% ",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.workSans(
                                    textStyle: TextStyle(
                                        fontSize: 28.sp,
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold))),
                            Text("OFF",
                                style: GoogleFonts.workSans(
                                    textStyle: TextStyle(
                                        height: 1.0,
                                        fontSize: 22.sp,
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.normal)))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 40.sp),
              if (widget.discount.logo != null)
                Image.network(widget.discount.logo ?? "",
                    height: query.height * 0.15),
              SizedBox(height: 30.sp),
              if (widget.discount.description != "")
                Container(
                decoration: BoxDecoration(
                    color: AppColors.grayTile,
                    borderRadius: BorderRadius.circular(15.sp)
                ),
                padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                child: Html(
                  data: widget.discount.description ?? "",
                ),
              ),
              SizedBox(height: 30.sp),
              SizedBox(
                  height: query.height * 0.072,
                  width: query.width * 0.55,
                  child: CustomButton(
                      imageName: ImageString.icClaimNow,
                      title: ButtonString.btnClaimNow,
                      onClick: widget.discount.isClaimed == true ? null :  () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UploadReceiptScreen(widget.discount)));
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
