import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:projctwakeell/Utils/colors.dart';
import 'package:projctwakeell/Utils/images.dart';
import 'package:projctwakeell/Views/HomePageClientScreen/home_page_client_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/custom_Container_button.dart';
import '../../Widgets/custom_container_textform_field.dart';
import '../../Widgets/custom_text.dart';
import '../../service/Userclass.dart';
import '../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import '../LoginAsClientScreen/login_as_client_screen.dart';
import '../SignUpAsLawyerScreen/signup_as_lawyer_screen.dart';
import '../verification_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpAsClient2Screen extends StatefulWidget {
  const SignUpAsClient2Screen({
    Key? key,
    required this.firstName,
    required this.email,
    required this.lastName,
    required this.cnic,
    required this.number,
    required this.gender,
  }) : super(key: key);

  final String firstName;
  final String email;
  final String lastName;
  final String cnic;
  final String number;
  final String gender;

  State<SignUpAsClient2Screen> createState() => _SignUpAsClient2ScreenState();
}

class _SignUpAsClient2ScreenState extends State<SignUpAsClient2Screen> {
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmpasswordController=TextEditingController();
  bool passVisibility=false;
  final _formKey=GlobalKey<FormState>();
  UserModel? loggedInUser;

  @override
  void dispose() {
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  bool passwordsMatch() {
    String password =  passwordController.text;
    String confirmPassword = confirmpasswordController.text;
    return password == confirmPassword;
  }

  Future<void> sendVerificationEmail(User user) async {
    await user.sendEmailVerification();
  }

  Future<void> checkEmailVerification(User user) async {
    user.reload();
    if (user.emailVerified) {
      // Create an instance of UserModel with the retrieved data
      UserModel newUser = UserModel(
        userId: user.uid, // Use the uid from Firebase as userId
        firstName: widget.firstName,
        lastName: widget.lastName,
        email: widget.email,
        cnic: widget.cnic,
        phoneNumber: widget.number,
        gender: widget.gender,
      );

      // Save user data to Firestore
      await FirebaseFirestore.instance.collection('client').doc(user.uid).set(newUser.toMap());

      // Show Snackbar
      Get.snackbar(
        AppLocalizations.of(context)!.congratulations,
        AppLocalizations.of(context)!.successfully_logged_in_as_client,
        backgroundColor: AppColors.tealB3,
        colorText: AppColors.white,
        borderRadius: 20.r,
        icon: Icon(Icons.done, color: AppColors.white),
        snackPosition: SnackPosition.TOP,
      );

      // Navigate to the next screen with user data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePageClientScreen(loggedInUser: newUser),
        ),
      );
    } else {
      Get.snackbar(
        AppLocalizations.of(context)!.error,
        AppLocalizations.of(context)!.pleaseVerifyYourEmailProceed,
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
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [

                Padding(
                  padding:  EdgeInsets.only(top: 42.h,left: 39.w,right: 29.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          textAlign: TextAlign.left,
                          text:AppLocalizations.of(context)!.wakeel_naama,
                          color: AppColors.tealB3,
                          fontSize: 20.91.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily:'Acme'),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>const LoginAsClientScreen()));
                        },
                        child: CustomText(
                            textAlign: TextAlign.right,
                            text:AppLocalizations.of(context)!.log_in,
                            color: AppColors.tealB3,
                            fontSize: 20.91.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily:'Mulish'),
                      ),
                    ],
                  ),
                ),


                Padding(
                  padding:  EdgeInsets.only(top: 48.h,),
                  child: Align(
                    alignment: Alignment.center,
                    child: CustomText(
                        textAlign: TextAlign.center,
                        text:"${AppLocalizations.of(context)!.sign_up_as_a} ${AppLocalizations.of(context)!.client}",
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? AppColors.white // Dark theme color
                            : AppColors.black,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily:'Mulish'),
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.only(top:27.h,left: 76.w,right: 75.w),
                  child: Image.asset(AppImages.image3,width: 242.w,height: 159.h,fit: BoxFit.cover,),
                ),


                Padding(
                  padding:  EdgeInsets.only(top: 26.h,left: 34.w,right: 33.w),
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
                      padding: EdgeInsets.only(top: 15,left: 20.w,right: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment:Alignment.topLeft,
                            child: CustomText(
                                textAlign: TextAlign.left,
                                text: widget.firstName,
                               color: themeProvider.themeMode==ThemeMode.dark? AppColors.white : AppColors.black,
                               // color: AppColors.white,
                                fontSize: 20.74.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily:'Inter'),
                          ),
                          SizedBox(height: 8.41.h,),
                          Align(
                            alignment:Alignment.topLeft,
                            child: CustomText(
                                textAlign: TextAlign.left,
                                text: widget.email,
                                color: themeProvider.themeMode==ThemeMode.dark? AppColors.white : AppColors.black,
                                //color: AppColors.white,
                                fontSize: 16.13.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily:'Inter'),
                          ),

                          SizedBox(height: 33.59.h,),
                          Align(
                            alignment: Alignment.topLeft,
                            child: CustomText(
                              textAlign: TextAlign.left,
                              text: AppLocalizations.of(context)!.password,color: themeProvider.themeMode==ThemeMode.dark? AppColors.white : AppColors.black,
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
                            obscureText: !passVisibility,
                            obscuringCharacter: "*",
                            sufixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passVisibility = !passVisibility;
                                });
                              },
                              icon: passVisibility ? Icon(Icons.visibility, color: AppColors.tealB3, size: 20,) :
                              Icon(Icons.visibility_off, color: AppColors.grey41, size: 20,),
                            ),
                            validator: (value) {
                            },
                            onFieldSubmitted: (value) {},
                            controller: passwordController,
                          ),

                          SizedBox(height: 25.h,),
                          Align(
                            alignment: Alignment.topLeft,
                            child: CustomText(
                              textAlign: TextAlign.left,
                              text: AppLocalizations.of(context)!.confirmPassword,
                              color: themeProvider.themeMode==ThemeMode.dark? AppColors.white : AppColors.black,
                             // color: AppColors.white,
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
                            obscureText: !passVisibility,
                            obscuringCharacter: "*",
                            sufixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passVisibility = !passVisibility;
                                });
                              },
                              icon: passVisibility ? Icon(Icons.visibility, color: AppColors.tealB3, size: 20,) :
                              Icon(Icons.visibility_off, color: AppColors.grey41, size: 20,),
                            ),
                            validator: (value) {
                            },
                            onFieldSubmitted: (value) {},
                            controller: confirmpasswordController,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 38.w, right: 38.w),
              child: GestureDetector(
                onTap: () async {
                  String email = widget.email;
                  String password = passwordController.text.trim();
                  if (email.isNotEmpty && password.isNotEmpty) {
                    try {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Center(child: AppConst.spinKitWave());
                        },
                        barrierDismissible: false,
                      );
                      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      User? user = userCredential.user;
                      if (user != null) {
                        // Create UserModel instance from user data
                        UserModel loggedInUser = UserModel(
                          userId: user.uid,
                          email: user.email ?? '',
                          firstName: widget.firstName,
                          cnic: widget.cnic,
                          gender: widget.gender,
                          lastName: widget.lastName,
                          phoneNumber: widget.number,
                          // Set other properties as needed
                        );

                        // Save the user model to SharedPreferences
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setString('user_id', loggedInUser.userId!);
                        await prefs.setString('user_email', loggedInUser.email!);
                        await prefs.setString('user_fName', loggedInUser.firstName!);
                        await prefs.setString('user_lName', loggedInUser.lastName!);
                        await prefs.setString('user_cnic', loggedInUser.cnic!);
                        await prefs.setString('user_gender', loggedInUser.gender!);
                        await prefs.setString('user_number', loggedInUser.phoneNumber!);
                        // Save other properties as needed

                        // Send email verification
                        await user.sendEmailVerification().then((value) {
                          Get.snackbar(
                            AppLocalizations.of(context)!.emailSent,
                            AppLocalizations.of(context)!.verification_email_sent_to_email.replaceFirst('%email%', widget.email),
                            backgroundColor: AppColors.tealB3,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.email, color: AppColors.white),
                            snackPosition: SnackPosition.TOP,
                          );
                        });

                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerificationScreen(email: email),
                          ),
                        );
                      }
                      } on FirebaseAuthException catch (e) {
                        Navigator.pop(context);
                        if (e.code == 'weak-password') {
                          Get.snackbar(
                            AppLocalizations.of(context)!.error,
                            AppLocalizations.of(context)!.weak_password,
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.error_outline, color: AppColors.white),
                            snackPosition: SnackPosition.TOP,
                          );
                        } else if (e.code == 'email-already-in-use') {
                          Get.snackbar(
                            AppLocalizations.of(context)!.error,
                            AppLocalizations.of(context)!.email_already_in_use,
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.error_outline, color: AppColors.white),
                            snackPosition: SnackPosition.TOP,
                          );
                        }
                      } catch (e) {
                        Navigator.pop(context);
                        Get.snackbar(
                          AppLocalizations.of(context)!.error,
                          e.toString(),
                          backgroundColor: AppColors.red,
                          colorText: AppColors.white,
                          borderRadius: 20.r,
                          icon: Icon(Icons.error_outline, color: AppColors.white),
                          snackPosition: SnackPosition.TOP,
                        );
                      }
                    } else {
                      if (email.isEmpty) {
                        Get.snackbar(
                          AppLocalizations.of(context)!.error,
                          AppLocalizations.of(context)!.email_required,
                          backgroundColor: AppColors.red,
                          colorText: AppColors.white,
                          borderRadius: 20.r,
                          icon: Icon(Icons.error_outline, color: AppColors.white),
                          snackPosition: SnackPosition.TOP,
                        );
                      } else if (!RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$').hasMatch(widget.email)) {
                        Get.snackbar(
                          AppLocalizations.of(context)!.error,
                          AppLocalizations.of(context)!.invalid_email,
                          backgroundColor: AppColors.red,
                          colorText: AppColors.white,
                          borderRadius: 20.r,
                          icon: Icon(Icons.error_outline, color: AppColors.white),
                          snackPosition: SnackPosition.TOP,
                        );
                      } else if (password.isEmpty) {
                        Get.snackbar(
                          AppLocalizations.of(context)!.error,
                          AppLocalizations.of(context)!.password_required,
                          backgroundColor: AppColors.red,
                          colorText: AppColors.white,
                          borderRadius: 20.r,
                          icon: Icon(Icons.error_outline, color: AppColors.white),
                          snackPosition: SnackPosition.TOP,
                        );
                      } else if (password.length < 6) {
                        Get.snackbar(
                          AppLocalizations.of(context)!.error,
                          AppLocalizations.of(context)!.password_length_short,
                          backgroundColor: AppColors.red,
                          colorText: AppColors.white,
                          borderRadius: 20.r,
                          icon: Icon(Icons.error_outline, color: AppColors.white),
                          snackPosition: SnackPosition.TOP,
                        );
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
                  padding:  EdgeInsets.only(top: 15.h),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                            text:AppLocalizations.of(context)!.hereOfferLegalExpertise,
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? AppColors.white // Dark theme color
                                : AppColors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily:'Mulish'),
                        GestureDetector(
                          onTap: (){},
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>const SignupAsLawyerScreen()));
                            },
                            child: CustomText(
                                text:' ${AppLocalizations.of(context)!.join_as_a}',
                                color: AppColors.tealB3,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily:'Mulish'),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                CustomText(
                    text:AppLocalizations.of(context)!.lawyer,
                    color: AppColors.tealB3,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily:'Mulish'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}