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

class SignUpAsClient2Screen extends StatefulWidget {
  const SignUpAsClient2Screen({
    Key? key,
    required this.firstName,
    required this.email,
    required this.lastName,
  }) : super(key: key);

  final String firstName;
  final String email;
  final String lastName;

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
                          text:'Wakeel Naama',
                          color: AppColors.tealB3,
                          fontSize: 20.91.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily:'Acme'),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginAsClientScreen()));
                        },
                        child: CustomText(
                            textAlign: TextAlign.right,
                            text:'Log In',
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
                        text:'Sign up as a client',
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
                              text: 'Password',color: themeProvider.themeMode==ThemeMode.dark? AppColors.white : AppColors.black,
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
                              text: 'Confirm Password',
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
                  padding:  EdgeInsets.only(top: 20.h,left:38.w,right: 38.w),
                  child: GestureDetector(
                    onTap: () async {
                      String password =passwordController.text.trim();
                      String cpassword =confirmpasswordController.text.trim();
                      if(password.isNotEmpty && cpassword.isNotEmpty){
                            try {
                            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: widget.email,
                            password: password,
                            );
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setString(AppConst.saveUserType, 'client');
                            AppConst.getUserType = prefs.getString(AppConst.saveUserType)!;
                            Get.snackbar('Congratulations', 'Successfully SignUp as a Client!',
                                backgroundColor: AppColors.tealB3,
                                colorText: AppColors.white,
                                borderRadius: 20.r,
                                icon: Icon(Icons.done,color: AppColors.white,),
                                snackPosition: SnackPosition.TOP);
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>HomePageClientScreen(loggedInUser: loggedInUser!,)));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                Get.snackbar('Error', 'The password provided is too weak!',
                                    backgroundColor: AppColors.red,
                                    colorText: AppColors.white,
                                    borderRadius: 20.r,
                                    icon: Icon(Icons.error_outline,color: AppColors.white,),
                                    snackPosition: SnackPosition.TOP);
                                print('The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                Get.snackbar('Error', 'The account already exists for that email!',
                                    backgroundColor: AppColors.red,
                                    colorText: AppColors.white,
                                    borderRadius: 20.r,
                                    icon: Icon(Icons.error_outline,color: AppColors.white,),
                                    snackPosition: SnackPosition.TOP);
                                print('The account already exists for that email.');
                              }
                            } catch (e) {
                              print(e.toString());
                            }
                      }
                      if (password.isEmpty) {
                        Get.snackbar('Error', 'Password Required!',
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.error_outline,color: AppColors.white,),
                            snackPosition: SnackPosition.TOP);
                      }
                      else if (passwordController.text.length < 6) {
                        Get.snackbar('Error', 'Password must be at least 6 characters long!',
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.error_outline,color: AppColors.white,),
                            snackPosition: SnackPosition.TOP);
                      }
                      else if (cpassword.isEmpty) {
                        Get.snackbar('Error', 'Confirm Password Required!',
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.error_outline,color: AppColors.white,),
                            snackPosition: SnackPosition.TOP);
                      }
                      else if (!passwordsMatch()) {
                        Get.snackbar('Error', 'Passwords do not match!',
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.error_outline,color: AppColors.white,),
                            snackPosition: SnackPosition.TOP);
                        return;
                      }


                    },
                    child: CustomButton(borderRadius: BorderRadius.circular(10.r),
                        height: 55.h,
                        width: 317.w,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Mulish',
                        fontSize: 22.2.sp,
                        text: 'Create my account',
                        backgroundColor: AppColors.tealB3,
                        color: AppColors.white),
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
                            text:'Here to Offer Legal Expertise?',
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? AppColors.white // Dark theme color
                                : AppColors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily:'Mulish'),
                        GestureDetector(
                          onTap: (){

                          },
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>SignupAsLawyerScreen()));
                            },
                            child: CustomText(
                                text:' Join as a',
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
                    text:'Lawyer',
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
