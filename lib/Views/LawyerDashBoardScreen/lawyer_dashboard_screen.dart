import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projctwakeell/Utils/colors.dart';
import 'package:projctwakeell/Views/LawyerDashBoardScreen/Components/Lawyer_message_screen.dart';
import 'package:projctwakeell/Views/LawyerDashBoardScreen/Components/myClient_screen.dart';
import 'package:projctwakeell/Widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import '../../Utils/images.dart';
import '../../Widgets/custom_text.dart';
import '../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import '../AppointmentsScreen/My_appointment_page.dart';
import '../LawyerProfileScreen/Lawyer_profile_page.dart';
import 'Components/Add_client_details.dart';
import 'Components/Lawyer_analytics.dart';
import 'Components/Lawyer_chats_screen.dart';
import 'Components/Lawyer_earning.dart';

class LawyerDashboardScreen extends StatefulWidget {
  const LawyerDashboardScreen({super.key});

  @override
  State<LawyerDashboardScreen> createState() => _LawyerDashboardScreenState();
}

class _LawyerDashboardScreenState extends State<LawyerDashboardScreen> {
  //we are taking key to open drawer on tab on any icon
  GlobalKey<ScaffoldState> _key = GlobalKey();
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    _firestore
        .collection('lawyer')
        .where('uid', isEqualTo: user?.uid)
        .snapshots();
    return Scaffold(
      key: _key,
      body: SafeArea(
        child:SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                padding: EdgeInsets.only(top: 19.h),
                child: CustomText(
                    textAlign: TextAlign.center,
                    text:'Lawyer Dashboard',
                    color: AppColors.grey5C,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily:'Mulish'),
              ),


              Padding(
                padding:  EdgeInsets.only(top: 49.h,),
                child: Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                        children: <TextSpan>
                        [
                          TextSpan(text: 'Welcome ',
                              style: TextStyle(
                                fontWeight:FontWeight.w400 ,
                                fontSize: 28.sp,
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? AppColors.white // Dark theme color
                                    : AppColors.black,
                                fontFamily: 'Acme',
                              )),
                          TextSpan(text: ' ${AppConst.getUserName}!',
                              style: TextStyle(
                                fontWeight:FontWeight.w400 ,
                                fontSize: 28.sp,
                                color: AppColors.tealB3,
                                fontFamily: 'Acme',
                              )),

                        ]
                    ),),
                ),
              ),


          Padding(
            padding:  EdgeInsets.only(top: 20.h),
            child: Container(
              width: 334.w,
              height: 636.h,
              decoration: BoxDecoration(
                  color: themeProvider.themeMode==ThemeMode.dark? AppColors.black919: Colors.grey.shade100
                //color: AppColors.black919,
              ),
              child:Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 27.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> LawyerProfileScreen()));
                            },
                            child:Container(
                              alignment: Alignment.bottomCenter,
                              width: 124.w,
                              height: 122.h,
                              decoration: BoxDecoration(
                                color: themeProvider.themeMode==ThemeMode.dark? AppColors.black12: Colors.grey.shade200,
                                // color: AppColors.black12,
                                border: Border.all(     color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black
                                  // color: AppColors.white,
                                ),
                              ),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.person,
                                    color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                  ),
                                  SizedBox(height: 10.h,),
                                  CustomText(
                                      text:'My Profile',
                                      color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                      // color: AppColors.white,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily:'Mulish'),
                                ],
                              ) ,

                            ),
                        ),

                        GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> MyClientScreens()));

                            },
                            child:Container(
                              alignment: Alignment.bottomCenter,
                              width: 124.w,
                              height: 122.h,
                              decoration: BoxDecoration(
                                color: themeProvider.themeMode==ThemeMode.dark? AppColors.black12: Colors.grey.shade200,
                                // color: AppColors.black12,
                                border: Border.all( color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black
                                  // color: AppColors.white,
                                ),
                              ),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.person_add_alt_rounded,
                                    color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                  ),
                                  SizedBox(height: 10.h,),
                                  CustomText(
                                      text:'My Clients',
                                      color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                      // color: AppColors.white,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily:'Mulish'),
                                ],
                              ) ,

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
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> AppointmentPage()));
                            },
                            child:Container(
                              alignment: Alignment.bottomCenter,
                              width: 124.w,
                              height: 122.h,
                              decoration: BoxDecoration(
                                color: themeProvider.themeMode==ThemeMode.dark? AppColors.black12: Colors.grey.shade200,
                                // color: AppColors.black12,
                                border: Border.all(    color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                  // color: AppColors.white,
                                ),
                              ),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.assignment_ind_rounded,
                                    color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                  ),
                                  SizedBox(height: 10.h,),
                                  CustomText(
                                      textAlign: TextAlign.center,
                                      text:'My\nAppointments',
                                      color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                      // color: AppColors.white,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily:'Mulish'),
                                ],
                              ) ,

                            ),
                        ),

                        GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddClientScreen()));
                            },
                            child:Container(
                              alignment: Alignment.bottomCenter,
                              width: 124.w,
                              height: 122.h,
                              decoration: BoxDecoration(
                                color: themeProvider.themeMode==ThemeMode.dark? AppColors.black12: Colors.grey.shade200,
                                // color: AppColors.black12,
                                border: Border.all(color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                  // color: AppColors.white,
                                ),
                              ),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.cases_rounded,
                                    color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                  ),
                                  SizedBox(height: 10.h,),
                                  CustomText(
                                      textAlign: TextAlign.center,
                                      text:'Add Client Details ',
                                      color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                      // color: AppColors.white,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily:'Mulish'),
                                ],
                              ) ,

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
                            onTap: (){

                            },
                            child:Container(
                              alignment: Alignment.bottomCenter,
                              width: 124.w,
                              height: 122.h,
                              decoration: BoxDecoration(
                                color: themeProvider.themeMode==ThemeMode.dark? AppColors.black12: Colors.grey.shade200,
                                // color: AppColors.black12,
                                border: Border.all( color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                  // color: AppColors.white,
                                ),
                              ),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_copy_rounded,
                                    color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                  ),
                                  SizedBox(height: 10.h,),
                                  CustomText(
                                      textAlign: TextAlign.center,
                                      text:'My\nDocuments',
                                      color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                      // color: AppColors.white,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily:'Mulish'),
                                ],
                              ) ,

                            ),
                        ),
                        GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> LawyerAnalyticsScreen()));
                            },
                            child:Container(
                              alignment: Alignment.bottomCenter,
                              width: 124.w,
                              height: 122.h,
                              decoration: BoxDecoration(
                                color: themeProvider.themeMode==ThemeMode.dark? AppColors.black12: Colors.grey.shade200,
                                // color: AppColors.black12,
                                border: Border.all( color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                  // color: AppColors.white,
                                ),
                              ),
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.analytics,
                                    color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                  ),
                                  SizedBox(height: 10.h,),
                                  CustomText(
                                      textAlign: TextAlign.center,
                                      text:'Analytics',
                                      color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                      // color: AppColors.white,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily:'Mulish'),
                                ],
                              ) ,

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
                        onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>LawyerChatsScreen()));
                          },
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            width: 124.w,
                            height: 122.h,
                            decoration: BoxDecoration(
                              color: themeProvider.themeMode==ThemeMode.dark? AppColors.black12: Colors.grey.shade200,
                              // color: AppColors.black12,
                              border: Border.all(  color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                // color: AppColors.white,
                              ),
                            ),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.message_rounded,
                                  color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                ),
                                SizedBox(height: 10.h,),
                                CustomText(
                                    textAlign: TextAlign.center,
                                    text:'Messages',
                                    color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                    // color: AppColors.white,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily:'Mulish'),
                              ],
                            ) ,
                          
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LawyerEarningScreen()));
                          },
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            width: 124.w,
                            height: 122.h,
                            decoration: BoxDecoration(
                              color: themeProvider.themeMode==ThemeMode.dark? AppColors.black12: Colors.grey.shade200,
                              // color: AppColors.black12,
                              border: Border.all(color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                // color: AppColors.white,
                              ),
                            ),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.money_rounded,
                                  color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                ),
                                SizedBox(height: 10.h,),
                                CustomText(
                                    textAlign: TextAlign.center,
                                    text:'My Earnings',
                                    color: themeProvider.themeMode==ThemeMode.dark? AppColors.white: AppColors.black,
                                    // color: AppColors.white,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily:'Mulish'),
                              ],
                            ) ,

                          ),
                        ),
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
      drawer: MyLawyerDrawer(),
    );
  }
}
