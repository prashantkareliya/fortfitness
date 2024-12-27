import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/screens/dashboard/discount/bloc/discount_bloc.dart';
import 'package:fortfitness/screens/dashboard/discount/data/discount_repository.dart';
import 'package:fortfitness/screens/dashboard/discount/model/discount_claim_request.dart';
import 'package:fortfitness/screens/dashboard/discount/model/get_discount_response.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../components/appbar_custom.dart';
import '../../../components/custom_button.dart';
import '../../../components/cutom_textfield.dart';
import '../../../components/progress_indicator.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
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

  //String? base64Image;
  final ImagePicker _picker = ImagePicker();
  File? _image1;

  //bool upload = false;

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
      appBar: CustomAppbar(
        title: "Discount",
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: SvgPicture.asset("assets/icons/back.svg")),
      ),
      body: BlocConsumer<DiscountBloc, DiscountState>(
        bloc: discountBloc,
        listener: (context, state) {
          if (state is ClaimDiscountFailure) {
            showSpinner = false;
            Helpers.showSnackBar(context, state.error);
            Navigator.pushAndRemoveUntil<dynamic>(context,
                MaterialPageRoute<dynamic>(builder: (BuildContext context) =>DashboardScreen()),
                    (route) => false);
          }
          if (state is ClaimDiscountLoading) {
            showSpinner = true;
          }
          if (state is ClaimDiscountLoaded) {
            showSpinner = false;
            Navigator.pushAndRemoveUntil<dynamic>(context,
                MaterialPageRoute<dynamic>(builder: (BuildContext context) =>DashboardScreen()),
                    (route) => false);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: showSpinner,
            progressIndicator: SpinKitCircle(
                color: AppColors.primaryColor,
                size: 60.0),
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
                        requiredText: "*",
                        controller: totalAmountController,
                        keyBoardType: const TextInputType.numberWithOptions(decimal: true),
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
                          } else if(int.tryParse(value) == null && double.tryParse(value) == null){
                            return 'ⓘ Only numbers are allowed';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "Receipt",
                                      style: GoogleFonts.workSans(
                                          textStyle: TextStyle(
                                              fontSize: 14.sp,
                                              color: AppColors.blackColor,
                                              fontWeight: FontWeight.w600))),
                                  const TextSpan(text: "*"),
                                ],
                                style: GoogleFonts.workSans(
                                    textStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColors.errorRed,
                                        fontWeight: FontWeight.w600)))),

                        SizedBox(height: 4.sp),
                        GestureDetector(
                          onTap: (){
                            _showImageSourceDialog();
                          },
                          child: Container(
                            //height: query.height * 0.25,
                            width: query.width,
                            decoration: BoxDecoration(
                                color: AppColors.grayTile,
                                borderRadius: BorderRadius.circular(15.sp),
                                border: Border.all(
                                    color: AppColors.primaryColor, width: 1)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 0.055.sh),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _image1 != null ?
                                  Image.file(
                                      _image1!,
                                      fit: BoxFit.contain) :
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
                        ),
                      ],
                    ),
                    SizedBox(height: 10.sp),

                      Visibility(
                        visible: _image1 != null,
                        child: Padding(
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
                      ),

                      Visibility(
                        visible: _image1 == null,
                        child: Padding(
                          padding: EdgeInsets.only(left: 12.sp),
                          child: Row(
                            children: [
                              Text("ⓘ Please upload receipt",
                                  style: GoogleFonts.workSans(
                                      textStyle: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColors.errorRed,
                                          fontWeight: FontWeight.w600))),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: query.height * 0.07),
                    SizedBox(
                        height: query.height * 0.072,
                        width: query.width * 0.5,
                        child: CustomButton(
                            imageName: ImageString.icSignIn,
                            title: ButtonString.btnSubmit,
                            onClick: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if(_formKey.currentState!.validate() && _image1 != null){
                                DiscountClaimRequest discountClaimRequest =
                                    DiscountClaimRequest(
                                  amount: totalAmountController.text.trim(),
                                  discountId: widget.discount.id.toString(),
                                  receipt: _image1 != null ? _image1!.path : "");
                                discountBloc.add(
                                    ClaimDiscountEvent(discountClaimRequest));
                                print(discountClaimRequest.toJson());
                              }
                            },
                            fontColor: AppColors.whiteColor,
                            buttonColor: AppColors.primaryColor)),
                    SizedBox(height: query.height * 0.02),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          surfaceTintColor: AppColors.primaryColor,
          title: Text("Select Option",
              style: GoogleFonts.workSans(
              textStyle: TextStyle(
                  fontSize: 28.sp,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w700))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text('Take a Photo',
                    style: GoogleFonts.workSans(
                    textStyle: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.normal))),
                onTap: () {
                  Navigator.pop(context);
                  pickLocalImage("camera");
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: Text('Choose from Gallery',
                    style: GoogleFonts.workSans(
                        textStyle: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.normal))),
                onTap: () {
                  Navigator.pop(context);
                  pickLocalImage("gallery");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickLocalImage(String option) async {
    try {
      final XFile? image;
      if(option == "camera"){
        image = await _picker.pickImage(source: ImageSource.camera);
      } else {
        image = await _picker.pickImage(source: ImageSource.gallery);
      }

      if (image != null) {
        File imageFile = File(image.path);
        List<int> imageBytes = await imageFile.readAsBytes();
        String base64String = base64Encode(imageBytes);
        setState(() {
          //base64Image = base64String;
          _image1 = imageFile;
        });
      } else {
        print("No image selected");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
