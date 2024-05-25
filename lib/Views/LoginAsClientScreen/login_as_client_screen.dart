import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:projctwakeell/Utils/colors.dart';
import 'package:projctwakeell/Utils/images.dart';
import 'package:projctwakeell/Views/HomePageClientScreen/home_page_client_screen.dart';
import 'package:projctwakeell/Widgets/custom_Container_button.dart';
import 'package:projctwakeell/Widgets/custom_container_textform_field.dart';
import 'package:projctwakeell/Widgets/custom_text.dart';
import 'package:projctwakeell/service/Userclass.dart';
import 'package:projctwakeell/themeChanger/themeChangerProvider/theme_changer_provider.dart';
import 'package:projctwakeell/user_provider.dart';
import '../SignUpAsClientScreen/signup_as_client_screen.dart';

class LoginAsClientScreen extends StatefulWidget {
  const LoginAsClientScreen({super.key});

  @override
  State<LoginAsClientScreen> createState() => _LoginAsClientScreenState();
}

class _LoginAsClientScreenState extends State<LoginAsClientScreen> {
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool passVisibility = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passController.dispose();
    emailController.dispose();
    super.dispose();
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
                  padding: EdgeInsets.only(top: 42.h, left: 39.w),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CustomText(
                      textAlign: TextAlign.left,
                      text: 'Wakeel Naama',
                      color: AppColors.tealB3,
                      fontSize: 20.91.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Acme',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 52.h, left: 113.w, right: 114.w),
                  child: Image.asset(
                    AppImages.image4,
                    width: 168.w,
                    height: 149.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24.h),
                  child: Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      textAlign: TextAlign.center,
                      text: 'Log In as a client',
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? AppColors.white
                          : AppColors.black,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Mulish',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 34.w, right: 33.w),
                  child: Container(
                    width: 326.w,
                    height: 223.h,
                    decoration: BoxDecoration(
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? AppColors.blackA19
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 20.w, right: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: CustomText(
                              textAlign: TextAlign.left,
                              text: 'Email address',
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
                            height: 38.h,
                            autofillHints: [AutofillHints.email],
                            validator: (value) {},
                            keyboardtype: TextInputType.emailAddress,
                            onFieldSubmitted: (value) {},
                            controller: emailController,
                          ),
                          SizedBox(height: 25.h),
                          Align(
                            alignment: Alignment.topLeft,
                            child: CustomText(
                              textAlign: TextAlign.left,
                              text: 'Password',
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
                            controller: passController,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 208.w, right: 33.w, top: 5.h),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to forgot password screen
                    },
                    child: CustomText(
                      text: 'Forgot your password?',
                      color: AppColors.tealB3,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h, left: 38.w, right: 38.w),
                  child: GestureDetector(
                    onTap: () async {
                      String email = emailController.text.trim();
                      String password = passController.text.trim();
                      if (email.isNotEmpty && password.isNotEmpty) {
                        try {
                          UserCredential userCredential =
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );

                          // Fetch additional user data if needed
                          User? user = userCredential.user;
                          if (user != null) {
                            // Create UserModel instance from user data
                            UserModel loggedInUser = UserModel(
                              userId: user.uid,
                              firstName: 'First Name', // Replace with actual data
                              lastName: 'Last Name',   // Replace with actual data
                              email: user.email ?? '',
                              cnic: 'CNIC',            // Replace with actual data
                              phoneNumber: 'Phone Number', // Replace with actual data
                              gender: 'Gender',        // Replace with actual data
                            );

                            // Update UserProvider
                            final userProvider = Provider.of<UserProvider>(context, listen: false);
                            await userProvider.setLoggedInUser(loggedInUser);

                            Get.snackbar(
                              'Congratulations',
                              'Successfully logged in as a Client!',
                              backgroundColor: AppColors.tealB3,
                              colorText: AppColors.white,
                              borderRadius: 20.r,
                              icon: Icon(Icons.done, color: AppColors.white),
                              snackPosition: SnackPosition.TOP,
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePageClientScreen(
                                  loggedInUser: loggedInUser,
                                ),
                              ),
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            Get.snackbar(
                              'Error',
                              'No user found for that email.',
                              backgroundColor: AppColors.red,
                              colorText: AppColors.white,
                              borderRadius: 20.0,
                              icon: Icon(Icons.error_outline, color: AppColors.white),
                              snackPosition: SnackPosition.TOP,
                            );
                          } else if (e.code == 'wrong-password') {
                            Get.snackbar(
                              'Error',
                              'Wrong password provided.',
                              backgroundColor: AppColors.red,
                              colorText: AppColors.white,
                              borderRadius: 20.0,
                              icon: Icon(Icons.error_outline, color: AppColors.white),
                              snackPosition: SnackPosition.TOP,
                            );
                          }
                        } catch (e) {
                          Get.snackbar(
                            'Error',
                            e.toString(),
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                            borderRadius: 20.0,
                            icon: Icon(Icons.error_outline, color: AppColors.white),
                            snackPosition: SnackPosition.TOP,
                          );
                        }
                      } else {
                        if (email.isEmpty) {
                          Get.snackbar(
                            'Error',
                            'Email Required!',
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.error_outline, color: AppColors.white),
                            snackPosition: SnackPosition.TOP,
                          );
                        } else if (!RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$').hasMatch(emailController.text)) {
                          Get.snackbar(
                            'Error',
                            'Invalid Email!',
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.error_outline, color: AppColors.white),
                            snackPosition: SnackPosition.TOP,
                          );
                        } else if (password.isEmpty) {
                          Get.snackbar(
                            'Error',
                            'Password Required!',
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.error_outline, color: AppColors.white),
                            snackPosition: SnackPosition.TOP,
                          );
                        } else if (password.length < 6) {
                          Get.snackbar(
                            'Error',
                            'Password must be at least 6 characters long!',
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
                      text: 'Continue',
                      backgroundColor: AppColors.tealB3,
                      color: AppColors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      textAlign: TextAlign.center,
                      text: 'Don’t have a Wakeel Naama account?',
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? AppColors.white
                          : AppColors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Mulish',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupAsClientScreen(),
                        ),
                      );
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: CustomButton(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: AppColors.tealB3),
                        height: 55.h,
                        width: 139.w,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Mulish',
                        fontSize: 22.2.sp,
                        text: 'Sign Up',
                        backgroundColor: AppColors.black,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
