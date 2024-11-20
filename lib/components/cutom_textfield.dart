import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

InputDecoration kTextFieldDecoration = InputDecoration(
    hintText: 'Enter value',
    hintStyle: GoogleFonts.workSans(
        color: const Color(0xFFBABBBE),
        fontWeight: FontWeight.w600,
        fontSize: 16.sp),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(12.0) // Border radius
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(12.0)),
    errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
        borderRadius: BorderRadius.circular(12.0)),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
        borderRadius: BorderRadius.circular(12.0)),
    prefixIcon: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SvgPicture.asset("assets/svg/email.svg",
          colorFilter:
          ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn)),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18));

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final String? Function(String?)? validator;
  final String? titleText;
  final TextInputType? keyBoardType;
  bool isSecure;

  CustomTextField({super.key, this.controller, this.decoration, this.validator, this.titleText, this.keyBoardType, this.isSecure = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;


  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
       _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.titleText ?? "",
            style: GoogleFonts.workSans(
                textStyle: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600))),
        SizedBox(height: 8.sp),
        Container(
          padding: EdgeInsets.all(4.sp),
          decoration: BoxDecoration(
              color: _isFocused
                  ? AppColors.primaryColor.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12.0)),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: widget.keyBoardType,
            obscureText: widget.isSecure,
            style: GoogleFonts.workSans(
                textStyle: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600)),
            decoration: widget.decoration,
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}
