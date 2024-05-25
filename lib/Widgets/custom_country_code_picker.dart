import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:projctwakeell/Utils/colors.dart';

class CustomCountryCodePicker extends StatelessWidget {
  double width;
  double height;
  Decoration? decorationcontainer;
  TextStyle hintStyle;
  String initialCountryCode;
  EdgeInsetsGeometry? contentPadding;
  Color color;
  Function(String) onPhoneChanged;

  CustomCountryCodePicker({super.key,
    required  this.height,
    required this.width,
    this.contentPadding,
    required this.color,
    this.decorationcontainer,
    required this.hintStyle,
    required this.initialCountryCode,
    required this.onPhoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: decorationcontainer,
      child: IntlPhoneField(
        cursorColor: AppColors.tealB3,
        dropdownIconPosition: IconPosition.trailing,
        flagsButtonPadding: EdgeInsets.only(left: 10.w,top: 18.h),
        decoration: InputDecoration(
          fillColor: AppColors.black12,
          hintStyle: hintStyle,
          border: InputBorder.none,
          contentPadding: contentPadding,

        ),
        style: TextStyle(
          color: color,
        ),
        textAlign: TextAlign.left,
        initialCountryCode: initialCountryCode,
        onChanged: (phone) {
          onPhoneChanged(phone.completeNumber);
        },

      ),
    );
  }
}


