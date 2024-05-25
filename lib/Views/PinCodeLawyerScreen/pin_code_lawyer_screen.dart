import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:projctwakeell/Views/ChooseLanguageScreen/choose_lang_screen.dart';
import 'package:projctwakeell/Views/HomePageClientScreen/home_page_client_screen.dart';
import 'package:provider/provider.dart';
import '../../Utils/colors.dart';
import '../../Utils/images.dart';
import '../../Widgets/custom_Container_button.dart';
import '../../Widgets/custom_text.dart';
import '../../service/Userclass.dart';
import '../../themeChanger/themeChangerProvider/theme_changer_provider.dart';

class PinCodeLawyerScreen extends StatefulWidget {
  const PinCodeLawyerScreen({super.key});

  @override
  State<PinCodeLawyerScreen> createState() => _PinCodeLawyerScreenState();
}
class _PinCodeLawyerScreenState extends State<PinCodeLawyerScreen> {
  UserModel? loggedInUser;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding:  EdgeInsets.only(top: 125.h,left: 150.w,right: 150.w),
                child: Image.asset(AppImages.logoimg,width:92.11.w ,height: 82.h ,fit: BoxFit.cover,),
              ),

              Padding(
                padding:  EdgeInsets.only(top: 28.h),
                child: Align(
                  alignment: Alignment.center,
                  child: CustomText(
                      textAlign: TextAlign.center,
                      text:'Wakeel Naama',
                      color: AppColors.tealB3,
                      fontSize: 36.8.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily:'Acme'),
                ),
              ),

              Padding(
                padding:  EdgeInsets.only(top: 28.h),
                child: Align(
                  alignment: Alignment.center,
                  child: CustomText(
                      textAlign: TextAlign.center,
                      text:'Enter PIN Code',
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? AppColors.white // Dark theme color
                          : AppColors.black,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily:'Mulish'),
                ),
              ),

              Padding(
                padding:EdgeInsets.all(39.0.w),
                child: Pinput(
                  length: 4,
                  obscuringCharacter: "*",
                  obscureText: true,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  defaultPinTheme: PinTheme(
                      width: 45.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: AppColors.blackA19,
                        border: Border.all(
                          color: AppColors.tealB3,
                        ),
                      ),
                      textStyle: TextStyle(
                        color: AppColors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily:'Inter',
                      )
                  ),
                ),
              ),

              Padding(
                padding:  EdgeInsets.only(top: 250.h,left:38.w,right: 38.w),
                child: GestureDetector(
                  onTap: (){
Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePageClientScreen(loggedInUser: loggedInUser!,)));
                  },
                  child: CustomButton(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColors.tealB3),
                      height: 55.h,
                      width: 317.w,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Mulish',
                      fontSize: 22.2.sp,
                      text: 'Proceed',
                      backgroundColor: AppColors.black,
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
