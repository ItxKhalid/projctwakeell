import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projctwakeell/Utils/colors.dart';
import 'package:projctwakeell/Widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Utils/images.dart';
import '../../Widgets/custom_text.dart';
import '../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import '../chatBotScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePageLawyerScreen extends StatefulWidget {
  const HomePageLawyerScreen({super.key});

  @override
  State<HomePageLawyerScreen> createState() => _HomePageLawyerScreenState();
}

class _HomePageLawyerScreenState extends State<HomePageLawyerScreen> {
  //we are taking key to open drawer on tab on any icon
  GlobalKey<ScaffoldState> _key = GlobalKey();
  int _currentIndex = 0;
  int _totalItems = 3;
  final controller=CarouselController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return Scaffold(
      key: _key,
      floatingActionButton: FloatingActionButton(
        clipBehavior: Clip.hardEdge,
        shape: OvalBorder(),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatBotScreen()));
        },
        child: Image.asset('assets/images/chatbot.png',fit: BoxFit.fitHeight,height: 100),
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
                padding: EdgeInsets.only(
                  top: 49.h,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: AppLocalizations.of(context)!.welcome_to,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 28.sp,
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? AppColors.white // Dark theme color
                                : AppColors.black,
                            fontFamily: 'Acme',
                          )),
                      TextSpan(
                          text:
                          ' ${AppLocalizations.of(context)!.wakeel_naama}!',
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
                padding: EdgeInsets.only(top: 21.h),
                child: Align(
                  alignment: Alignment.center,
                  child: CustomText(
                      textAlign: TextAlign.center,
                      text: '',
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? AppColors.white // Dark theme color
                          : AppColors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Mulish'),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 13.h, left: 94.w, right: 93.w),
                child: Image.asset(
                  AppImages.image5,
                  width: 206.w,
                  height: 135.h,
                  fit: BoxFit.cover,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 21.h, left: 12.w, right: 12.w),
                child: Row(
                  children: [
                    Container(
                      width: 108.w,
                      height: 160.h,
                      decoration: BoxDecoration(
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? AppColors.grey33 // Dark theme color
                            : Colors.grey.shade100,
                        //color: AppColors.grey33,
                      ),
                      child: Image.asset(
                        AppImages.image6,
                      ),
                    ),
                    Container(
                      width: 261.w,
                      height: 160.h,
                      decoration: BoxDecoration(
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? AppColors.black919 // Dark theme color
                            : Colors.grey[100],
                        //color: AppColors.black919,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 17.w, vertical: 17.h),
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: '${AppLocalizations.of(context)!.wakeel_naama} ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp,
                                  color: AppColors.tealB3,
                                  fontFamily: 'Mulish',
                                )),
                            TextSpan(
                                text: AppLocalizations.of(context)!
                                    .wakell_nama_is_the_changeing_app,
                                style: TextStyle(
                                  color: themeProvider.themeMode ==
                                      ThemeMode.dark
                                      ? AppColors.white // Dark theme color
                                      : AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Mulish',
                                  // fontSize: 15.sp,
                                )),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 21.h),
                child: Align(
                  alignment: Alignment.center,
                  child: CustomText(
                      textAlign: TextAlign.center,
                      text: AppLocalizations.of(context)!.mission,
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? AppColors.white // Dark theme color
                          : AppColors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Mulish'),
                ),
              ),
              Container(
                width: 50.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: AppColors.tealB3,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 12.h, left: 29.w, right: 29.w),
                child: Center(
                  child: CustomText(
                      textAlign: TextAlign.justify,
                      text: AppLocalizations.of(context)!
                          .our_mission_is_to_empower,
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? AppColors.white // Dark theme color
                          : AppColors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Mulish'),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: Align(
                  alignment: Alignment.center,
                  child: CustomText(
                      textAlign: TextAlign.center,
                      text: AppLocalizations.of(context)!.benefits,
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? AppColors.white // Dark theme color
                          : AppColors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Mulish'),
                ),
              ),
              Container(
                width: 50.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: AppColors.tealB3,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 21.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: 101.82.w,
                      height: 86.h,
                      decoration: BoxDecoration(
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? AppColors.black12
                            : Colors.grey[100],
                        border: Border.all(color: AppColors.white),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite,
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? AppColors.tealB3
                                : AppColors.tealB3,
                          ),
                          SizedBox(height: 5.h),
                          CustomText(
                            textAlign: TextAlign.center,
                            text: AppLocalizations.of(context)!.user_friendly,
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? AppColors.white
                                : AppColors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Mulish',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: 101.82.w,
                      height: 86.h,
                      decoration: BoxDecoration(
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? AppColors.black12
                            : Colors.grey[100],
                        border: Border.all(color: AppColors.white),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.security,
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? AppColors.tealB3
                                : AppColors.tealB3,
                          ),
                          SizedBox(height: 5.h),
                          CustomText(
                            textAlign: TextAlign.center,
                            text: AppLocalizations.of(context)!.secure,
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? AppColors.white
                                : AppColors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Mulish',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: 101.82.w,
                      height: 86.h,
                      decoration: BoxDecoration(
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? AppColors.black12
                            : Colors.grey[100],
                        border: Border.all(color: AppColors.white),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.settings,
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? AppColors.tealB3
                                : AppColors.tealB3,
                          ),
                          SizedBox(height: 5.h),
                          CustomText(
                            textAlign: TextAlign.center,
                            text: AppLocalizations.of(context)!.convenient,
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? AppColors.white
                                : AppColors.black,
                            fontSize: 14.sp,
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
                padding: EdgeInsets.only(top: 15.h),
                child: Align(
                  alignment: Alignment.center,
                  child: CustomText(
                      textAlign: TextAlign.center,
                      text: AppLocalizations.of(context)!.testimonials,
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? AppColors.white // Dark theme color
                          : AppColors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Mulish'),
                ),
              ),

              Container(
                width: 50.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: AppColors.tealB3,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),

              CarouselSlider(
                carouselController: controller,
                items: [
                  Padding(
                    padding: EdgeInsets.only(top: 27.h),
                    child: SizedBox(
                      height: 140.h,
                      width: 300.w,
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              //margin: EdgeInsets.symmetric(horizontal: 2.w),
                              width: 259.w,
                              height: 140.h,
                              decoration: BoxDecoration(
                                color:
                                themeProvider.themeMode == ThemeMode.dark
                                    ? AppColors.black919
                                    : Colors.grey.shade100,
                                // color: AppColors.black919,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.r),
                                    bottomRight: Radius.circular(30.r)),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 40,
                            left: 5,
                            child: SizedBox(
                              height: 62.h,
                              width: 62.w,
                              child: Container(
                                height: 19.h,
                                width: 19.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(34.r),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    AppImages.image10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            left: 50,
                            child: Image.asset(
                              AppImages.image8,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              top: 8,
                              left: 190,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: AppColors.tealB3,
                                    size: 12.sp,
                                  ),
                                  Icon(Icons.star,
                                      color: AppColors.tealB3, size: 12.sp),
                                  Icon(Icons.star,
                                      color: AppColors.tealB3, size: 12.sp),
                                  Icon(Icons.star,
                                      color: AppColors.tealB3, size: 12.sp),
                                  Icon(Icons.star,
                                      color: AppColors.tealB3, size: 12.sp),
                                ],
                              )),
                          Positioned(
                            top: 35,
                            right: 19,
                            left: 68,
                            child: CustomText(
                                textAlign: TextAlign.justify,
                                text:
                                ' ${AppLocalizations.of(context)!.found_the_perfect_lawyer_home_page}',
                                //color: AppColors.white,
                                color:
                                themeProvider.themeMode == ThemeMode.dark
                                    ? AppColors.white
                                    : AppColors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Mulish'),
                          ),
                          Positioned(
                            top: 90,
                            left: 150,
                            child: Image.asset(
                              AppImages.image9,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 103,
                            right: 20,
                            left: 70,
                            child: CustomText(
                                textAlign: TextAlign.justify,
                                text: 'Hamna Afzal',
                                color: AppColors.tealB3,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Mulish'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 27.h),
                    child: SizedBox(
                      height: 140.h,
                      width: 300.w,
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              //margin: EdgeInsets.symmetric(horizontal: 2.w),
                              width: 259.w,
                              height: 140.h,
                              decoration: BoxDecoration(
                                color:
                                themeProvider.themeMode == ThemeMode.dark
                                    ? AppColors.black919
                                    : Colors.grey.shade100,
                                // color: AppColors.black919,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.r),
                                    bottomRight: Radius.circular(30.r)),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 40,
                            left: 5,
                            child: SizedBox(
                              height: 62.h,
                              width: 62.w,
                              child: Container(
                                height: 19.h,
                                width: 19.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(34.r),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    AppImages.image10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            left: 50,
                            child: Image.asset(
                              AppImages.image8,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              top: 8,
                              left: 190,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: AppColors.tealB3,
                                    size: 12.sp,
                                  ),
                                  Icon(Icons.star,
                                      color: AppColors.tealB3, size: 12.sp),
                                  Icon(Icons.star,
                                      color: AppColors.tealB3, size: 12.sp),
                                  Icon(Icons.star,
                                      color: AppColors.tealB3, size: 12.sp),
                                  Icon(Icons.star,
                                      color: AppColors.tealB3, size: 12.sp),
                                ],
                              )),
                          Positioned(
                            top: 35,
                            right: 19,
                            left: 68,
                            child: CustomText(
                                textAlign: TextAlign.justify,
                                text:
                                ' found the perfect lawyer for my case within minutes! Wakeel Naama made the process so simple and stress-free.',
                                //color: AppColors.white,
                                color:
                                themeProvider.themeMode == ThemeMode.dark
                                    ? AppColors.white
                                    : AppColors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Mulish'),
                          ),
                          Positioned(
                            top: 90,
                            left: 150,
                            child: Image.asset(
                              AppImages.image9,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 103,
                            right: 20,
                            left: 70,
                            child: CustomText(
                                textAlign: TextAlign.justify,
                                text: 'Hamna Afzal',
                                color: AppColors.tealB3,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Mulish'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 27.h),
                        child: SizedBox(
                          height: 140.h,
                          width: 300.w,
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  //margin: EdgeInsets.symmetric(horizontal: 2.w),
                                  width: 259.w,
                                  height: 140.h,
                                  decoration: BoxDecoration(
                                    color: themeProvider.themeMode ==
                                        ThemeMode.dark
                                        ? AppColors.black919
                                        : Colors.grey.shade100,
                                    // color: AppColors.black919,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.r),
                                        bottomRight: Radius.circular(30.r)),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 40,
                                left: 5,
                                child: SizedBox(
                                  height: 62.h,
                                  width: 62.w,
                                  child: Container(
                                    height: 19.h,
                                    width: 19.w,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(34.r),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        AppImages.image10,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 20,
                                left: 50,
                                child: Image.asset(
                                  AppImages.image8,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                  top: 8,
                                  left: 190,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: AppColors.tealB3,
                                        size: 12.sp,
                                      ),
                                      Icon(Icons.star,
                                          color: AppColors.tealB3,
                                          size: 12.sp),
                                      Icon(Icons.star,
                                          color: AppColors.tealB3,
                                          size: 12.sp),
                                      Icon(Icons.star,
                                          color: AppColors.tealB3,
                                          size: 12.sp),
                                      Icon(Icons.star,
                                          color: AppColors.tealB3,
                                          size: 12.sp),
                                    ],
                                  )),
                              Positioned(
                                top: 35,
                                right: 19,
                                left: 68,
                                child: CustomText(
                                    textAlign: TextAlign.justify,
                                    text:
                                    ' found the perfect lawyer for my case within minutes! Wakeel Naama made the process so simple and stress-free.',
                                    //color: AppColors.white,
                                    color: themeProvider.themeMode ==
                                        ThemeMode.dark
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Mulish'),
                              ),
                              Positioned(
                                top: 90,
                                left: 150,
                                child: Image.asset(
                                  AppImages.image9,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 103,
                                right: 20,
                                left: 70,
                                child: CustomText(
                                    textAlign: TextAlign.justify,
                                    text: 'Hamna Afzal',
                                    color: AppColors.tealB3,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Mulish'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

                ////////////////////////////////////
                options: CarouselOptions(
                  initialPage: 0,
                  height: 166.55.h,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  //not moving
                  // aspectRatio: 16 / 9,
                  // autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayCurve: Curves.slowMiddle,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 1000),
                  // viewportFraction: 0.8,
                  // aspectRatio: 4.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),

              buildIndicator(),
              // buildButtons(),
            ],
          ),
        ),
      ),
      drawer: MyLawyerDrawer(),
    );
  }

  Widget buildIndicator() =>AnimatedSmoothIndicator(
    activeIndex: _currentIndex ,
    count: 3,
    effect: JumpingDotEffect(
      dotHeight: 10.h,
      dotWidth: 10.w,
      activeDotColor: AppColors.tealB3,
      dotColor: AppColors.grey,
    ),
  );



// Widget buildButtons({bool stretch = false}) =>
//     Padding(
//       padding: EdgeInsets.symmetric(horizontal: 30.w),
//       child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//       GestureDetector(
//           onTap:(){
//         previous;
//
//       },
//           child: Image.asset(AppImages.image12, width: 20.w,height: 20.h,
//               fit:BoxFit.cover)),
//       SizedBox(width: 20),
//       GestureDetector(
//           onTap:(){
//           next;
//           },
//           child: Image.asset(AppImages.image13,
//           width: 20.w,height: 20.h,
//           fit:BoxFit.cover,)),
//           ],
//         ),
//     );


// void next()=> controller.nextPage(duration: Duration(microseconds: 500));
//
// void previous()=> controller.previousPage(duration: Duration(microseconds: 500));

}
