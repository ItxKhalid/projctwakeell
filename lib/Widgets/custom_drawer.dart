import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projctwakeell/Views/HomePage_lawyer_screen/home_page_lawyer_screen.dart';
import 'package:projctwakeell/Views/LawyerDashBoardScreen/lawyer_dashboard_screen.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import '../Utils/colors.dart';
import '../Views/ClientDashboardScreen/client_dashboard_screen.dart';
import '../Views/FeedBackFormScreen/feedback_form_screen.dart';
import '../Views/HomePageClientScreen/home_page_client_screen.dart';
import 'custom_text.dart';

class MyLawyerDrawer extends StatelessWidget {
  const MyLawyerDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return Drawer(
      backgroundColor: themeProvider.themeMode==ThemeMode.dark? AppColors.black12:Colors.grey.shade100,
      child: ListView(
        //  padding: EdgeInsets.zero,
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 40.h,),
            child: Align(
              alignment: Alignment.center,
              child: CustomText(text: 'Settings',
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? AppColors.white // Dark theme color
                      : AppColors.black,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Mulish'),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 26.h,right: 15.w,left: 15.w),
            child: Divider(color: AppColors.grey2E,thickness: 4.h,),
          ),


          ListTile(
            leading: Icon(Icons.home, color: themeProvider.themeMode == ThemeMode.dark ? AppColors.white : AppColors.tealB3),
            title: Text('Home',
              style: TextStyle(
                color: themeProvider.themeMode == ThemeMode.dark ? AppColors.white : AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                fontFamily: 'Mulish',
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageLawyerScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.dashboard, color: themeProvider.themeMode == ThemeMode.dark ? AppColors.white : AppColors.tealB3),
            title: Text('Dashboard',
              style: TextStyle(
                color: themeProvider.themeMode == ThemeMode.dark ? AppColors.white : AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                fontFamily: 'Mulish',
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LawyerDashboardScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.file_present_sharp, color: themeProvider.themeMode == ThemeMode.dark ? AppColors.white : AppColors.tealB3),
            title: Text('Terms & Conditions',
              style: TextStyle(
                color: themeProvider.themeMode == ThemeMode.dark ? AppColors.white : AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                fontFamily: 'Mulish',
              ),
            ),
            onTap: () {

            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip, color: themeProvider.themeMode == ThemeMode.dark ? AppColors.white : AppColors.tealB3),
            title: Text('Privacy Policy',
              style: TextStyle(
                color: themeProvider.themeMode == ThemeMode.dark ? AppColors.white : AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                fontFamily: 'Mulish',
              ),
            ),
            onTap: () {

            },
          ),
          ListTile(
            leading: Icon(Icons.share, color: themeProvider.themeMode == ThemeMode.dark ? AppColors.white : AppColors.tealB3),
            title: Text('Share',
              style: TextStyle(
                color: themeProvider.themeMode == ThemeMode.dark ? AppColors.white : AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                fontFamily: 'Mulish',
              ),
            ),
            onTap: () {
              Share.share('com.example.projctwakeell');
            },
          ),
          SizedBox(height: 60.h,),
          ListTile(
            leading: Icon(Icons.logout, color: themeProvider.themeMode == ThemeMode.dark ? AppColors.white : AppColors.tealB3),
            title: Text('Log out',
              style: TextStyle(
                color: themeProvider.themeMode == ThemeMode.dark ? AppColors.white : AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                fontFamily: 'Mulish',
              ),
            ),
            onTap: () {

            },
          ),

          SizedBox(height: 20.h,),

          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(),
              child: SwitchListTile(
                title: Text(themeProvider.themeMode == ThemeMode.dark ? "Night" : "Day",style: TextStyle(
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? AppColors.white // Dark theme color
                        : AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    fontFamily:'Mulish'),), // Dynamically set text
                value: themeProvider.themeMode == ThemeMode.dark,
                activeColor: AppColors.white,
                activeTrackColor: AppColors.tealB3,
                inactiveThumbColor: AppColors.white,
                inactiveTrackColor: AppColors.grey33,
                onChanged: (value) {
                  final newThemeMode = value ? ThemeMode.dark : ThemeMode.light;
                  themeProvider.setTheme(newThemeMode);
                },
                secondary: Icon(
                  themeProvider.themeMode == ThemeMode.dark ? Icons.nightlight_outlined : Icons.light_mode, // Day icon for Light Mode, Night icon for Dark Mode
                  color: Theme.of(context).iconTheme.color, // Optionally set the color based on the current theme
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
