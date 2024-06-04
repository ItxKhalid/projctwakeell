import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:projctwakeell/Utils/colors.dart';
import 'package:projctwakeell/Utils/images.dart';
import 'package:projctwakeell/Views/HomePageClientScreen/home_page_client_screen.dart';
import 'package:projctwakeell/Views/LoginAsClientScreen/login_as_client_screen.dart';
import 'package:projctwakeell/Views/LoginAsLawyerScreen/login_as_lawyer_screen.dart';
import 'package:projctwakeell/Widgets/custom_Container_button.dart';
import 'package:projctwakeell/Widgets/custom_container_textform_field.dart';
import 'package:projctwakeell/Widgets/custom_text.dart';
import 'package:projctwakeell/service/Userclass.dart';
import 'package:projctwakeell/themeChanger/themeChangerProvider/theme_changer_provider.dart';
import 'package:projctwakeell/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool passVisibility = false;
  final _formKey = GlobalKey<FormState>();
  int? selectedIndex; // Variable to keep track of the selected index

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
                      text: AppLocalizations.of(context)!.wakeel_naama,
                      color: AppColors.tealB3,
                      fontSize: 20.91.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Acme',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24.h),
                  child: Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      textAlign: TextAlign.center,
                      text: "${AppLocalizations.of(context)!.join_as_a} ${AppLocalizations.of(context)!.client} / ${AppLocalizations.of(context)!.lawyer}",
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? AppColors.white
                          : AppColors.black,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Mulish',
                    ),
                  ),
                ),
                const SizedBox(height:44),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        height: 175,
                        margin: const EdgeInsets.only(bottom: 24),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: index == 0 ? const Color(0xff191A19) : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: selectedIndex == index ? Colors.teal : Colors.grey)
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(index == 0 ? AppImages.profileimg : AppImages.image2),
                                Radio(
                                  value: index,
                                  activeColor: Colors.teal,
                                  groupValue: selectedIndex,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedIndex = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CustomText(
                              textAlign: TextAlign.center,
                              text: index == 0 ? AppLocalizations.of(context)!.client_description : AppLocalizations.of(context)!.lawyer_description,
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? AppColors.white
                                  : AppColors.black,
                              fontSize: 18.sp,
                              maxLines: 3,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Mulish',
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 38.w, right: 38.w),
                  child: GestureDetector(
                    onTap: selectedIndex != null ? () {
                      selectedIndex == 0
                          ? Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginAsClientScreen()))
                          : Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginAsLawyerScreen()));
                    } : null,
                    child: CustomButton(
                      borderRadius: BorderRadius.circular(10.r),
                      height: 55.h,
                      width: 317.w,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Mulish',
                      fontSize: 18.2.sp,
                      text: selectedIndex != null ? selectedIndex == 0
                          ? AppLocalizations.of(context)!.log_in_as_a + AppLocalizations.of(context)!.client
                          :  AppLocalizations.of(context)!.log_in_as_a + AppLocalizations.of(context)!.lawyer : AppLocalizations.of(context)!.create_account,
                      backgroundColor: selectedIndex != null ? AppColors.tealB3 : AppColors.grey41,
                      border: Border.all(color:  AppColors.tealB3 ),
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
                      text: AppLocalizations.of(context)!.dont_have_account,
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? AppColors.white
                          : AppColors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Mulish',
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

