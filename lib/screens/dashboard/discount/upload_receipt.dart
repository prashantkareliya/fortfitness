import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/custom_button.dart';
import '../../../components/cutom_textfield.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import '../../profile/profile_screen.dart';

class UploadReceiptScreen extends StatefulWidget {
  const UploadReceiptScreen({super.key});

  @override
  State<UploadReceiptScreen> createState() => _UploadReceiptScreenState();
}

class _UploadReceiptScreenState extends State<UploadReceiptScreen> {
  TextEditingController totalAmountController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    totalAmountController.dispose();
  }
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
        title: Text("Discount",
            style: GoogleFonts.workSans(
                textStyle: TextStyle(
                    fontSize: 28.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700))),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProfilePage()));
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
        padding: EdgeInsets.symmetric(horizontal: 30.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              CustomTextField(
                titleText: "Total Amount",
                controller: totalAmountController,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Amount",
                  filled: true,
                  fillColor: const Color(0xFFF3F3F4),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: SvgPicture.asset("assets/icons/pound.svg",
                        colorFilter: ColorFilter.mode(
                            AppColors.primaryColor, BlendMode.srcIn)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "ⓘ Please enter your email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Receipt",
                      style: GoogleFonts.workSans(
                          textStyle: TextStyle(
                              fontSize: 18.sp,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w600))),
                  SizedBox(height: 4.sp),
                  Container(
                    height: query.height * 0.25,
                    width: query.width,
                    decoration: BoxDecoration(
                        color: AppColors.grayTile,
                        borderRadius: BorderRadius.circular(15.sp),
                        border: Border.all(color: AppColors.primaryColor, width: 1)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/icons/upload_receipt.svg"),
                        SizedBox(height: 15.sp),
                        Text("Tap to upload receipt here",
                            style: GoogleFonts.workSans(
                            textStyle: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xFF989898),
                                fontWeight: FontWeight.w600)))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.sp),
              Padding(
                padding: EdgeInsets.only(left: 12.sp),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/success.svg"),
                    SizedBox(width: 5.sp),
                    Text("File uploaded Successfully",
                        style: GoogleFonts.workSans(
                            textStyle: TextStyle(
                                fontSize: 10.sp,
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w600))),
                  ],
                ),
              ),
              SizedBox(height: query.height * 0.1),
              SizedBox(
                  height: query.height * 0.072,
                  width: query.width * 0.5,
                  child: CustomButton(
                      imageName: ImageString.icSignIn,
                      title: ButtonString.btnSubmit,
                      onClick: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProfilePage()));
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
