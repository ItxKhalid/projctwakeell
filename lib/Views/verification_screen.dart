import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projctwakeell/Utils/colors.dart';
import 'package:projctwakeell/Utils/images.dart';
import 'package:provider/provider.dart';
import '../../Widgets/custom_Container_button.dart';
import '../../Widgets/custom_container_textform_field.dart';
import '../../Widgets/custom_text.dart';
import '../../service/Userclass.dart';
import '../../themeChanger/themeChangerProvider/theme_changer_provider.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController confirmpasswordController=TextEditingController();
  bool passVisibility=false;
  final _formKey=GlobalKey<FormState>();
  UserModel? loggedInUser;

  @override
  void dispose() {
    emailController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:  EdgeInsets.only(top:100.h,left: 76.w,right: 75.w),
                child: Image.asset(AppImages.logoimg,width: 100.w,height: 82.h,fit: BoxFit.cover,),
              ),
              Padding(
                padding:  EdgeInsets.only(top: 48.h,),
                child: Align(
                  alignment: Alignment.center,
                  child: CustomText(
                      textAlign: TextAlign.center,
                      text:'Wakeel Naama',
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? AppColors.tealB3 // Dark theme color
                          : AppColors.black,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily:'Acme'),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: 48.h,),
                child: Align(
                  alignment: Alignment.center,
                  child: CustomText(
                      textAlign: TextAlign.center,
                      text:'Email Verification',
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? AppColors.white // Dark theme color
                          : AppColors.black,
                      fontSize: 27.sp,
                      fontWeight: FontWeight.w300,
                      fontFamily:'Acme'),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: 26.h,left: 34.w,right: 33.w),
                child: Padding(
                  padding: EdgeInsets.only(top: 15,left: 20.w,right: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: CustomText(
                          textAlign: TextAlign.left,
                          text: 'Email',
                          color: themeProvider.themeMode==ThemeMode.dark? AppColors.white : AppColors.black,
                          //color: AppColors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: 13.h,),
                      CustomContainerTextFormField(
                        contentpadding: EdgeInsets.only(left: 15.w),
                        width: 286.w,
                        height: 38.h,
                        keyboardtype: TextInputType.text,
                        validator: (value) {
                        },
                        onFieldSubmitted: (value) {},
                        controller: emailController,
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding:  EdgeInsets.only(top: 20.h,left:38.w,right: 38.w,bottom: 30),
                child: GestureDetector(
                  onTap: () {},
                  child: CustomButton(borderRadius: BorderRadius.circular(10.r),
                      height: 55.h,
                      width: 317.w,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Mulish',
                      fontSize: 22.2.sp,
                      text: 'Proceed',
                      border: Border.all(color: AppColors.tealB3),
                      color: AppColors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
