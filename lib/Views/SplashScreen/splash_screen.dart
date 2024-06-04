import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:projctwakeell/Views/HomePage_lawyer_screen/home_page_lawyer_screen.dart';
import 'package:projctwakeell/Views/LoginAsClientScreen/login_as_client_screen.dart';
import 'package:projctwakeell/Views/LoginAsLawyerScreen/login_as_lawyer_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Utils/colors.dart';
import '../../Utils/images.dart';
import '../../Widgets/custom_text.dart';
import '../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import '../../user_provider.dart';
import '../HomePageClientScreen/home_page_client_screen.dart';
import '../selection_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final prefs = await SharedPreferences.getInstance();
      AppConst.getUserType = prefs.getString(AppConst.saveUserType).toString();
      AppConst.getUserName = prefs.getString(AppConst.saveUserName).toString();


      if (userProvider.loggedInUser != null ) {
        Get.offAll(() => HomePageClientScreen(loggedInUser: userProvider.loggedInUser!));
      } else if(
      userProvider.loggedInLawyer != null){
        Get.offAll(() => const HomePageLawyerScreen());
      }
      else if (userProvider.loggedInUser == null ||
          userProvider.loggedInLawyer == null) {
        Get.to(() =>   const SelectionScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 220.h, left: 103.w, right: 103.w),
              child: Image.asset(
                AppImages.logoimg,
                width: 187.w,
                height: 197.h,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: CustomText(
                textAlign: TextAlign.center,
                text: AppLocalizations.of(context)!.wakeel_naama,
                color: themeProvider.themeMode == ThemeMode.dark
                    ? AppColors.white // Dark theme color
                    : AppColors.black,
                // Light theme color
                fontSize: 36.8.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'Acme',
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(top: 110.h, left: 50.w, right: 37.w),
            //   child: RichText(
            //     textAlign: TextAlign.center,
            //     text: TextSpan(children: <TextSpan>[
            //       TextSpan(
            //         text: 'By pressing Accept, you agree to our ',
            //         style: TextStyle(
            //           fontWeight: FontWeight.w600,
            //           fontSize: 13.44.sp,
            //           color: themeProvider.themeMode == ThemeMode.dark
            //               ? AppColors.white // Dark theme color
            //               : AppColors.black,
            //           fontFamily: 'Mulish',
            //         ),
            //       ),
            //       TextSpan(
            //         text: 'terms & conditions',
            //         style: TextStyle(
            //           fontWeight: FontWeight.w600,
            //           fontSize: 13.44.sp,
            //           color: AppColors.tealB3,
            //           fontFamily: 'Mulish',
            //         ),
            //       ),
            //       TextSpan(
            //         text: '  and  ',
            //         style: TextStyle(
            //           fontWeight: FontWeight.w600,
            //           fontSize: 13.44.sp,
            //           color: themeProvider.themeMode == ThemeMode.dark
            //               ? AppColors.white // Dark theme color
            //               : AppColors.black,
            //           fontFamily: 'Mulish',
            //         ),
            //       ),
            //       TextSpan(
            //         text: 'privacy policy',
            //         style: TextStyle(
            //           fontWeight: FontWeight.w600,
            //           fontSize: 13.44.sp,
            //           color: AppColors.tealB3,
            //           fontFamily: 'Mulish',
            //         ),
            //       ),
            //     ]),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(top: 20.h, left: 38.w, right: 38.w),
            //   child: GestureDetector(
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => ChooseLanguageScreen()),
            //       );
            //     },
            //     child: CustomButton(
            //       borderRadius: BorderRadius.circular(10.r),
            //       height: 55.h,
            //       width: 317.w,
            //       fontWeight: FontWeight.w400,
            //       fontFamily: 'Mulish',
            //       fontSize: 22.2.sp,
            //       text: 'Accept',
            //       backgroundColor: AppColors.tealB3,
            //       color: AppColors.white,
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(top: 21.h, left: 38.w, right: 38.w),
            //   child: CustomButton(
            //     borderRadius: BorderRadius.circular(10.r),
            //     border: Border.all(color: AppColors.tealB3),
            //     height: 55.h,
            //     width: 317.w,
            //     fontWeight: FontWeight.w400,
            //     fontFamily: 'Mulish',
            //     fontSize: 22.2.sp,
            //     text: 'Decline',
            //     backgroundColor: AppColors.blackA19,
            //     color: AppColors.white,
            //     onTap: () {
            //       exit(0);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
