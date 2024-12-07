import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/screens/dashboard/discount/model/get_discount_response.dart';
import 'package:fortfitness/screens/dashboard/discount/upload_receipt.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/custom_button.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import '../../profile/profile_screen.dart';

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
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: SvgPicture.asset("assets/icons/back.svg")),
        title: Text(widget.discount.name ?? "",
            style: GoogleFonts.workSans(
                textStyle: TextStyle(
                    fontSize: 28.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700))),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
            },
            icon: ClipOval(
                child: SizedBox.fromSize(
                    size: Size.fromRadius(18.sp),
                    child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUyllrW-u-01_B8qMki4ybHzbhuBWhUq3pMA&s", fit: BoxFit.cover))),
          ),
          SizedBox(width: 5.sp),
        ],
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
                    Image.network(widget.discount.logo ?? "",
                        height: query.height * 0.06),
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
              Image.network(widget.discount.logo ?? "",
                  height: query.height * 0.12),
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
                              child: Text(widget.discount.description ?? "",
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
              SizedBox(height: 30.sp),
              SizedBox(
                  height: query.height * 0.072,
                  width: query.width * 0.55,
                  child: CustomButton(
                      imageName: ImageString.icClaimNow,
                      title: ButtonString.btnClaimNow,
                      onClick: () {
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
