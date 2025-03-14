import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:projctwakeell/Utils/colors.dart';
import 'package:projctwakeell/Views/LoginAsClientScreen/login_as_client_screen.dart';
import 'package:provider/provider.dart';
import '../../Controllers/DropDownGenderController.dart';
import '../../Widgets/custom_Container_button.dart';
import '../../Widgets/custom_container_textform_field.dart';
import '../../Widgets/custom_country_code_picker.dart';
import '../../Widgets/custom_text.dart';
import '../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import '../SignUpAsLawyerScreen/signup_as_lawyer_screen.dart';
import '../SignUpasClient2Screen/signup_as_client2_screen.dart';
import 'Components/genderdropdown_component.dart';

class SignupAsClientScreen extends StatefulWidget {
  const SignupAsClientScreen({super.key});
  @override
  State<SignupAsClientScreen> createState() => _SignupAsClientScreenState();
}
class _SignupAsClientScreenState extends State<SignupAsClientScreen> {

  TextEditingController firstnameController=TextEditingController();
  TextEditingController lastnameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController cnicController=TextEditingController();
  String fullPhoneNumber = '';
  final _formKey = GlobalKey<FormState>();
  String selectedGender = '';
  final genderController = Get.put(GenderDropDownController());

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    cnicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    final genderController = Get.put(GenderDropDownController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                Padding(
                  padding:  EdgeInsets.only(top: 40.h,left: 39.w,right: 29.w),
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
                  padding:  EdgeInsets.only(top: 40.h,),
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
                  padding:  EdgeInsets.only(top: 10.h,left: 34.w,right: 33.w),
                  child: Container(
                    width: 326.w,
                    height: 525.h,
                    decoration: BoxDecoration(
                      color: themeProvider.themeMode==ThemeMode.dark ? AppColors.blackA19 :Colors.grey.shade100,
                     //color: AppColors.blackA19,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 19,left: 19.w,right: 19.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment:Alignment.topLeft,
                                    child: CustomText(
                                        textAlign: TextAlign.left,
                                        text:'First name',
                                        color: themeProvider.themeMode==ThemeMode.dark ? AppColors.white:AppColors.black,
                                        //color: AppColors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily:'Inter'),
                                  ),
                                  SizedBox(height: 13.h,),
                                  CustomContainerTextFormField(
                                    contentpadding: EdgeInsets.only(left: 15.w),
                                    width: 131.w,
                                    height: 38.h,
                                    validator: (value) {
                                    },
                                    keyboardtype: TextInputType.text,
                                    onFieldSubmitted: (value) {
                                    },
                                    controller: firstnameController,
                                  ),
                                ],
                              ),
                              SizedBox(width: 24.w,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment:Alignment.topRight,
                                    child: CustomText(
                                        textAlign: TextAlign.right,
                                        text:'Last name',
                                        color: themeProvider.themeMode==ThemeMode.dark ? AppColors.white:AppColors.black,
                                       // color: AppColors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily:'Inter'),
                                  ),
                                  SizedBox(height: 13.h,),
                                  CustomContainerTextFormField(
                                    contentpadding: EdgeInsets.only(left: 15.w),
                                    width: 131.w,
                                    height: 38.h,
                                    validator: (value) {
                                    },
                                    keyboardtype: TextInputType.text,
                                    onFieldSubmitted: (value) {
                                    },
                                    controller: lastnameController,
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: 25.h,),
                          Align(
                            alignment:Alignment.topLeft,
                            child: CustomText(
                                textAlign: TextAlign.left,
                                text:'Email address',
                                color: themeProvider.themeMode==ThemeMode.dark ? AppColors.white:AppColors.black,
                                //color: AppColors.white,
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
                            controller:emailController,
                          ),

                          SizedBox(height: 25.h,),
                          Align(
                            alignment:Alignment.topLeft,
                            child: CustomText(
                                textAlign: TextAlign.left,
                                text:'CNIC number',
                                //color: AppColors.white,
                                color: themeProvider.themeMode==ThemeMode.dark ? AppColors.white:AppColors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily:'Inter'),
                          ),
                          SizedBox(height: 13.h,),
                          CustomContainerTextFormField(
                            contentpadding: EdgeInsets.only(left: 15.w),
                            width: 286.w,
                            height: 38.h,
                            validator: (value) {
                            },
                            keyboardtype: TextInputType.number,
                            onFieldSubmitted: (value) {
                            },
                            controller: cnicController,
                          ),


                          SizedBox(height: 25.h,),
                          Align(
                            alignment:Alignment.topLeft,
                            child: CustomText(
                                textAlign: TextAlign.left,
                                text:'Mobile number',
                                //color: AppColors.white,
                                color: themeProvider.themeMode==ThemeMode.dark ? AppColors.white:AppColors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily:'Inter'),
                          ),
                          SizedBox(height: 13.h,),
                          CustomCountryCodePicker(
                            width: 286.w,
                            height: 45.h,
                            decorationcontainer: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                  color: themeProvider.themeMode==ThemeMode.dark? AppColors.white:AppColors.black,
                                // color: AppColors.white,
                              )
                            ),
                            onPhoneChanged: (phone) {
                              fullPhoneNumber = phone;
                            },
                            hintStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily:'Inter',
                            ),
                            initialCountryCode: 'PK',
                            contentPadding: EdgeInsets.only(top: 22.h,left: 10.w),
                            //color: AppColors.white,
                            color: themeProvider.themeMode==ThemeMode.dark ? AppColors.white:AppColors.black,
                          ),

                          SizedBox(height: 15.h,),
                          Align(
                            alignment:Alignment.topLeft,
                            child: CustomText(
                                textAlign: TextAlign.left,
                                text:'Gender',
                                color: themeProvider.themeMode==ThemeMode.dark ? AppColors.white:AppColors.black,
                                //color: AppColors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily:'Inter'),
                          ),
                          SizedBox(height: 15.h,),
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
                      bool canNavigate = true; // Flag to check if navigation is allowed
                      // Validate First Name
                      String firstName = firstnameController.text.trim();
                      String lastName = lastnameController.text.trim();
                      String email = emailController.text.trim();
                      String cnic = cnicController.text.trim();
                      String phoneNumber = fullPhoneNumber.trim();
                      String gender = genderController.getSelectedGender().trim();
                      if (firstName.isNotEmpty && lastName.isNotEmpty && email.isNotEmpty && cnic.isNotEmpty && phoneNumber.isNotEmpty)
                      {
                        try {
                          DocumentReference docRef = await FirebaseFirestore.instance.collection('client').add({
                            'firstName': firstName,
                            'lastName': lastName,
                            'email': email,
                            'cnic': cnic,
                            'phoneNumber': phoneNumber,
                            'gender': gender,
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpAsClient2Screen
                            (firstName: firstName,lastName:lastName, email: email,)));

                          // Show success snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Registration successful! ID: ${docRef.id}'),
                            ),
                          );

                          // Clear text controllers
                          firstnameController.clear();
                          lastnameController.clear();
                          emailController.clear();
                          cnicController.clear();
                          fullPhoneNumber = '';
                          setState(() {
                            selectedGender = '';
                          });


                        } catch (e) {
                          // Show error snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to register your account: $e'),
                            ),
                          );
                        }
                      }
                  else
                  {
                      if (firstName.isEmpty) {
                        Get.snackbar('Error', 'First Name Required!',
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.error_outline, color: AppColors.white,),
                            snackPosition: SnackPosition.TOP);
                        canNavigate = false;
                      }
                      else if (lastName.isEmpty) {
                        // Validate Last Name
                        Get.snackbar('Error', 'Last Name is Required!',
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.error_outline, color: AppColors.white,),
                            snackPosition: SnackPosition.TOP);
                        canNavigate = false;
                      }
                      else if (email.isEmpty) {
                        Get.snackbar('Error', 'Email Required!',
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.error_outline, color: AppColors.white,),
                            snackPosition: SnackPosition.TOP);
                        canNavigate = false;
                      }
                      else {
                        // Check for email format
                        RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
                        if (!emailRegex.hasMatch(emailController.text)) {
                          Get.snackbar('Error', 'Invalid Email!',
                              backgroundColor: AppColors.red,
                              colorText: AppColors.white,
                              borderRadius: 20.r,
                              icon: Icon(Icons.error_outline, color: AppColors.white,),
                              snackPosition: SnackPosition.TOP);
                          canNavigate = false;
                        }
                        else if (cnic.isEmpty) {
                          Get.snackbar('Error', 'CNIC Required!',
                              backgroundColor: AppColors.red,
                              colorText: AppColors.white,
                              borderRadius: 20.r,
                              icon: Icon(Icons.error_outline, color: AppColors.white,),
                              snackPosition: SnackPosition.TOP);
                          canNavigate = false;
                        }
                        else {
                          // Check for CNIC format
                          final cnicRegex = RegExp(r'^\d{5}-\d{7}-\d{1}$');
                          if (!cnicRegex.hasMatch(cnicController.text)) {
                            Get.snackbar('Error', 'Invalid CNIC!',
                                colorText: AppColors.white,
                                backgroundColor: Colors.red,
                                borderRadius: 20.r,
                                icon: Icon(Icons.error_outline, color: AppColors.white,),
                                snackPosition: SnackPosition.TOP);
                            canNavigate = false;
                          }
                          else if(phoneNumber.isEmpty){
                            Get.snackbar('Error', 'Mobile Number Required!',
                                colorText: AppColors.white,
                                backgroundColor: Colors.red,
                                borderRadius: 20.r,
                                icon: Icon(Icons.error_outline, color: AppColors.white,),
                                snackPosition: SnackPosition.TOP);
                            canNavigate = false;
                          }
                        }
                      }
                  }

                      // Navigate if all conditions are met

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
                  padding:  EdgeInsets.only(top: 10.h),
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
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>SignupAsLawyerScreen()));
                          },
                          child: CustomText(
                              text:' Join as a',
                              color: AppColors.tealB3,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily:'Mulish'),
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
