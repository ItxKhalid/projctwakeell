import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../Utils/colors.dart';
import '../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import 'custom_text.dart';

class CustomRadioList extends StatefulWidget {
  String radioValue;
  String groupValue;
   ValueChanged<String?> onChanged;
   String title;
   Decoration? decoration;
   EdgeInsetsGeometry? contentpadding;

   CustomRadioList({
    Key? key,
    required this.radioValue,
    required this.onChanged,
    required this.groupValue,
    required this.title,
    this.decoration,
    this.contentpadding,
  }) : super(key: key);

  @override
  _CustomRadioListState createState() => _CustomRadioListState();
}
class _CustomRadioListState extends State<CustomRadioList> {
  bool isSelected = false;
  @override
  void initState() {
    isSelected = widget.radioValue == widget.groupValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    isSelected = widget.radioValue == widget.groupValue;

    // color: themeProvider.themeMode == ThemeMode.dark
    //     ? AppColors.grey33// Dark theme color
    //     : Colors.grey[100],
    Color backgroundColor = isSelected
        ? (themeProvider.themeMode == ThemeMode.dark ? AppColors.blackA19 : Colors.grey.shade100)
        : (themeProvider.themeMode == ThemeMode.dark ? AppColors.black : Colors.grey.shade100);
    // Color backgroundColor = isSelected ? AppColors.blackA19 : AppColors.black;
    Color borderColor = isSelected ? AppColors.tealB3 : AppColors.white;

    return InkWell(
      onTap: () {
        widget.onChanged(widget.radioValue);
      },
      child: Container(
        width: 326.w,
        height: 52.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: RadioListTile(
          contentPadding: widget.contentpadding,
          value: widget.radioValue,
          groupValue: widget.groupValue,
          onChanged: widget.onChanged,
          title: CustomText(
            text: widget.title,
            color: themeProvider.themeMode == ThemeMode.dark
                ? AppColors.white // Dark theme color
                : AppColors.black,
            // color: AppColors.white,
            fontSize: 18.41.sp,
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w600,
          ),
          activeColor: AppColors.tealB3,
          controlAffinity: ListTileControlAffinity.trailing,
        ),
      ),
    );
  }
}
