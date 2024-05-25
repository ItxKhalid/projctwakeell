import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:projctwakeell/Utils/colors.dart';
import 'package:projctwakeell/Views/LoginAsLawyerScreen/login_as_lawyer_screen.dart';
import 'package:projctwakeell/Views/SplashScreen/splash_screen.dart';
import 'package:provider/provider.dart';
import '../../Controllers/DropDownGenderController.dart';
import '../../Utils/images.dart';
import '../../Widgets/custom_Container_button.dart';
import '../../Widgets/custom_container_textform_field.dart';
import '../../Widgets/custom_country_code_picker.dart';
import '../../Widgets/custom_text.dart';
import '../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import '../SignUpAsClientScreen/Components/genderdropdown_component.dart';
import '../SignUpAsClientScreen/signup_as_client_screen.dart';
import '../SignUpAsLawyer2Screen/signup_as_lawyer2_screen.dart';
import '../SignUpasClient2Screen/signup_as_client2_screen.dart';

class SignupAsLawyerScreen extends StatefulWidget {
  const SignupAsLawyerScreen({super.key});

  @override
  State<SignupAsLawyerScreen> createState() => _SignupAsLawyerScreenState();
}

class _SignupAsLawyerScreenState extends State<SignupAsLawyerScreen> {
  TextEditingController firstname1Controller = TextEditingController();
  TextEditingController lastname1Controller = TextEditingController();
  TextEditingController email1Controller = TextEditingController();
  TextEditingController licensenumController = TextEditingController();
  String fullPhoneNumber1 = '';
  final _formKey1 = GlobalKey<FormState>();
  String selectedGender = '';
  final genderController = Get.put(GenderDropDownController());

