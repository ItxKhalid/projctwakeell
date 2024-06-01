import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projctwakeell/Utils/colors.dart';
import 'package:projctwakeell/Views/LawyerDashBoardScreen/Components/myClient_screen.dart';
import 'package:projctwakeell/Widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

import '../../Widgets/custom_text.dart';
import '../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import '../AppointmentsScreen/My_appointment_page.dart';
import '../ClientDashboardScreen/Components/client_profile_screen.dart';
import '../chatBotScreen.dart';
import 'Components/Add_client_details.dart';
import 'Components/Lawyer_chats_screen.dart';
import 'Components/my_docs.dart';

class LawyerDashboardScreen extends StatefulWidget {
  const LawyerDashboardScreen({super.key});

  @override
  State<LawyerDashboardScreen> createState() => _LawyerDashboardScreenState();
}

class _LawyerDashboardScreenState extends State<LawyerDashboardScreen> {
  //we are taking key to open drawer on tab on any icon
  GlobalKey<ScaffoldState> _key = GlobalKey();
  final User? user = FirebaseAuth.instance.currentUser;
  String lawyerName = '';

  @override
  void initState() {
    super.initState();
    fetchLawyerName();
  }

  Future<void> fetchLawyerName() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('lawyer')
          .where('userId', isEqualTo: uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDoc = querySnapshot.docs.first;
        setState(() {
          lawyerName =
              '${userDoc['firstName']} ${userDoc['lastName']}' ?? 'User';
        });
      } else {
        setState(() {
          print('ididididididiidididididid$uid');
          lawyerName = 'User';
        });
      }
    } catch (e) {
      print("Error fetching lawyer name: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        bool shouldPop = await CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          animType: CoolAlertAnimType.slideInUp,
          loopAnimation: true,
          showCancelBtn: true,
          cancelBtnText: AppLocalizations.of(context)!.no,
          confirmBtnText: AppLocalizations.of(context)!.yes,
          confirmBtnColor: AppColors.tealB3,
          backgroundColor: AppColors.tealB3.withOpacity(0.3),
          onConfirmBtnTap: () {
            SystemNavigator.pop();
          },
          text: AppLocalizations.of(context)!.doYouWantToExitTheApp,
        );
        return shouldPop ?? false; // Prevent pop if shouldPop is null
      },
      child: Scaffold(
        key: _key,
        floatingActionButton: FloatingActionButton(
          clipBehavior: Clip.hardEdge,
          shape: OvalBorder(),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ChatBotScreen()));
          },
          child: Image.asset('assets/images/chatbot.png',
              fit: BoxFit.fitHeight, height: 100),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 42.h, left: 39.w, right: 29.13.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      text:
                          '${AppLocalizations.of(context)!.lawyer} ${AppLocalizations.of(context)!.dashboard}',
                      color: AppColors.grey5C,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Mulish'),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 49.h,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text:
                                '${AppLocalizations.of(context)!.welcome_to} ',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 28.sp,
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? AppColors.white // Dark theme color
                                  : AppColors.black,
                              fontFamily: 'Acme',
                            )),
                        TextSpan(
                            text: lawyerName,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 28.sp,
                              color: AppColors.tealB3,
                              fontFamily: 'Acme',
                            )),
                      ]),
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
                            : Colors.grey.shade100
                        //color: AppColors.black919,
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
                                      builder: (context) =>
                                          const ClientProfileScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  width: 124.w,
                                  height: 122.h,
                                  decoration: BoxDecoration(
                                    color: themeProvider.themeMode ==
                                            ThemeMode.dark
                                        ? AppColors.black12
                                        : Colors.grey.shade200,
                                    border: Border.all(
                                      color: themeProvider.themeMode ==
                                              ThemeMode.dark
                                          ? AppColors.white
                                          : AppColors.black,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: themeProvider.themeMode ==
                                                ThemeMode.dark
                                            ? AppColors.white
                                            : AppColors.black,
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomText(
                                        text: AppLocalizations.of(context)!
                                            .my_profile,
                                        color: themeProvider.themeMode ==
                                                ThemeMode.dark
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
                                          builder: (context) =>
                                              const MyClientScreens()));
                                },
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  width: 124.w,
                                  height: 122.h,
                                  decoration: BoxDecoration(
                                    color: themeProvider.themeMode ==
                                            ThemeMode.dark
                                        ? AppColors.black12
                                        : Colors.grey.shade200,
                                    // color: AppColors.black12,
                                    border: Border.all(
                                        color: themeProvider.themeMode ==
                                                ThemeMode.dark
                                            ? AppColors.white
                                            : AppColors.black
                                        // color: AppColors.white,
                                        ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person_add_alt_rounded,
                                        color: themeProvider.themeMode ==
                                                ThemeMode.dark
                                            ? AppColors.white
                                            : AppColors.black,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      CustomText(
                                          text: AppLocalizations.of(context)!
                                              .myClients,
                                          color: themeProvider.themeMode ==
                                                  ThemeMode.dark
                                              ? AppColors.white
                                              : AppColors.black,
                                          // color: AppColors.white,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Mulish'),
                                    ],
                                  ),
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
                                          builder: (context) =>
                                              const AppointmentPage()));
                                },
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  width: 124.w,
                                  height: 122.h,
                                  decoration: BoxDecoration(
                                    color: themeProvider.themeMode ==
                                            ThemeMode.dark
                                        ? AppColors.black12
                                        : Colors.grey.shade200,
                                    // color: AppColors.black12,
                                    border: Border.all(
                                      color: themeProvider.themeMode ==
                                              ThemeMode.dark
                                          ? AppColors.white
                                          : AppColors.black,
                                      // color: AppColors.white,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.assignment_ind_rounded,
                                        color: themeProvider.themeMode ==
                                                ThemeMode.dark
                                            ? AppColors.white
                                            : AppColors.black,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      CustomText(
                                          textAlign: TextAlign.center,
                                          text: AppLocalizations.of(context)!
                                              .my_appointments,
                                          color: themeProvider.themeMode ==
                                                  ThemeMode.dark
                                              ? AppColors.white
                                              : AppColors.black,
                                          // color: AppColors.white,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Mulish'),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AddClientScreen()));
                                },
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  width: 124.w,
                                  height: 122.h,
                                  decoration: BoxDecoration(
                                    color: themeProvider.themeMode ==
                                            ThemeMode.dark
                                        ? AppColors.black12
                                        : Colors.grey.shade200,
                                    // color: AppColors.black12,
                                    border: Border.all(
                                      color: themeProvider.themeMode ==
                                              ThemeMode.dark
                                          ? AppColors.white
                                          : AppColors.black,
                                      // color: AppColors.white,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.cases_rounded,
                                        color: themeProvider.themeMode ==
                                                ThemeMode.dark
                                            ? AppColors.white
                                            : AppColors.black,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      CustomText(
                                          textAlign: TextAlign.center,
                                          text: AppLocalizations.of(context)!
                                              .add_client_details,
                                          color: themeProvider.themeMode ==
                                                  ThemeMode.dark
                                              ? AppColors.white
                                              : AppColors.black,
                                          // color: AppColors.white,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Mulish'),
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyDocument()));
                                },
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  width: 124.w,
                                  height: 122.h,
                                  decoration: BoxDecoration(
                                    color: themeProvider.themeMode ==
                                            ThemeMode.dark
                                        ? AppColors.black12
                                        : Colors.grey.shade200,
                                    // color: AppColors.black12,
                                    border: Border.all(
                                      color: themeProvider.themeMode ==
                                              ThemeMode.dark
                                          ? AppColors.white
                                          : AppColors.black,
                                      // color: AppColors.white,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.file_copy_rounded,
                                        color: themeProvider.themeMode ==
                                                ThemeMode.dark
                                            ? AppColors.white
                                            : AppColors.black,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      CustomText(
                                          textAlign: TextAlign.center,
                                          text: AppLocalizations.of(context)!
                                              .my_documents,
                                          color: themeProvider.themeMode ==
                                                  ThemeMode.dark
                                              ? AppColors.white
                                              : AppColors.black,
                                          // color: AppColors.white,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Mulish'),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LawyerChatsScreen()));
                                },
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  width: 124.w,
                                  height: 122.h,
                                  decoration: BoxDecoration(
                                    color: themeProvider.themeMode ==
                                            ThemeMode.dark
                                        ? AppColors.black12
                                        : Colors.grey.shade200,
                                    // color: AppColors.black12,
                                    border: Border.all(
                                      color: themeProvider.themeMode ==
                                              ThemeMode.dark
                                          ? AppColors.white
                                          : AppColors.black,
                                      // color: AppColors.white,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.message_rounded,
                                        color: themeProvider.themeMode ==
                                                ThemeMode.dark
                                            ? AppColors.white
                                            : AppColors.black,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      CustomText(
                                          textAlign: TextAlign.center,
                                          text: AppLocalizations.of(context)!
                                              .messages,
                                          color: themeProvider.themeMode ==
                                                  ThemeMode.dark
                                              ? AppColors.white
                                              : AppColors.black,
                                          // color: AppColors.white,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Mulish'),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        drawer: const MyLawyerDrawer(),
      ),
    );
  }
}
