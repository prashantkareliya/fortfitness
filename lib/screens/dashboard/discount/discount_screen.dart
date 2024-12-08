import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortfitness/screens/dashboard/discount/bloc/discount_bloc.dart';
import 'package:fortfitness/screens/dashboard/discount/data/discount_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../components/appbar_custom.dart';
import '../../../components/progress_indicator.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import '../../profile/profile_screen.dart';
import 'data/discount_datasource.dart';
import 'discount_detail.dart';
import 'model/get_discount_response.dart';

class DiscountScreen extends StatefulWidget {
  const DiscountScreen({super.key});

  @override
  State<DiscountScreen> createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
  bool showSpinner = false;

  DiscountBloc discountBloc = DiscountBloc(
      DiscountRepository(discountDatasource: DiscountDatasource()));
  List<Data> discountList = [];

  @override
  void initState() {
    super.initState();
    discountBloc.add(GetDiscountEvent());
  }

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
          if (state is DiscountFailure) {
            showSpinner = false;
            Helpers.showSnackBar(context, state.error);
          }
          if (state is DiscountLoading) {
            showSpinner = true;
          }
          if (state is DiscountLoaded) {
            showSpinner = false;
            discountList = state.discountResponse.data!;
            Helpers.showSnackBar(context, state.discountResponse.message ?? "");
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: showSpinner,
            progressIndicator: SpinKitCircle(
                color: AppColors.primaryColor,
                size: 60.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.sp),
              child: SizedBox(
                width: query.width,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: discountList.isEmpty ? 0 : discountList.length,
                    itemBuilder: (context, index) {
                      final discount = discountList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DiscountDetailScreen(
                                      discountList[index])));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.sp),
                          child: Container(
                            height: query.height * 0.13,
                            width: query.width / 1.28,
                            decoration: BoxDecoration(
                                color: AppColors.grayTile,
                                borderRadius: BorderRadius.circular(15.sp)),
                            padding: EdgeInsets.only(left: 20.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(discount.name ?? "",
                                      maxLines: 2,
                                      style: GoogleFonts.workSans(
                                          textStyle: TextStyle(
                                              fontSize: 28.sp,
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.w700))),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.sp),
                                  child: Container(
                                    height: query.height * 0.13,
                                    width: query.width * 0.26,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(15.sp)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            "${discount.discount.toString().substring(0, 2)}%",
                                            style: GoogleFonts.workSans(
                                                textStyle: TextStyle(
                                                    fontSize: 28.sp,
                                                    color: AppColors.whiteColor,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Text("OFF",
                                            style: GoogleFonts.workSans(
                                                textStyle: TextStyle(
                                                    height: 1.0,
                                                    fontSize: 22.sp,
                                                    color: AppColors.whiteColor,
                                                    fontWeight:
                                                        FontWeight.normal)))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
        ),
          );
        },
      ),
    );
  }
}
