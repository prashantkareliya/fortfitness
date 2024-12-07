import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/screens/dashboard/discount/bloc/discount_bloc.dart';
import 'package:fortfitness/screens/dashboard/discount/data/discount_repository.dart';
import 'package:fortfitness/screens/dashboard/discount/model/discount_claim_request.dart';
import 'package:fortfitness/screens/dashboard/discount/model/get_discount_response.dart';
import 'package:fortfitness/screens/dashboard/services/model/claim_service_request.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../components/custom_button.dart';
import '../../../components/cutom_textfield.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import '../../profile/profile_screen.dart';
import '../dashboard_screen.dart';
import 'data/discount_datasource.dart';

class UploadReceiptScreen extends StatefulWidget {
  Data discount;

  UploadReceiptScreen(this.discount, {super.key});

  @override
  State<UploadReceiptScreen> createState() => _UploadReceiptScreenState();
}

class _UploadReceiptScreenState extends State<UploadReceiptScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController totalAmountController = TextEditingController();

  String? base64Image;
  final ImagePicker _picker = ImagePicker();

  bool upload = false;

  @override
  void dispose() {
    super.dispose();
    totalAmountController.dispose();
  }

  DiscountBloc discountBloc = DiscountBloc(
      DiscountRepository(discountDatasource: DiscountDatasource()));
  bool showSpinner = false;
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
      body: BlocConsumer<DiscountBloc, DiscountState>(
        bloc: discountBloc,
        listener: (context, state) {
          if (state is ClaimDiscountFailure) {
            showSpinner = false;
            Helpers.showSnackBar(context, state.error);
          }
          if (state is ClaimDiscountLoading) {
            showSpinner = true;
          }
          if (state is ClaimDiscountLoaded) {
            showSpinner = false;
            Helpers.showSnackBar(
                context, state.discountClaimResponse.message ?? "");
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => DashboardScreen()));
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.sp),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Form(
                      key: _formKey,
                      child: CustomTextField(
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
                            return "ⓘ Please enter amount";
                          }
                          return null;
                        },
                      ),
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
                        GestureDetector(
                          onTap: pickLocalImage,
                          child: Container(
                            height: query.height * 0.25,
                            width: query.width,
                            decoration: BoxDecoration(
                                color: AppColors.grayTile,
                                borderRadius: BorderRadius.circular(15.sp),
                                border: Border.all(
                                    color: AppColors.primaryColor, width: 1)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    "assets/icons/upload_receipt.svg"),
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
                        ),
                      ],
                    ),
                    SizedBox(height: 10.sp),
                    if(upload)Padding(
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

                              if(_formKey.currentState!.validate()){
                                DiscountClaimRequest claimServiceRequest = DiscountClaimRequest(
                                  amount: totalAmountController.text.trim(),
                                  discountId: widget.discount.id.toString(),
                                  receipt: base64Image!,
                                );
                                discountBloc.add(ClaimDiscountEvent(claimServiceRequest));
                              }
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

  Future<void> pickLocalImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        File imageFile = File(image.path);
        List<int> imageBytes = await imageFile.readAsBytes();
        String base64String = base64Encode(imageBytes);
        setState(() {
          base64Image = base64String;
          upload = true;
        });
      } else {
        print("No image selected");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
