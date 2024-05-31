import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../Utils/colors.dart';
import '../themeChanger/themeChangerProvider/theme_changer_provider.dart';

class CustomContainerTextFormField extends StatefulWidget {
  TextEditingController controller;
  TextInputType keyboardtype;
  void Function(String)? onFieldSubmitted;
  String? Function(String?) validator;
  Widget? sufixIcon;
  Iterable<String>? autofillHints;
  String? obscuringCharacter;
  bool? obscureText;
  double width;
  double height;
  bool? readOnly;

  EdgeInsetsGeometry? contentpadding;

  CustomContainerTextFormField({super.key,
    this.obscureText = false,
    this.obscuringCharacter,
    this.sufixIcon,
    this.autofillHints,
    this.readOnly = false,
    required this.validator,
    required this.keyboardtype,
    required this.onFieldSubmitted,
    required this.controller,
    required this.width,
    required this.height,
    this.contentpadding,
  });

  @override
  State<CustomContainerTextFormField> createState() => _CustomContainerTextFormFieldState();
}

class _CustomContainerTextFormFieldState extends State<CustomContainerTextFormField> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return  Container(
width: widget.width,
      height: widget.height,
      child: TextFormField(
        readOnly: widget.readOnly!,
        cursorColor: AppColors.tealB3,
        controller: widget.controller,
        style: TextStyle(
          color: themeProvider.themeMode==ThemeMode.dark? AppColors.white:AppColors.black,
            // color: AppColors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            fontFamily:'Inter',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:widget.contentpadding ,
          fillColor: AppColors.black12,
            suffixIcon: widget.sufixIcon,
            labelStyle: TextStyle(
              color:AppColors.black919,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: BorderSide(
                  color: themeProvider.themeMode==ThemeMode.dark? AppColors.white:AppColors.black
                //  color: AppColors.white,
                )
            ),

          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(
                  color: themeProvider.themeMode==ThemeMode.dark? AppColors.white:AppColors.black
               // color: AppColors.white,
              )
          ),

        ),

        keyboardType: widget.keyboardtype,
        autofillHints: widget.autofillHints,
        onFieldSubmitted:widget.onFieldSubmitted,
        validator: widget.validator,
        obscureText: widget.obscureText!,
      ),
    );
  }
}
