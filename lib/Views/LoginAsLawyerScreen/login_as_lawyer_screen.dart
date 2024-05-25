import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:projctwakeell/Utils/colors.dart';
import 'package:projctwakeell/Utils/images.dart';
import 'package:projctwakeell/Views/PinCodeLawyerScreen/pin_code_lawyer_screen.dart';
import 'package:provider/provider.dart';
import '../../Widgets/custom_Container_button.dart';
import '../../Widgets/custom_container_textform_field.dart';
import '../../Widgets/custom_text.dart';
import '../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import '../HomePage_lawyer_screen/home_page_lawyer_screen.dart';
import '../PinCodeScreen/pin_code_screen.dart';
import '../SignUpAsClientScreen/signup_as_client_screen.dart';
import '../SignUpAsLawyerScreen/signup_as_lawyer_screen.dart';

class LoginAsLawyerScreen extends StatefulWidget {
  const LoginAsLawyerScreen({super.key});
  @override
  State<LoginAsLawyerScreen> createState() => _LoginAsLawyerScreenState();
}

class _LoginAsLawyerScreenState extends State<LoginAsLawyerScreen> {
  TextEditingController passController1=TextEditingController();
  TextEditingController emailController1=TextEditingController();
  bool passVisibility1=false;
  final _formKey=GlobalKey<FormState>();
  @override
  void dispose() {
    passController1.dispose();
    emailController1.dispose();
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
                  padding:  EdgeInsets.only(top: 42.h,left: 39.w),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CustomText(
                        textAlign: TextAlign.left,
                        text:'Wakeel Naama',
                        color: AppColors.tealB3,
                        fontSize: 20.91.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily:'Acme'),
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.only(top:52.h,left: 113.w,right: 114.w),
                  child: Image.asset(AppImages.image4,width: 168.w,height: 149.h,fit: BoxFit.cover,),
                ),

                Padding(
                  padding:  EdgeInsets.only(top: 24.h,),
                  child: Align(
                    alignment: Alignment.center,
                    child: CustomText(
                        textAlign: TextAlign.center,
                        text:'Log In as a Lawyer',
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? AppColors.white // Dark theme color
                            : AppColors.black,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily:'Mulish'),
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.only(top: 20.h,left: 34.w,right: 33.w),
                  child: Container(
                    width: 326.w,
                    height: 223.h,
                    decoration: BoxDecoration(
                      color: themeProvider.themeMode==ThemeMode.dark? AppColors.blackA19 :Colors.grey.shade100,
                      //color: AppColors.blackA19,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 20,left: 20.w,right: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment:Alignment.topLeft,
                            child: CustomText(
                                textAlign: TextAlign.left,
                                text:'Email address',
                                color: themeProvider.themeMode==ThemeMode.dark ? AppColors.white:AppColors.black,
                                // color: AppColors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily:'Inter'),
                          ),
                          SizedBox(height: 13.h,),
                          CustomContainerTextFormField(
                            contentpadding: EdgeInsets.only(left: 15.w),
                            width: 286.w,
                            height: 38.h,
                            autofillHints: [AutofillHints.email],
                            validator: (value) {
                            },
                            keyboardtype: TextInputType.emailAddress,
                            onFieldSubmitted: (value) {
                            },
                            controller:emailController1,
                          ),

                          SizedBox(height: 25.h,),
                          Align(
                            alignment: Alignment.topLeft,
                            child: CustomText(
                              textAlign: TextAlign.left,
                              text: 'Password',
                              color: themeProvider.themeMode==ThemeMode.dark ? AppColors.white:AppColors.black,
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
                            obscureText: !passVisibility1,
                            obscuringCharacter: "*",
                            sufixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passVisibility1 = !passVisibility1;
                                });
                              },
                              icon: passVisibility1 ? Icon(Icons.visibility, color: AppColors.tealB3, size: 20,) :
                              Icon(Icons.visibility_off, color: AppColors.grey41, size: 20,),
                            ),
                            validator: (value) {
                            },
                            onFieldSubmitted: (value) {},
                            controller: passController1,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),


                Padding(
                  padding:EdgeInsets.only(left: 208.w,right: 33.w,top: 5.h),
                  child: GestureDetector(
                    onTap: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>PinCodeLawyerScreen()));
                    },
                    child: CustomText(
                        text:'Forgot your password?',
                        color: AppColors.tealB3,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily:'Inter'),
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.only(top: 10.h,left:38.w,right: 38.w),
                  child: GestureDetector(
                    onTap: () async {

                      String email = emailController1.text.trim();
                      String password = passController1.text.trim();
                      if(email.isNotEmpty && password.isNotEmpty){
                        try {
                          UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );

                          Get.snackbar(
                            'Congratulations',
                            'Successfully Login as a Lawyer!',
                            backgroundColor: AppColors.tealB3,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.done, color: AppColors.white),
                            snackPosition: SnackPosition.TOP,
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePageLawyerScreen()));

                        }on FirebaseAuthException catch (e) {
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
                        }
                        catch(e) {
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
                      }
                      if (emailController1.text.isEmpty) {
                        Get.snackbar(
                          'Error', 'Email Required!',
                          backgroundColor: AppColors.red,
                          colorText: AppColors.white,
                          borderRadius: 20.r,
                          icon: Icon(Icons.error_outline, color: AppColors.white),
                          snackPosition: SnackPosition.TOP,
                        );
                      } else if (!RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$').hasMatch(emailController1.text)) {
                        Get.snackbar(
                          'Error',
                          'Invalid Email!',
                          backgroundColor: AppColors.red,
                          colorText: AppColors.white,
                          borderRadius: 20.r,
                          icon: Icon(Icons.error_outline, color: AppColors.white),
                          snackPosition: SnackPosition.TOP,
                        );
                      }
                      else if (passController1.text.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Password Required!',
                          backgroundColor: AppColors.red,
                          colorText: AppColors.white,
                          borderRadius: 20.r,
                          icon: Icon(Icons.error_outline, color: AppColors.white),
                          snackPosition: SnackPosition.TOP,
                        );
                      }
                      else if (passController1.text.length < 6) {
                        Get.snackbar('Error', 'Password must be at least 6 characters long!',
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.error_outline,color: AppColors.white,),
                            snackPosition: SnackPosition.TOP);
                      }
                      else {

                          }
                    },

                    child: CustomButton(borderRadius: BorderRadius.circular(10.r),
                        height: 55.h,
                        width: 317.w,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Mulish',
                        fontSize: 22.2.sp,
                        text: 'Continue',
                        backgroundColor: AppColors.tealB3,
                        color: AppColors.white),
                  ),
                ),




                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Align(
                    alignment: Alignment.center,
                    child: CustomText(
                        textAlign: TextAlign.center,
                        text:'Don’t have a Wakeel Naama account?',
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? AppColors.white // Dark theme color
                            : AppColors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily:'Mulish'),
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.only(top: 30.h,),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupAsLawyerScreen()));
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
                          color: AppColors.white),
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
