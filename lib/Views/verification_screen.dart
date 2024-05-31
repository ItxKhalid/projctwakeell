import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projctwakeell/Views/LoginAsClientScreen/login_as_client_screen.dart';
import 'package:projctwakeell/Views/LoginAsLawyerScreen/login_as_lawyer_screen.dart';
import 'package:projctwakeell/Widgets/custom_Container_button.dart';

import '../../Widgets/custom_container_textform_field.dart';
import '../../Widgets/custom_text.dart';
import '../../Utils/colors.dart';
import '../../Utils/images.dart';
import '../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../service/Userclass.dart';

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
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UserModel? loggedInUser;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> checkEmailVerified(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    if (user?.emailVerified ?? false) {
      // Create an instance of UserModel with the retrieved data
      UserModel userModel = UserModel(
        userId: user!.uid,
        firstName: prefs.getString('user_fName') ?? 'First Name',
        lastName: prefs.getString('user_lName') ?? 'Last Name',
        email: user.email ?? '',
        cnic: prefs.getString('user_cnic') ?? 'CNIC',
        phoneNumber: prefs.getString('user_number') ?? 'Phone Number',
        gender: prefs.getString('user_gender') ?? 'Gender',
      );

      // Save user data to Firestore
      await FirebaseFirestore.instance
          .collection('client')
          .doc(user.uid)
          .set(userModel.toMap());

      await prefs.setString(AppConst.saveUserType, 'client');
      AppConst.getUserType = prefs.getString(AppConst.saveUserType)!;

      Get.snackbar(
        'Congratulations',
        'Successfully verified and signed up as a Client!',
        backgroundColor: AppColors.tealB3,
        colorText: AppColors.white,
        borderRadius: 20.r,
        icon: Icon(Icons.done, color: AppColors.white),
        snackPosition: SnackPosition.TOP,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginAsClientScreen(),
        ),
      );
    } else {
      Get.snackbar(
        'Error',
        'Email not verified yet. Please check your inbox.',
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
        borderRadius: 20.r,
        icon: Icon(Icons.error_outline, color: AppColors.white),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> checkLawyerEmailVerified(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    if (user?.emailVerified ?? false) {
      // Create an instance of LawyerModel with the retrieved data
      LawyerModel lawyerModel = LawyerModel(
        userId: user!.uid,
        firstName: prefs.getString('lawyer_fName') ?? 'First Name',
        lastName: prefs.getString('lawyer_lName') ?? 'Last Name',
        email: user.email ?? '',
        lNo: prefs.getString('lawyer_licenseNumber') ?? 'License Number',
        phoneNumber: prefs.getString('lawyer_number') ?? 'Phone Number',
        gender: prefs.getString('lawyer_gender') ?? 'Gender',
      );

      // Save lawyer data to Firestore
      await FirebaseFirestore.instance
          .collection('lawyer')
          .doc(user.uid)
          .set(lawyerModel.toMap());

      await prefs.setString(AppConst.saveUserType, 'lawyer');
      AppConst.getUserType = prefs.getString(AppConst.saveUserType)!;

      Get.snackbar(
        'Congratulations',
        'Successfully verified and signed up as a Lawyer!',
        backgroundColor: AppColors.tealB3,
        colorText: AppColors.white,
        borderRadius: 20.r,
        icon: Icon(Icons.done, color: AppColors.white),
        snackPosition: SnackPosition.TOP,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginAsLawyerScreen(),
        ),
      );
    } else {
      Get.snackbar(
        'Error',
        'Email not verified yet. Please check your inbox.',
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
        borderRadius: 20.r,
        icon: Icon(Icons.error_outline, color: AppColors.white),
        snackPosition: SnackPosition.TOP,
      );
    }
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
                padding: EdgeInsets.only(top: 100.h, left: 76.w, right: 75.w),
                child: Image.asset(AppImages.logoimg,
                    width: 100.w, height: 82.h, fit: BoxFit.cover),
              ),
              Padding(
                padding: EdgeInsets.only(top: 48.h),
                child: Align(
                  alignment: Alignment.center,
                  child: CustomText(
                      textAlign: TextAlign.center,
                      text: 'Wakeel Naama',
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? AppColors.tealB3 // Dark theme color
                          : AppColors.black,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Acme'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 48.h),
                child: Align(
                  alignment: Alignment.center,
                  child: CustomText(
                      textAlign: TextAlign.center,
                      text:
                          'A verification email has been sent to ${widget.email}.\n Please verify your email to proceed.',
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? AppColors.white // Dark theme color
                          : AppColors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Acme'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 26.h, left: 34.w, right: 33.w),
                child: Padding(
                  padding: EdgeInsets.only(top: 15, left: 20.w, right: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: CustomText(
                          textAlign: TextAlign.left,
                          text: 'Email',
                          color: themeProvider.themeMode == ThemeMode.dark
                              ? AppColors.white
                              : AppColors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: 13.h),
                      CustomContainerTextFormField(
                        contentpadding: EdgeInsets.only(left: 15.w),
                        width: 286.w,
                        readOnly: true,
                        height: 38.h,
                        keyboardtype: TextInputType.text,
                        validator: (value) {},
                        onFieldSubmitted: (value) {},
                        controller: TextEditingController(
                            text: widget.email.toString()),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(
                    top: 20.h, left: 38.w, right: 38.w, bottom: 30),
                child: GestureDetector(
                  onTap: () async {
                     AppConst.getUserType == "lawyer"
                        ? await checkLawyerEmailVerified(context)
                        : await checkEmailVerified(context);
                  },
                  child: CustomButton(
                      borderRadius: BorderRadius.circular(10.r),
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
