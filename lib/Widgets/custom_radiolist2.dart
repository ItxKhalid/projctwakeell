import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../Utils/colors.dart';
import '../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import 'custom_text.dart';

class CustomRadioList2 extends StatefulWidget {
   String radioValue1;
   String groupValue1;
   ValueChanged<String?> onChanged1;
   String? subtitle1;
   Widget? image1;
   Decoration? decoration1;
   EdgeInsetsGeometry? contentpadding1;

  CustomRadioList2({
    Key? key,
    required this.radioValue1,
    required this.onChanged1,
    required this.groupValue1,
    this.image1,
    this.subtitle1,
    this.decoration1,
    this.contentpadding1,
  }) : super(key: key);

  @override
  _CustomRadioList2State createState() => _CustomRadioList2State();
}

class _CustomRadioList2State extends State<CustomRadioList2> {
  bool isSelected1 = false;

  @override
  void initState() {
    isSelected1 = widget.radioValue1 == widget.groupValue1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    isSelected1 = widget.radioValue1 == widget.groupValue1;
    Color backgroundColor = isSelected1
        ? (themeProvider.themeMode == ThemeMode.dark ? AppColors.blackA19 : Colors.grey.shade100)
        : (themeProvider.themeMode == ThemeMode.dark ? AppColors.black : Colors.grey.shade100);
    // Color backgroundColor = isSelected1 ? AppColors.blackA19 : AppColors.black;
     Color borderColor = isSelected1 ? AppColors.tealB3 : AppColors.white;

    return InkWell(
      onTap: () {
        widget.onChanged1(widget.radioValue1);
      },
      child: Container(
        width: 326.w,
        height: 190.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top:20.h,left: 21.w),
                  child: widget.image1,
                ),
                Padding(
                  padding: EdgeInsets.only(top:20.h,left: 21.w),
                  child: Radio(

                    value: widget.radioValue1,
                    groupValue: widget.groupValue1,
                    onChanged: widget.onChanged1,
                    activeColor: AppColors.tealB3,
                  ),
                ),
              ],
            ),


              Padding(
                padding:  EdgeInsets.only(top: 20.h,left: 21.w,right: 21.w),
                child: CustomText(
                  text: widget.subtitle1!,
                  color:themeProvider.themeMode==ThemeMode.dark ? AppColors.white:AppColors.black ,
                  //color: AppColors.white,
                  fontSize: 20.sp,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
