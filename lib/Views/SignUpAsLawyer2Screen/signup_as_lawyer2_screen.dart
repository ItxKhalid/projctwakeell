import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:projctwakeell/Utils/colors.dart';
import 'package:projctwakeell/Utils/images.dart';
import 'package:projctwakeell/Views/LoginAsLawyerScreen/login_as_lawyer_screen.dart';
import 'package:projctwakeell/Views/SignUpAsClientScreen/signup_as_client_screen.dart';
import 'package:projctwakeell/Views/verification_screen.dart';
import 'package:projctwakeell/service/Userclass.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Widgets/custom_Container_button.dart';
import '../../Widgets/custom_container_textform_field.dart';
import '../../Widgets/custom_text.dart';
import '../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import '../HomePage_lawyer_screen/home_page_lawyer_screen.dart';
import '../SignUpAsLawyerScreen/signup_as_lawyer_screen.dart';

class SignUpAsLawyer2Screen extends StatefulWidget {
  const SignUpAsLawyer2Screen({
    Key? key,
    required this.firstName,
    required this.email,
    required this.lastName,
    required this.gender,
    required this.phoneNumber,
    required this.licenseNumber,
  }) : super(key: key);

  final String firstName;
  final String email;
  final String licenseNumber;
  final String phoneNumber;
  final String gender;
  final String lastName;

  @override
  State<SignUpAsLawyer2Screen> createState() => _SignUpAsLawyer2ScreenState();
}

class _SignUpAsLawyer2ScreenState extends State<SignUpAsLawyer2Screen> {
  TextEditingController password1Controller = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool passVisibility = false;
  final _formKey = GlobalKey<FormState>();

  bool passwordsMatch() {
    String password = password1Controller.text;
    String confirmPassword = confirmpasswordController.text;
    return password == confirmPassword;
  }

