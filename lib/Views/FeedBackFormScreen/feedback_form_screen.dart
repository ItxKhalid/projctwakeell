import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:projctwakeell/Utils/colors.dart';
import 'package:projctwakeell/Widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import '../../Utils/images.dart';
import '../../Widgets/custom_Container_button.dart';
import '../../Widgets/custom_client_drawer.dart';
import '../../Widgets/custom_container_textform_field.dart';
import '../../Widgets/custom_text.dart';
import '../../service/Userclass.dart';
import '../../themeChanger/themeChangerProvider/theme_changer_provider.dart';

class FeedbackFormScreen extends StatefulWidget {
  final UserModel loggedInUser;
  const FeedbackFormScreen({Key? key, required this.loggedInUser}) : super(key: key);

  @override
  State<FeedbackFormScreen> createState() => _FeedbackFormScreenState();
}

class _FeedbackFormScreenState extends State<FeedbackFormScreen> {
  //we are taking key to open drawer on tab on any icon
  GlobalKey<ScaffoldState> _key = GlobalKey();
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController rateController=TextEditingController();
  TextEditingController commentController=TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
   nameController.dispose();
    emailController.dispose();
    rateController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    UserModel loggedInUser = widget.loggedInUser;
    return Scaffold(
      key: _key,
      body: SafeArea(
        child:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: 42.h,left: 39.w,right: 29.13.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: CustomText(
                            textAlign: TextAlign.left,
                            text:'Wakeel Naama',
                            color: AppColors.tealB3,
                            fontSize: 20.91.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily:'Acme'),
                      ),

                      GestureDetector(
                        onTap: () {
                          _key.currentState!.openDrawer();
                        },
                        child: Icon(Icons.menu,color: AppColors.tealB3,),
                      ),


                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 39.h),
                  child: Divider(color: AppColors.grey2E,thickness: 2.h,),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(AppImages.image2,color: AppColors.tealB3,height: 61.h,width: 69.w,fit: BoxFit.cover,)),
                ),


                Padding(
                  padding:  EdgeInsets.only(top: 12.h,),
                  child: Align(
                    alignment: Alignment.center,
                  child: CustomText(
                      textAlign: TextAlign.center,
                      text:'Your feedback is valuable to us!',
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? AppColors.white // Dark theme color
                          : AppColors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily:'Mulish'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: Divider(color: AppColors.grey2E,thickness: 2.h,),
                ),

SizedBox(height: 20.h,),
                Container(
                  width: 360.w,
                  height: 580.h,
                  decoration: BoxDecoration(
                    color: themeProvider.themeMode==ThemeMode.dark? AppColors.blackA19 : Colors.grey.shade100,
                    //color: AppColors.blackA19,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 25.h,left: 20.w),
                        child: Align(
                          alignment:Alignment.topLeft,
                          child: CustomText(
                              textAlign: TextAlign.left,
                              text:'Name:',
                              color: themeProvider.themeMode==ThemeMode.dark ? AppColors.white:AppColors.black,
                              //color:  AppColors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily:'Inter'),
                        ),
                      ),
                      SizedBox(height: 13.h,),
                      CustomContainerTextFormField(
                        contentpadding: EdgeInsets.only(left: 15.w),
                        width: 325.w,
                        height: 42.h,
                        validator: (value) {
                        },
                        keyboardtype: TextInputType.text,
                        onFieldSubmitted: (value) {
                        },
                        controller:nameController,
                      ),



                      SizedBox(height: 22.h,),
                      Padding(
                        padding: EdgeInsets.only(top: 25.h,left: 20.w),
                        child: Align(
                          alignment:Alignment.topLeft,
                          child: CustomText(
                              textAlign: TextAlign.left,
                              text:'Email',
                              color: themeProvider.themeMode==ThemeMode.dark ? AppColors.white:AppColors.black,
                              //color:  AppColors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily:'Inter'),
                        ),
                      ),
                      SizedBox(height: 13.h,),
                      CustomContainerTextFormField(
                        contentpadding: EdgeInsets.only(left: 15.w),
                        width: 325.w,
                        height: 38.h,
                        autofillHints: [AutofillHints.email],
                        validator: (value) {
                        },
                        keyboardtype: TextInputType.emailAddress,
                        onFieldSubmitted: (value) {
                        },
                        controller:emailController,
                      ),

                      SizedBox(height: 22.h,),
                      Padding(
                        padding: EdgeInsets.only(top: 25.h,left: 20.w),
                        child: Align(
                          alignment:Alignment.topLeft,
                          child: CustomText(
                              textAlign: TextAlign.left,
                              text:'Rate your experience out of 5:',
                              color: themeProvider.themeMode==ThemeMode.dark ? AppColors.white:AppColors.black,
                              //color:  AppColors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily:'Inter'),
                        ),
                      ),
                      SizedBox(height: 13.h,),
                      CustomContainerTextFormField(
                        contentpadding: EdgeInsets.only(left: 15.w),
                        width: 325.w,
                        height: 42.h,
                        validator: (value) {
                        },
                        keyboardtype: TextInputType.text,
                        onFieldSubmitted: (value) {
                        },
                        controller:rateController,
                      ),


                      SizedBox(height: 22.h,),
                      Padding(
                        padding: EdgeInsets.only(top: 25.h,left: 20.w),
                        child: Align(
                          alignment:Alignment.topLeft,
                          child: CustomText(
                              textAlign: TextAlign.left,
                              text:'Comments/Suggestions:',
                              color: themeProvider.themeMode==ThemeMode.dark ? AppColors.white:AppColors.black,
                              //color:  AppColors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily:'Inter'),
                        ),
                      ),
                      SizedBox(height: 13.h,),
                      Container(
                        width: 325.w,
                        height: 100.h,
                        child: TextFormField(
                          minLines:4 ,
                          maxLines:6,
                          cursorColor: AppColors.tealB3,
                          controller: commentController,
                          style: TextStyle(
                            color: themeProvider.themeMode==ThemeMode.dark ? AppColors.white:AppColors.black,
                            //color:  AppColors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily:'Inter',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 15.w,top: 20.h),
                            fillColor: AppColors.black12,
                            labelStyle: TextStyle(
                              color:AppColors.black919,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.r),
                                borderSide: BorderSide(
                                  color: themeProvider.themeMode==ThemeMode.dark ? AppColors.white:AppColors.black,
                                  //color:  AppColors.white,
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.r),
                                borderSide: BorderSide(
                                  color: themeProvider.themeMode==ThemeMode.dark ? AppColors.white:AppColors.black,
                                  //color:  AppColors.white,
                                )
                            ),
                          ),
                          keyboardType:TextInputType.multiline,
                          validator: (value){
                          },
                          onFieldSubmitted: (value) {
                          },
                        ),
                      ),

                    ],
                  ),
                ),


                Padding(
                  padding: EdgeInsets.only(top: 22.h, left: 38.w, right: 38.w),
                  child: GestureDetector(
                    onTap: () {
                      bool canNavigate = true; // Flag to check if navigation is allowed
                      // Validate First Name
                      if (nameController.text.isEmpty) {
                        Get.snackbar('Error', 'Name Required!',
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.error_outline, color: AppColors.white,),
                            snackPosition: SnackPosition.TOP);
                        canNavigate = false;
                      }
                      else if (emailController.text.isEmpty) {
                        Get.snackbar('Error', 'Email Required!',
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.error_outline, color: AppColors.white,),
                            snackPosition: SnackPosition.TOP);
                        canNavigate = false;
                      }


                      // Navigate if all conditions are met
                      if (canNavigate) {
                       // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpAsClient2Screen()));
                      }
                    },
                    child: CustomButton(
                        borderRadius: BorderRadius.circular(10.r),
                        height: 55.h,
                        width: 317.w,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Mulish',
                        fontSize: 22.2.sp,
                        text: 'Submit Feedback',
                        backgroundColor: AppColors.tealB3,
                        color: AppColors.white),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      drawer: MyClientDrawer(loggedInUser: loggedInUser)

    );
  }
}