  @override
  void dispose() {
    firstname1Controller.dispose();
    lastname1Controller.dispose();
    email1Controller.dispose();
    licensenumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    final genderController = Get.put(GenderDropDownController());

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey1,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40.h, left: 39.w, right: 29.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            textAlign: TextAlign.left,
                            text: 'Wakeel Naama',
                            color: AppColors.tealB3,
                            fontSize: 20.91.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Acme'),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginAsLawyerScreen()));
                          },
                          child: CustomText(
                              textAlign: TextAlign.right,
                              text: 'Log In',
                              color: AppColors.tealB3,
                              fontSize: 20.91.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Mulish'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 40.h,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: CustomText(
                          textAlign: TextAlign.center,
                          text: 'Sign up as a Lawyer',
                          color: themeProvider.themeMode == ThemeMode.dark
                              ? AppColors.white // Dark theme color
                              : AppColors.black,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Mulish'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, left: 34.w, right: 33.w),
                    child: Container(
                      width: 326.w,
                      height: 525.h,
                      decoration: BoxDecoration(
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? AppColors.blackA19
                            : Colors.grey.shade100,
                        //color: AppColors.blackA19,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 19, left: 19.w, right: 19.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: CustomText(
                                          textAlign: TextAlign.left,
                                          text: 'First name',
                                          color: themeProvider.themeMode ==
                                                  ThemeMode.dark
                                              ? AppColors.white
                                              : AppColors.black,
                                          //color: AppColors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Inter'),
                                    ),
                                    SizedBox(
                                      height: 13.h,
                                    ),
                                    CustomContainerTextFormField(
                                      contentpadding: EdgeInsets.only(left: 15.w),
                                      width: 131.w,
                                      height: 38.h,
                                      validator: (value) {},
                                      keyboardtype: TextInputType.text,
                                      onFieldSubmitted: (value) {},
                                      controller: firstname1Controller,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 24.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: CustomText(
                                          textAlign: TextAlign.right,
                                          text: 'Last name',
                                          color: themeProvider.themeMode ==
                                                  ThemeMode.dark
                                              ? AppColors.white
                                              : AppColors.black,
                                          //color: AppColors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Inter'),
                                    ),
                                    SizedBox(
                                      height: 13.h,
                                    ),
                                    CustomContainerTextFormField(
                                      contentpadding: EdgeInsets.only(left: 15.w),
                                      width: 131.w,
                                      height: 38.h,
                                      validator: (value) {},
                                      keyboardtype: TextInputType.text,
                                      onFieldSubmitted: (value) {},
                                      controller: lastname1Controller,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: CustomText(
                                  textAlign: TextAlign.left,
                                  text: 'Email address',
                                  color: themeProvider.themeMode == ThemeMode.dark
                                      ? AppColors.white
                                      : AppColors.black,
                                  //color: AppColors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Inter'),
                            ),
                            SizedBox(
                              height: 13.h,
                            ),
                            CustomContainerTextFormField(
                              contentpadding: EdgeInsets.only(left: 15.w),
                              width: 286.w,
                              height: 38.h,
                              validator: (value) {},
                              keyboardtype: TextInputType.emailAddress,
                              onFieldSubmitted: (value) {},
                              controller: email1Controller,
                              autofillHints: [AutofillHints.email],
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: CustomText(
                                  textAlign: TextAlign.left,
                                  text: 'License number',
                                  color: themeProvider.themeMode == ThemeMode.dark
                                      ? AppColors.white
                                      : AppColors.black,
                                  //color: AppColors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Inter'),
                            ),
                            SizedBox(
                              height: 13.h,
                            ),
                            CustomContainerTextFormField(
                              contentpadding: EdgeInsets.only(left: 15.w),
                              width: 286.w,
                              height: 38.h,
                              validator: (value) {},
                              keyboardtype: TextInputType.number,
                              onFieldSubmitted: (value) {},
                              controller: licensenumController,
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: CustomText(
                                  textAlign: TextAlign.left,
                                  text: 'Mobile number',
                                  color: themeProvider.themeMode == ThemeMode.dark
                                      ? AppColors.white
                                      : AppColors.black,
                                  //color: AppColors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Inter'),
                            ),
                            SizedBox(
                              height: 13.h,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: CustomCountryCodePicker(
                                width: 286.w,
                                height: 45.h,
                                decorationcontainer: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  border: Border.all(
                                    color:
                                        themeProvider.themeMode == ThemeMode.dark
                                            ? AppColors.white
                                            : AppColors.black,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Inter',
                                ),
                                initialCountryCode: 'PK',
                                contentPadding:
                                    EdgeInsets.only(top: 22.h, left: 10.w),
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? AppColors.white
                                    : AppColors.black,
                                onPhoneChanged: (phone) {
                                  fullPhoneNumber1 = phone;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: CustomText(
                                  textAlign: TextAlign.left,
                                  text: 'Gender',
                                  color: themeProvider.themeMode == ThemeMode.dark
                                      ? AppColors.white
                                      : AppColors.black,
                                  //color: AppColors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Inter'),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            GenderDropDownComponent(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.h, left: 38.w, right: 38.w),
                    child: GestureDetector(
                      onTap: () async {
                        bool canNavigate = true; // Initialize the flag as true
                        String firstName = firstname1Controller.text.trim();
                        String lastName = lastname1Controller.text.trim();
                        String email = email1Controller.text.trim();
                        String licenseNumber = licensenumController.text.trim();
                        String phoneNumber = fullPhoneNumber1.trim();
                        String gender =
                            genderController.getSelectedGender().trim();
                        // Validate First Name
                        if (firstname1Controller.text.isEmpty) {
                          Get.snackbar('Error', 'First Name Required!',
                              backgroundColor: AppColors.red,
                              colorText: AppColors.white,
                              borderRadius: 20.r,
                              icon: Icon(
                                Icons.error_outline,
                                color: AppColors.white,
                              ),
                              snackPosition: SnackPosition.TOP);
                          canNavigate =
                              false; // Update flag to false due to validation failure
                        } else if (lastname1Controller.text.isEmpty) {
                          // Validate Last Name
                          Get.snackbar('Error', 'Last Name is Required!',
                              backgroundColor: AppColors.red,
                              colorText: AppColors.white,
                              borderRadius: 20.r,
                              icon: Icon(
                                Icons.error_outline,
                                color: AppColors.white,
                              ),
                              snackPosition: SnackPosition.TOP);
                          canNavigate = false;
                        } else if (email1Controller.text.isEmpty) {
                          Get.snackbar('Error', 'Email Required!',
                              backgroundColor: AppColors.red,
                              colorText: AppColors.white,
                              borderRadius: 20.r,
                              icon: Icon(
                                Icons.error_outline,
                                color: AppColors.white,
                              ),
                              snackPosition: SnackPosition.TOP);
                          canNavigate = false;
                        } else {
                          // Check for email format
                          RegExp emailRegex = RegExp(
                              r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
                          if (!emailRegex.hasMatch(email1Controller.text)) {
                            Get.snackbar('Error', 'Invalid Email!',
                                backgroundColor: AppColors.red,
                                colorText: AppColors.white,
                                borderRadius: 20.r,
                                icon: Icon(
                                  Icons.error_outline,
                                  color: AppColors.white,
                                ),
                                snackPosition: SnackPosition.TOP);
                            canNavigate = false;
                          } else if (licensenumController.text.isEmpty) {
                            Get.snackbar('Error', 'License Number Required!',
                                backgroundColor: AppColors.red,
                                colorText: AppColors.white,
                                borderRadius: 20.r,
                                icon: Icon(
                                  Icons.error_outline,
                                  color: AppColors.white,
                                ),
                                snackPosition: SnackPosition.TOP);
                            canNavigate = false;
                          } else if (fullPhoneNumber1.isEmpty) {
                            Get.snackbar('Error', 'Mobile Number Required!',
                                colorText: AppColors.white,
                                backgroundColor: Colors.red,
                                borderRadius: 20.r,
                                icon: Icon(
                                  Icons.error_outline,
                                  color: AppColors.white,
                                ),
                                snackPosition: SnackPosition.TOP);
                            canNavigate = false;
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpAsLawyer2Screen(
                                        firstName: firstName,
                                        email: email,
                                        gender: gender,
                                        licenseNumber: licenseNumber,
                                        phoneNumber: phoneNumber,
                                        lastName: lastName)));
                          }
                        }
                      },
                      child: CustomButton(
                          borderRadius: BorderRadius.circular(10.r),
                          height: 55.h,
                          width: 317.w,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Mulish',
                          fontSize: 22.2.sp,
                          text: 'Next',
                          backgroundColor: AppColors.tealB3,
                          color: AppColors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                              text: 'Here to Offer Legal Expertise?',
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? AppColors.white // Dark theme color
                                  : AppColors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Mulish'),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SignupAsClientScreen()));
                            },
                            child: CustomText(
                                text: ' Join as a',
                                color: AppColors.tealB3,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Mulish'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomText(
                      text: 'Client',
                      color: AppColors.tealB3,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Mulish'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