  @override
  void dispose() {
    password1Controller.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 42.h, left: 39.w, right: 29.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            textAlign: TextAlign.left,
                            text: AppLocalizations.of(context)!.wakeel_naama,
                            color: AppColors.tealB3,
                            fontSize: 20.91.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Acme'),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LoginAsLawyerScreen()));
                          },
                          child: CustomText(
                              textAlign: TextAlign.right,
                              text: AppLocalizations.of(context)!.log_in,
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
                      top: 48.h,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: CustomText(
                          textAlign: TextAlign.center,
                          text:
                              '${AppLocalizations.of(context)!.sign_up_as_a} ${AppLocalizations.of(context)!.lawyer}',
                          color: themeProvider.themeMode == ThemeMode.dark
                              ? AppColors.white // Dark theme color
                              : AppColors.black,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Mulish'),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 27.h, left: 76.w, right: 75.w),
                    child: Image.asset(
                      AppImages.image3,
                      width: 242.w,
                      height: 159.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 26.h, left: 34.w, right: 33.w),
                    child: Container(
                      width: 326.w,
                      height: 311.h,
                      decoration: BoxDecoration(
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? AppColors.blackA19 // Dark theme color
                            : Colors.grey.shade100,
                        //color: AppColors.blackA19,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 15, left: 20.w, right: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: CustomText(
                                  textAlign: TextAlign.left,
                                  text: widget.firstName,
                                  color:
                                      themeProvider.themeMode == ThemeMode.dark
                                          ? AppColors.white
                                          : AppColors.black,
                                  // color: AppColors.white,
                                  fontSize: 20.74.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter'),
                            ),
                            SizedBox(
                              height: 8.41.h,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: CustomText(
                                  textAlign: TextAlign.left,
                                  text: widget.email,
                                  color:
                                      themeProvider.themeMode == ThemeMode.dark
                                          ? AppColors.white
                                          : AppColors.black,
                                  // color: AppColors.white,
                                  fontSize: 16.13.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Inter'),
                            ),
                            SizedBox(
                              height: 33.59.h,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: CustomText(
                                textAlign: TextAlign.left,
                                text: AppLocalizations.of(context)!.password,
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? AppColors.white
                                    : AppColors.black,
                                // color: AppColors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Inter',
                              ),
                            ),
                            SizedBox(
                              height: 13.h,
                            ),
                            CustomContainerTextFormField(
                              contentpadding: EdgeInsets.only(left: 15.w),
                              width: 286.w,
                              height: 38.h,
                              keyboardtype: TextInputType.text,
                              obscureText: !passVisibility,
                              obscuringCharacter: "*",
                              sufixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passVisibility = !passVisibility;
                                  });
                                },
                                icon: passVisibility
                                    ? Icon(
                                        Icons.visibility,
                                        color: AppColors.tealB3,
                                        size: 20,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: AppColors.grey41,
                                        size: 20,
                                      ),
                              ),
                              validator: (value) {},
                              onFieldSubmitted: (value) {},
                              controller: password1Controller,
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: CustomText(
                                textAlign: TextAlign.left,
                                text: AppLocalizations.of(context)!
                                    .confirmPassword,
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? AppColors.white
                                    : AppColors.black,
                                // color: AppColors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Inter',
                              ),
                            ),
                            SizedBox(
                              height: 13.h,
                            ),
                            CustomContainerTextFormField(
                              contentpadding: EdgeInsets.only(left: 15.w),
                              width: 286.w,
                              height: 38.h,
                              keyboardtype: TextInputType.text,
                              obscureText: !passVisibility,
                              obscuringCharacter: "*",
                              sufixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passVisibility = !passVisibility;
                                  });
                                },
                                icon: passVisibility
                                    ? Icon(
                                        Icons.visibility,
                                        color: AppColors.tealB3,
                                        size: 20,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: AppColors.grey41,
                                        size: 20,
                                      ),
                              ),
                              validator: (value) {},
                              onFieldSubmitted: (value) {},
                              controller: confirmpasswordController,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 20.h, left: 38.w, right: 38.w),
                    child: GestureDetector(
                      onTap: () async {
                        String password = password1Controller.text.trim();
                        String cpassword =
                            confirmpasswordController.text.trim();
                        if (password.isNotEmpty && cpassword.isNotEmpty) {
                          try {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Center(child: AppConst.spinKitWave());
                              },
                              barrierDismissible: false,
                            );
                            // Create the user with email and password
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                              email: widget.email,
                              password: password,
                            );

                            // Send verification email
                            await userCredential.user!
                                .sendEmailVerification()
                                .then((value) {
                              Get.snackbar(
                                'Email Sent',
                                'A verification email has been sent to ${widget.email}. Please verify your email to proceed.',
                                backgroundColor: AppColors.tealB3,
                                colorText: AppColors.white,
                                borderRadius: 20.r,
                                icon: Icon(Icons.email, color: AppColors.white),
                                snackPosition: SnackPosition.TOP,
                              );
                            });
                            User? user = userCredential.user;
                            // Add the user data to Firestore
                            LawyerModel loggedInUser = LawyerModel(
                              userId: user!.uid,
                              email: user.email ?? '',
                              firstName: widget.firstName,
                              lNo: widget.licenseNumber,
                              gender: widget.gender,
                              lastName: widget.lastName,
                              phoneNumber: widget.phoneNumber,
                              // Set other properties as needed
                            );

                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString(AppConst.saveUserName,
                                widget.firstName + widget.lastName);
                            AppConst.getUserName =
                                prefs.getString(AppConst.saveUserName)!;
                            await prefs.setString(
                                AppConst.saveUserType, 'lawyer');
                            AppConst.getUserType =
                                prefs.getString(AppConst.saveUserType)!;
                            await prefs.setString(
                                'lawyer_id', loggedInUser.userId!);
                            await prefs.setString('lawyer_email', widget.email);
                            await prefs.setString(
                                'lawyer_fName', widget.firstName);
                            await prefs.setString(
                                'lawyer_lName', widget.lastName);
                            await prefs.setString(
                                'lawyer_licenseNumber', widget.licenseNumber);
                            await prefs.setString(
                                'lawyer_gender', widget.gender);
                            await prefs.setString(
                                'lawyer_number', widget.phoneNumber);
                            // Get.snackbar(
                            //   'Congratulations',
                            //   'Successfully SignUp as a Lawyer! Verification email has been sent.',
                            //   backgroundColor: AppColors.tealB3,
                            //   colorText: AppColors.white,
                            //   borderRadius: 20.r,
                            //   icon: Icon(Icons.done, color: AppColors.white),
                            //   snackPosition: SnackPosition.TOP,
                            // );

                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    VerificationScreen(email: widget.email),
                              ),
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              Get.snackbar(
                                AppLocalizations.of(context)!.error,
                                AppLocalizations.of(context)!.weak_password,
                                backgroundColor: AppColors.red,
                                colorText: AppColors.white,
                                borderRadius: 20.r,
                                icon: Icon(Icons.error_outline,
                                    color: AppColors.white),
                                snackPosition: SnackPosition.TOP,
                              );
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              Get.snackbar(
                                AppLocalizations.of(context)!.error,
                                AppLocalizations.of(context)!
                                    .email_already_in_use,
                                backgroundColor: AppColors.red,
                                colorText: AppColors.white,
                                borderRadius: 20.r,
                                icon: Icon(Icons.error_outline,
                                    color: AppColors.white),
                                snackPosition: SnackPosition.TOP,
                              );
                              print(
                                  'The account already exists for that email.');
                            }
                            Navigator.pop(context);
                          } catch (e) {
                            print(e.toString());
                            Navigator.pop(context);
                          }
                        } else {
                          if (password1Controller.text.isEmpty) {
                            Get.snackbar(
                              AppLocalizations.of(context)!.error,
                              AppLocalizations.of(context)!.password_required,
                              backgroundColor: AppColors.red,
                              colorText: AppColors.white,
                              borderRadius: 20.r,
                              icon: Icon(Icons.error_outline,
                                  color: AppColors.white),
                              snackPosition: SnackPosition.TOP,
                            );
                          } else if (password.length < 6) {
                            Get.snackbar(
                              AppLocalizations.of(context)!.error,
                              AppLocalizations.of(context)!
                                  .password_length_short,
                              backgroundColor: AppColors.red,
                              colorText: AppColors.white,
                              borderRadius: 20.r,
                              icon: Icon(Icons.error_outline,
                                  color: AppColors.white),
                              snackPosition: SnackPosition.TOP,
                            );
                          } else if (cpassword.isEmpty) {
                            Get.snackbar(
                              AppLocalizations.of(context)!.error,
                              AppLocalizations.of(context)!
                                  .confirm_password_required,
                              backgroundColor: AppColors.red,
                              colorText: AppColors.white,
                              borderRadius: 20.r,
                              icon: Icon(Icons.error_outline,
                                  color: AppColors.white),
                              snackPosition: SnackPosition.TOP,
                            );
                          } else if (!passwordsMatch()) {
                            Get.snackbar(
                              AppLocalizations.of(context)!.error,
                              AppLocalizations.of(context)!
                                  .passwords_do_not_match,
                              backgroundColor: AppColors.red,
                              colorText: AppColors.white,
                              borderRadius: 20.r,
                              icon: Icon(Icons.error_outline,
                                  color: AppColors.white),
                              snackPosition: SnackPosition.TOP,
                            );
                            return;
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
                        text: AppLocalizations.of(context)!.create_account,
                        backgroundColor: AppColors.tealB3,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 13.h),
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                              text: AppLocalizations.of(context)!
                                  .hereOfferLegalExpertise,
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
                                text:
                                    ' ${AppLocalizations.of(context)!.join_as_a}',
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
                      text: AppLocalizations.of(context)!.client,
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
