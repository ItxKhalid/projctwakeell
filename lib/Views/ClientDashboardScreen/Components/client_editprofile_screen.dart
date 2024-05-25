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
import '../../../Widgets/custom_container_textform_field.dart';
import '../../../Widgets/custom_country_code_picker.dart';
import '../../../service/Userclass.dart';
import '../../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import 'client_profile_screen.dart';

class ClientEditProfileScreen extends StatefulWidget {

  const ClientEditProfileScreen({Key? key, }) : super(key: key);

  @override
  State<ClientEditProfileScreen> createState() => _ClientEditProfileScreenState();
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
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('client')
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
            cnicController.text = _userData!['cnic'];
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
            await FirebaseFirestore.instance.collection('client').doc(docId).update({
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
        } catch (e) {
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
          title: Text('Profile Updated'),
          content: Text('Your profile has been updated successfully.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ClientProfileScreen()),
                );
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
                padding: EdgeInsets.only(top: 19.h, left: 19.w, right: 19.w),
                child: Column(
                  children: [

                    SizedBox(height: 20.h),
                    _buildEditableField(
                        context,
                        'First name',
                        firstnameController
                    ),

                    SizedBox(height: 13.h),
                    _buildEditableField(
                        context,
                        'Last name',
                        lastnameController
                    ),

                    SizedBox(height: 25.h),
                    _buildEditableField(
                        context,
                        'CNIC',
                        cnicController,
                        keyboardType: TextInputType.number
                    ),

                    SizedBox(height: 25.h),
                    _buildEditableField(
                        context,
                        'Mobile number',
                        phoneController,
                        keyboardType: TextInputType.phone
                    ),
                    SizedBox(height: 13.h,),

                    SizedBox(height: 15.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: CustomText(
                          textAlign: TextAlign.left,
                          text: 'Gender',
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
                    await _updateUserData();
                    _showUpdateConfirmation();
                  },
                  child: CustomButton(
                    borderRadius: BorderRadius.circular(10.r),
                    height: 55.h,
                    width: 317.w,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Mulish',
                    fontSize: 22.2.sp,
                    text: 'Update Profile',
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
      BuildContext context,
      String label,
      TextEditingController controller,
      {bool readOnly = false, TextInputType keyboardType = TextInputType.text, void Function()? onTap}) {
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
              validator: (value) {
              },
              keyboardtype: keyboardType,
              onFieldSubmitted: (value) {
              },
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
      hint: Text("Select Gender"),
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


