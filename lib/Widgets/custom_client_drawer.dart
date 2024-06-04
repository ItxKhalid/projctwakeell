import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projctwakeell/Views/LoginAsClientScreen/login_as_client_screen.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

// Importing other necessary files
import '../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import '../Controllers/translation_controller.dart';
import '../Utils/colors.dart';
import '../Views/ClientDashboardScreen/client_dashboard_screen.dart';
import '../Views/FeedBackFormScreen/feedback_form_screen.dart';
import '../Views/HomePageClientScreen/home_page_client_screen.dart';
import '../Views/LoginAsClientScreen/login_as_client_screen.dart';
import '../Views/selection_screen.dart';
import '../service/Userclass.dart';
import '../service/translation_model.dart';
import '../user_provider.dart';
import 'custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// MyClientDrawer widget
class MyClientDrawer extends StatelessWidget {
  final UserModel loggedInUser; // The logged-in user model

  const MyClientDrawer({Key? key, required this.loggedInUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List myLanguages = [
      "en",
      "ur",
    ];
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Drawer(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark
          ? AppColors.black12
          : Colors.grey.shade100,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40.h),
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                text: AppLocalizations.of(context)!.settings,
                color: themeProvider.themeMode == ThemeMode.dark
                    ? AppColors.white
                    : AppColors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Mulish',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 26.h, right: 15.w, left: 15.w),
            child: Divider(
              color: AppColors.grey2E,
              thickness: 4.h,
            ),
          ),
          // List of ListTile widgets for navigation items
          ListTile(
            leading: Icon(Icons.home,
                color: themeProvider.themeMode == ThemeMode.dark
                    ? AppColors.white
                    : AppColors.tealB3),
            title: Text(
              AppLocalizations.of(context)!.home,
              style: TextStyle(
                color: themeProvider.themeMode == ThemeMode.dark
                    ? AppColors.white
                    : AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                fontFamily: 'Mulish',
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePageClientScreen(
                            loggedInUser: loggedInUser,
                          )));
            },
          ),
          ListTile(
            leading: Icon(Icons.dashboard,
                color: themeProvider.themeMode == ThemeMode.dark
                    ? AppColors.white
                    : AppColors.tealB3),
            title: Text(
              AppLocalizations.of(context)!.dashboard,
              style: TextStyle(
                color: themeProvider.themeMode == ThemeMode.dark
                    ? AppColors.white
                    : AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                fontFamily: 'Mulish',
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClientDashboardScreen(
                    userModel: loggedInUser,
                    loggedInUser: loggedInUser,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback,
                color: themeProvider.themeMode == ThemeMode.dark
                    ? AppColors.white
                    : AppColors.tealB3),
            title: Text(
              AppLocalizations.of(context)!.feedback,
              style: TextStyle(
                color: themeProvider.themeMode == ThemeMode.dark
                    ? AppColors.white
                    : AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                fontFamily: 'Mulish',
              ),
            ),
            // onTap: () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => FeedbackFormScreen(
            //                 loggedInUser: loggedInUser,
            //               )));
            // },
          ),
          ListTile(
            leading: Icon(Icons.file_present_sharp,
                color: themeProvider.themeMode == ThemeMode.dark
                    ? AppColors.white
                    : AppColors.tealB3),
            title: Text(
              AppLocalizations.of(context)!.terms_and_condition,
              style: TextStyle(
                color: themeProvider.themeMode == ThemeMode.dark
                    ? AppColors.white
                    : AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                fontFamily: 'Mulish',
              ),
            ),
            onTap: () {
              // Implement your terms and conditions screen navigation here
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip,
                color: themeProvider.themeMode == ThemeMode.dark
                    ? AppColors.white
                    : AppColors.tealB3),
            title: Text(
              AppLocalizations.of(context)!.privacy_policy,
              style: TextStyle(
                color: themeProvider.themeMode == ThemeMode.dark
                    ? AppColors.white
                    : AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                fontFamily: 'Mulish',
              ),
            ),
            onTap: () {
              // Implement your privacy policy screen navigation here
            },
          ),
          ListTile(
            leading: Icon(Icons.share,
                color: themeProvider.themeMode == ThemeMode.dark
                    ? AppColors.white
                    : AppColors.tealB3),
            title: Text(
              AppLocalizations.of(context)!.share,
              style: TextStyle(
                color: themeProvider.themeMode == ThemeMode.dark
                    ? AppColors.white
                    : AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                fontFamily: 'Mulish',
              ),
            ),
            onTap: () {
              Share.share('com.example.projctwakeell'); // Share your app
            },
          ),
          ListTile(
            leading: Icon(Icons.language_outlined,
                color: themeProvider.themeMode == ThemeMode.dark
                    ? AppColors.white
                    : AppColors.tealB3),
            title: Text(
              AppLocalizations.of(context)!.language,
              style: TextStyle(
                color: themeProvider.themeMode == ThemeMode.dark
                    ? AppColors.white
                    : AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                fontFamily: 'Mulish',
              ),
            ),
            trailing: Consumer<LanguageChangeController>(
              builder: (context, languageChangeController, child) {
                return Container(
                  height: 35,
                  width: 100,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: AppColors.tealB3,
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(color: AppColors.tealB3, width: 2),
                  ),
                  child: ListView.builder(
                    itemCount: translationList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          languageChangeController.setCurrent(index);
                          languageChangeController.changeLanguage(
                              Locale(translationList[index].languageName));
                        },
                        child: Container(
                          width: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            color: languageChangeController.current != index
                                ? AppColors.tealB3
                                : Colors.white,
                          ),
                          child: Center(
                            child: CustomText(
                              text: myLanguages[index],
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Acme',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 60.h),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: themeProvider.themeMode == ThemeMode.dark
                  ? AppColors.white
                  : AppColors.tealB3,
            ),
            title: Text(
              AppLocalizations.of(context)!.log_out,
              style: TextStyle(
                color: themeProvider.themeMode == ThemeMode.dark
                    ? AppColors.white
                    : AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                fontFamily: 'Mulish',
              ),
            ),
            onTap: () {
              CoolAlert.show(
                context: context,
                type: CoolAlertType.confirm,
                animType: CoolAlertAnimType.slideInUp,
                loopAnimation: true,
                showCancelBtn: true,
                cancelBtnText: AppLocalizations.of(context)!.no,
                confirmBtnText: AppLocalizations.of(context)!.yes,
                confirmBtnColor: AppColors.tealB3,
                backgroundColor: AppColors.tealB3.withOpacity(0.3),
                onConfirmBtnTap: () {
                  userProvider.logout().then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectionScreen())));
                  Navigator.of(context).pop();
                },
                text: AppLocalizations.of(context)!.doYouWantToLogoutTheApp,
              );
            },
          ),
          SizedBox(height: 20.h),
          // Switch for changing theme
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(),
              child: SwitchListTile(
                title: Text(
                  themeProvider.themeMode == ThemeMode.dark
                      ? AppLocalizations.of(context)!.night
                      : AppLocalizations.of(context)!.day,
                  style: TextStyle(
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? AppColors.white
                        : AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    fontFamily: 'Mulish',
                  ),
                ),
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
                  themeProvider.themeMode == ThemeMode.dark
                      ? Icons.nightlight_outlined
                      : Icons.light_mode,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
