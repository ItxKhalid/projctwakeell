import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projctwakeell/Utils/colors.dart';
import 'package:projctwakeell/Widgets/custom_client_drawer.dart';
import 'package:projctwakeell/Widgets/custom_Container_button.dart';
import 'package:projctwakeell/Widgets/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../Utils/images.dart';
import '../../../Widgets/custom_container_textform_field.dart';
import '../../../Widgets/custom_country_code_picker.dart';
import '../../../service/Userclass.dart';
import '../../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import 'client_profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClientEditProfileScreen extends StatefulWidget {
  const ClientEditProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ClientEditProfileScreen> createState() =>
      _ClientEditProfileScreenState();
}

class _ClientEditProfileScreenState extends State<ClientEditProfileScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  late String? uid;
  Map<String, dynamic>? _userData;

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? gender;

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
        var userAndLawyer =
            AppConst.getUserType == 'lawyer' ? 'licenseNumber' : 'cnic';
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection(userType)
            .where('email', isEqualTo: email)
            .limit(1)
            .get();

        if (querySnapshot.size > 0) {
          DocumentSnapshot userSnapshot = querySnapshot.docs.first;
          setState(() {
            _userData = userSnapshot.data() as Map<String, dynamic>;
            firstnameController.text = _userData!['firstName'];
            lastnameController.text = _userData!['lastName'];
            phoneController.text = _userData!['phoneNumber'];
            cnicController.text = _userData![userAndLawyer];
            gender = _userData!['gender'];
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

  Future<void> _updateUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;
      String? email = user.email;

      if (email != null) {
        print("User id: $uid, Email: $email");
        try {
          showDialog(
            context: context,
            builder: (context) {
              return Center(child: AppConst.spinKitWave());
            },
            barrierDismissible: false,
          );
          // Query the collection to find the document with the specified email
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('client')
              .where('email', isEqualTo: email)
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            // Assuming there is only one document with this email
            String docId = querySnapshot.docs.first.id;
            print("Document found with id: $docId");

            // Update the document with the new data
            await FirebaseFirestore.instance
                .collection('client')
                .doc(docId)
                .update({
              'firstName': firstnameController.text,
              'lastName': lastnameController.text,
              'cnic': cnicController.text,
              'phoneNumber': phoneController.text,
              'gender': gender,
            });

            print('User data updated successfully');
          } else {
            print('No document found with the specified email');
          }
          Navigator.pop(context);
        } catch (e) {
          Navigator.pop(context);
          print('Error updating user data: $e');
        }
      } else {
        print('User email is null');
      }
    } else {
      print('No user is signed in');
    }
  }

  Future<void> _updateLawyerData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;
      String? email = user.email;

      if (email != null) {
        print("User id: $uid, Email: $email");
        try {
          showDialog(
            context: context,
            builder: (context) {
              return Center(child: AppConst.spinKitWave());
            },
            barrierDismissible: false,
          );
          // Query the collection to find the document with the specified email
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('lawyer')
              .where('email', isEqualTo: email)
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            // Assuming there is only one document with this email
            String docId = querySnapshot.docs.first.id;
            print("Document found with id: $docId");

            // Update the document with the new data
            await FirebaseFirestore.instance
                .collection('lawyer')
                .doc(docId)
                .update({
              'firstName': firstnameController.text,
              'lastName': lastnameController.text,
              'licenseNumber': cnicController.text,
              'phoneNumber': phoneController.text,
              'gender': gender,
            });

            print('User data updated successfully');
          } else {
            print('No document found with the specified email');
          }
          Navigator.pop(context);
        } catch (e) {
          Navigator.pop(context);
          print('Error updating user data: $e');
        }
      } else {
        print('User email is null');
      }
    } else {
      print('No user is signed in');
    }
  }

  Future<void> _showUpdateConfirmation() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.profileUpdated),
          content: Text(AppLocalizations.of(context)!
              .yourProfileHasBeenUpdatedSuccessfully),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.oK),
              onPressed: () {
                Navigator.of(context).pop();
                AppConst.getUserType == 'lawyer'
                    ? _updateLawyerData().then((value) => {Get.back()})
                    : _updateUserData().then((value) => {Get.back()});
              },
            ),
          ],
        );
      },
    );
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
                padding: EdgeInsets.only(top: 19.h, left: 19.w, right: 19.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    _buildEditableField(
                        context,
                        AppLocalizations.of(context)!.first_name,
                        firstnameController),
                    SizedBox(height: 13.h),
                    _buildEditableField(
                        context,
                        AppLocalizations.of(context)!.last_name,
                        lastnameController),
                    SizedBox(height: 25.h),
                    _buildEditableField(context,
                        AppLocalizations.of(context)!.cnic, cnicController,
                        keyboardType: TextInputType.number),
                    SizedBox(height: 25.h),
                    _buildEditableField(
                        context,
                        AppLocalizations.of(context)!.mobile_number,
                        phoneController,
                        keyboardType: TextInputType.phone),
                    SizedBox(
                      height: 13.h,
                    ),
                    SizedBox(height: 15.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: CustomText(
                          textAlign: TextAlign.left,
                          text: AppLocalizations.of(context)!.gender,
                          color: themeProvider.themeMode == ThemeMode.dark
                              ? AppColors.white
                              : AppColors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter'),
                    ),
                    SizedBox(height: 15.h),
                    GenderDropDownComponent(
                      initialValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.h, left: 38.w, right: 38.w),
                child: GestureDetector(
                  onTap: () async {
                    _showUpdateConfirmation();
                  },
                  child: CustomButton(
                    borderRadius: BorderRadius.circular(10.r),
                    height: 55.h,
                    width: 317.w,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Mulish',
                    fontSize: 22.2.sp,
                    text: AppLocalizations.of(context)!.updateProfile,
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

  Widget _buildEditableField(
      BuildContext context, String label, TextEditingController controller,
      {bool readOnly = false,
      TextInputType keyboardType = TextInputType.text,
      void Function()? onTap}) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: CustomText(
              textAlign: TextAlign.left,
              text: label,
              color: themeProvider.themeMode == ThemeMode.dark
                  ? AppColors.white
                  : AppColors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter'),
        ),
        SizedBox(height: 13.h),
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            absorbing: readOnly,
            child: CustomContainerTextFormField(
              contentpadding: EdgeInsets.only(left: 15.w),
              width: 286.w,
              height: 38.h,
              validator: (value) {},
              keyboardtype: keyboardType,
              onFieldSubmitted: (value) {},
              controller: controller,
            ),
          ),
        ),
      ],
    );
  }
}

class GenderDropDownComponent extends StatelessWidget {
  final String? initialValue;
  final ValueChanged<String?> onChanged;

  GenderDropDownComponent({
    this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: initialValue,
      hint: Text(AppLocalizations.of(context)!.selectGender),
      onChanged: onChanged,
      items: <String>['Male', 'Female', 'Other'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
