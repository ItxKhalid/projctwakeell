import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projctwakeell/Utils/colors.dart';
import 'package:projctwakeell/Views/ClientDashboardScreen/suggestionScreen.dart';
import 'package:projctwakeell/Views/LawyerDashBoardScreen/Components/Lawyer_message_screen.dart';
import 'package:projctwakeell/Widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import '../../Utils/images.dart';
import '../../Widgets/custom_client_drawer.dart';
import '../../Widgets/custom_text.dart';
import '../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import 'Components/Client_chats_screen.dart';
import 'Components/Lawyer screen.dart';
import 'Components/client_appointment_screen.dart';
import 'Components/client_message_screen.dart';
import 'Components/client_profile_screen.dart';
import 'Components/search_screen.dart';
import '../../service/Userclass.dart';

class ClientDashboardScreen extends StatefulWidget {
  final UserModel userModel;
  final UserModel loggedInUser;
  const ClientDashboardScreen({super.key, required this.userModel, required this.loggedInUser});

  @override
  State<ClientDashboardScreen> createState() => _ClientDashboardScreenState();
}

class _ClientDashboardScreenState extends State<ClientDashboardScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    UserModel loggedInUser = widget.loggedInUser;

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
                        fontFamily: 'Acme',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _key.currentState!.openDrawer();
                      },
                      child: Icon(
                        Icons.menu,
                        color: AppColors.tealB3,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 19.h),
                child: CustomText(
                  textAlign: TextAlign.center,
                  text: 'Client Dashboard',
                  color: AppColors.grey5C,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Mulish',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 49.h),
                child: Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Welcome ',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 28.sp,
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? AppColors.white
                                : AppColors.black,
                            fontFamily: 'Acme',
                          ),
                        ),
                        TextSpan(
                          text: '${widget.userModel.firstName}!',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 28.sp,
                            color: AppColors.tealB3,
                            fontFamily: 'Acme',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Container(
                  width: 334.w,
                  height: 636.h,
                  decoration: BoxDecoration(
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? AppColors.black919
                        : Colors.grey.shade100,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 27.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ClientProfileScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                width: 124.w,
                                height: 122.h,
                                decoration: BoxDecoration(
                                  color: themeProvider.themeMode == ThemeMode.dark
                                      ? AppColors.black12
                                      : Colors.grey.shade200,
                                  border: Border.all(
                                    color: themeProvider.themeMode == ThemeMode.dark
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: themeProvider.themeMode == ThemeMode.dark
                                          ? AppColors.white
                                          : AppColors.black,
                                    ),
                                    SizedBox(height: 10.h),
                                    CustomText(
                                      text: 'My Profile',
                                      color: themeProvider.themeMode == ThemeMode.dark
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Mulish',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              width: 124.w,
                              height: 122.h,
                              decoration: BoxDecoration(
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? AppColors.black12
                                    : Colors.grey.shade200,
                                border: Border.all(
                                  color: themeProvider.themeMode == ThemeMode.dark
                                      ? AppColors.white
                                      : AppColors.black,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cases_rounded,
                                    color: themeProvider.themeMode == ThemeMode.dark
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                  SizedBox(height: 10.h),
                                  Center(
                                    child: CustomText(
                                      textAlign: TextAlign.center,
                                      text: 'Case\nCategories',
                                      color: themeProvider.themeMode == ThemeMode.dark
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Mulish',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 31.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(onTap:(){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyLawyerScreens(),
                                ),
                              );
                            },
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                width: 124.w,
                                height: 122.h,
                                decoration: BoxDecoration(
                                  color: themeProvider.themeMode == ThemeMode.dark
                                      ? AppColors.black12
                                      : Colors.grey.shade200,
                                  border: Border.all(
                                    color: themeProvider.themeMode == ThemeMode.dark
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.person,
                                      color: themeProvider.themeMode == ThemeMode.dark
                                          ? AppColors.white
                                          : AppColors.black,
                                    ),
                                    SizedBox(height: 10.h),
                                    CustomText(
                                      textAlign: TextAlign.center,
                                      text: 'My Lawyer',
                                      color: themeProvider.themeMode == ThemeMode.dark
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Mulish',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ClientAppointmentScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                width: 124.w,
                                height: 122.h,
                                decoration: BoxDecoration(
                                  color: themeProvider.themeMode == ThemeMode.dark
                                      ? AppColors.black12
                                      : Colors.grey.shade200,
                                  border: Border.all(
                                    color: themeProvider.themeMode == ThemeMode.dark
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.assignment_ind_rounded,
                                      color: themeProvider.themeMode == ThemeMode.dark
                                          ? AppColors.white
                                          : AppColors.black,
                                    ),
                                    SizedBox(height: 10.h),
                                    CustomText(
                                      textAlign: TextAlign.center,
                                      text: 'My\nAppointments',
                                      color: themeProvider.themeMode == ThemeMode.dark
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Mulish',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              alignment: Alignment.bottomCenter,
                              width: 124.w,
                              height: 122.h,
                              decoration: BoxDecoration(
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? AppColors.black12
                                    : Colors.grey.shade200,
                                border: Border.all(
                                  color: themeProvider.themeMode == ThemeMode.dark
                                      ? AppColors.white
                                      : AppColors.black,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.file_copy_rounded,
                                    color: themeProvider.themeMode == ThemeMode.dark
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                  SizedBox(height: 10.h),
                                  CustomText(
                                    textAlign: TextAlign.center,
                                    text: 'My\nDocuments',
                                    color: themeProvider.themeMode == ThemeMode.dark
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Mulish',
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              width: 124.w,
                              height: 122.h,
                              decoration: BoxDecoration(
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? AppColors.black12
                                    : Colors.grey.shade200,
                                border: Border.all(
                                  color: themeProvider.themeMode == ThemeMode.dark
                                      ? AppColors.white
                                      : AppColors.black,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cases_rounded,
                                    color: themeProvider.themeMode == ThemeMode.dark
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                  SizedBox(height: 10.h),
                                  CustomText(
                                    textAlign: TextAlign.center,
                                    text: 'Case Status',
                                    color: themeProvider.themeMode == ThemeMode.dark
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Mulish',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 31.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ClientChatsScreen()
                                  ),
                                );
                              },
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                width: 124.w,
                                height: 122.h,
                                decoration: BoxDecoration(
                                  color: themeProvider.themeMode == ThemeMode.dark
                                      ? AppColors.black12
                                      : Colors.grey.shade200,
                                  border: Border.all(
                                    color: themeProvider.themeMode == ThemeMode.dark
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.message_rounded,
                                      color: themeProvider.themeMode == ThemeMode.dark
                                          ? AppColors.white
                                          : AppColors.black,
                                    ),
                                    SizedBox(height: 10.h),
                                    CustomText(
                                      textAlign: TextAlign.center,
                                      text: 'Messages',
                                      color: themeProvider.themeMode == ThemeMode.dark
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Mulish',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  SuggestionScreen()
                                ),
                              );
                            },
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                width: 124.w,
                                height: 122.h,
                                decoration: BoxDecoration(
                                  color: themeProvider.themeMode == ThemeMode.dark
                                      ? AppColors.black12
                                      : Colors.grey.shade200,
                                  border: Border.all(
                                    color: themeProvider.themeMode == ThemeMode.dark
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.settings_suggest_outlined,
                                      color: themeProvider.themeMode == ThemeMode.dark
                                          ? AppColors.white
                                          : AppColors.black,
                                    ),
                                    SizedBox(height: 10.h),
                                    CustomText(
                                      textAlign: TextAlign.center,
                                      text: 'Suggestion',
                                      color: themeProvider.themeMode == ThemeMode.dark
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Mulish',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: MyClientDrawer(loggedInUser: loggedInUser)

    );
  }
}
