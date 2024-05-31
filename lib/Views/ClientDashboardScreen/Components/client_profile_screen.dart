import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projctwakeell/Utils/colors.dart';
import 'package:projctwakeell/Widgets/custom_Container_button.dart';
import 'package:projctwakeell/Widgets/custom_client_drawer.dart';
import 'package:projctwakeell/Widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../Utils/images.dart';
import '../../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import 'client_editprofile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
        var userType = AppConst.getUserType == 'lawyer' ? 'lawyer' : 'client';
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection(userType)
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
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back, color: AppColors.white),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: CustomText(
                          textAlign: TextAlign.left,
                          text: AppLocalizations.of(context)!.wakeel_naama,
                          color: AppColors.tealB3,
                          fontSize: 20.91.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Acme'),
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
                        text: AppLocalizations.of(context)!.change_picture,
                        backgroundColor: AppColors.tealB3,
                        color: AppColors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ClientEditProfileScreen()));
                      },
                      child: CustomButton(
                        borderRadius: BorderRadius.circular(10.r),
                        height: 55.h,
                        width: 150.w,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Mulish',
                        fontSize: 18.sp,
                        text: AppLocalizations.of(context)!.edit_profile,
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
                          text: AppLocalizations.of(context)!.welcome_back,
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
              AppConst.getUserType == 'lawyer'
                  ? _buildInfoRow(context, Icons.confirmation_num, 'License:',
                      _userData != null ? _userData!['licenseNumber'] : '')
                  : _buildInfoRow(context, Icons.confirmation_num, '${AppLocalizations.of(context)!.cnic}:',
                      _userData != null ? _userData!['cnic'] : ''),
              _buildInfoRow(context, Icons.email, '${AppLocalizations.of(context)!.email}:',
                  _userData != null ? _userData!['email'] : ''),
              _buildInfoRow(context, Icons.call, '${AppLocalizations.of(context)!.mobile}:',
                  _userData != null ? _userData!['phoneNumber'] : ''),
              _buildInfoRow(context, Icons.person, '${AppLocalizations.of(context)!.gender}:',
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
                    text: AppLocalizations.of(context)!.my_cases,
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
        uploadImage(context);
      });
    }
  }

  Future<void> uploadImage(BuildContext context) async {
    final _firestore = FirebaseFirestore.instance;
    final refStorage = firebase_storage.FirebaseStorage.instance
        .ref('/profileImage/${FirebaseAuth.instance.currentUser!.uid}');
    final uploadTask = refStorage.putFile(File(_selectedImage!.path).absolute);
    final user = FirebaseAuth.instance.currentUser;
    try {
      // Create a reference to the location you want to upload the file to
      final refStorage = firebase_storage.FirebaseStorage.instance
          .ref('/profileImage/${user!.uid}');
      // Upload the file to the reference

      // Wait for the upload to complete
      await uploadTask;

      // Get the download URL of the uploaded file
      final newUrl = await refStorage.getDownloadURL();

      // Determine the user type and corresponding Firestore collection
      var userType = AppConst.getUserType == 'lawyer' ? 'lawyer' : 'client';
      var id = AppConst.getUserType == 'lawyer' ? 'uid' : 'userId';

      // Query the Firestore collection to find the document with the field 'uid' matching the current user's UID
      QuerySnapshot querySnapshot = await _firestore
          .collection(userType)
          .where(id, isEqualTo: user.uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there's only one document with the matching 'uid' field
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

        // Update the Firestore document with the new image URL
        await _firestore.collection(userType).doc(documentSnapshot.id).update({
          'image': newUrl.toString(),
        });
        Get.snackbar(
          'Congratulations',
          'Profile Image Updated',
          backgroundColor: AppColors.tealB3,
          colorText: AppColors.white,
          borderRadius: 20.r,
          icon: Icon(Icons.done, color: AppColors.white),
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: AppColors.red.withOpacity(0.4),
        colorText: AppColors.white,
        borderRadius: 20.r,
        icon: Icon(Icons.done, color: AppColors.white),
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
