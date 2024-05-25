import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projctwakeell/Utils/colors.dart';
import 'package:projctwakeell/Widgets/custom_client_drawer.dart';
import 'package:projctwakeell/Widgets/custom_Container_button.dart';
import 'package:projctwakeell/Widgets/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../Utils/images.dart';
import '../../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import 'client_editprofile_screen.dart';

class ClientProfileScreen extends StatefulWidget {

  const ClientProfileScreen({Key? key}) : super(key: key);

  @override
  State<ClientProfileScreen> createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  File? _selectedImage;
  late String? uid;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
      String email = user.email!;
      print("User id: $uid, Email: $email");

      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('client')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();

        if (querySnapshot.size > 0) {
          DocumentSnapshot userSnapshot = querySnapshot.docs.first;
          setState(() {
            _userData = userSnapshot.data() as Map<String, dynamic>;
          });
        } else {
          print('No user found for email: $email');
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    } else {
      print('User not authenticated');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return Scaffold(
      key: _key,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 42.h, left: 39.w, right: 29.13.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: CustomText(
                          textAlign: TextAlign.left,
                          text: 'Wakeel Naama',
                          color: AppColors.tealB3,
                          fontSize: 20.91.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Acme'),
                    ),
                    GestureDetector(
                      onTap: () {
                        _key.currentState!.openDrawer();
                      },
                      child: Icon(Icons.menu, color: AppColors.tealB3),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: GestureDetector(
                  onTap: () {
                    _pickImageFromCamera();
                  },
                  child: _selectedImage == null
                      ? CircleAvatar(
                    radius: 80.r,
                    backgroundColor: AppColors.white,
                    backgroundImage: AssetImage(AppImages.image11),
                    onBackgroundImageError:
                        (dynamic error, StackTrace? stackTrace) {},
                  )
                      : CircleAvatar(
                      radius: 80.r,
                      backgroundColor: AppColors.white,
                      backgroundImage: FileImage(_selectedImage!)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _pickImageFromCamera();
                      },
                      child: CustomButton(
                        borderRadius: BorderRadius.circular(10.r),
                        height: 55.h,
                        width: 150.w,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Mulish',
                        fontSize: 18.sp,
                        text: 'Change Picture',
                        backgroundColor: AppColors.tealB3,
                        color: AppColors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>ClientEditProfileScreen()));
                      },
                      child: CustomButton(
                        borderRadius: BorderRadius.circular(10.r),
                        height: 55.h,
                        width: 150.w,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Mulish',
                        fontSize: 18.sp,
                        text: 'Edit Profile',
                        backgroundColor: AppColors.tealB3,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 49.h),
                child: Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'Welcome Back',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 22.sp,
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? AppColors.white
                                : AppColors.black,
                            fontFamily: 'Acme',
                          )),
                      TextSpan(
                          text: _userData != null
                              ? '  ${_userData!['firstName']} ${_userData!['lastName']}!'
                              : '',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 22.sp,
                            color: AppColors.tealB3,
                            fontFamily: 'Acme',
                          )),
                    ]),
                  ),
                ),
              ),
              _buildInfoRow(context, Icons.confirmation_num, 'CNIC:',
                  _userData != null ? _userData!['cnic'] : ''),
              _buildInfoRow(context, Icons.email, 'Email:',
                  _userData != null ? _userData!['email'] : ''),
              _buildInfoRow(context, Icons.call, 'Mobile:',
                  _userData != null ? _userData!['phoneNumber'] : ''),
              _buildInfoRow(context, Icons.person, 'Gender:',
                  _userData != null ? _userData!['gender'] : ''),
              Padding(
                padding: EdgeInsets.only(top: 50.h, left: 38.w, right: 38.w),
                child: GestureDetector(
                  onTap: () {
                    // Implement my cases functionality
                  },
                  child: CustomButton(
                    borderRadius: BorderRadius.circular(10.r),
                    height: 55.h,
                    width: 317.w,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Mulish',
                    fontSize: 22.2.sp,
                    text: 'My Cases',
                    backgroundColor: AppColors.tealB3,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),


    );
  }

  Widget _buildInfoRow(
      BuildContext context, IconData icon, String label, String? value) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return Padding(
      padding: EdgeInsets.only(top: 20.h, right: 10.w, left: 30.w),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 10.w),
          CustomText(
            textAlign: TextAlign.left,
            text: '$label:',
            color: themeProvider.themeMode == ThemeMode.dark
                ? AppColors.white
                : AppColors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
            fontFamily: 'Acme',
          ),
          SizedBox(width: 20.w),
          CustomText(
            textAlign: TextAlign.left,
            text: value ?? '',
            color: AppColors.tealB3,
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            fontFamily: 'Acme',
          ),
        ],
      ),
    );
  }

  // For picking an image from camera
  Future<void> _pickImageFromCamera() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }
}
