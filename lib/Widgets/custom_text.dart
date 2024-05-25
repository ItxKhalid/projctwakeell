import 'package:flutter/material.dart';
class CustomText extends StatelessWidget {
  TextAlign? textAlign;
  String text;
  Color color;
  double fontSize;
  FontWeight fontWeight;
  String fontFamily;
   int? maxLines;
  TextDecoration? underline;

   CustomText({super.key ,
     required this.text,
     this.maxLines,
     required this.color,
     required this.fontSize,
     this.underline,
    required this.fontWeight,
     required this.fontFamily,
     this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      text,
      maxLines:maxLines ,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight:fontWeight,
        fontFamily: fontFamily,
        color:color,
        decoration:underline,

      ),
    );
  }
}
