import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   String text;
  Color color;
  double fontSize;
   String fontFamily;
 FontWeight fontWeight;
 Color? backgroundColor;
   BorderRadius borderRadius;
 double width;
   double height;
   Border? border;
   void Function()? onTap;

  // Constructor
  CustomButton({
    Key? key,
    required this.borderRadius,
    this.backgroundColor,
    required this.height,
    required this.width,
    required this.fontWeight,
    required this.fontFamily,
    required this.fontSize,
    required this.text,
    required this.color,
    this.border,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: border,
          borderRadius: borderRadius,
          color: backgroundColor,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: fontFamily,
            fontWeight: fontWeight,
            color: color,
          ),
        ),
      ),
    );
  }
}
