import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:projctwakeell/Views/LoginAsClientScreen/login_as_client_screen.dart';
import 'package:projctwakeell/themeChanger/themeChangerProvider/theme_changer_provider.dart';
import 'package:projctwakeell/themeChanger/themes/themes.dart';
import 'package:projctwakeell/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Controllers/translation_controller.dart';
import 'Views/HomePageClientScreen/home_page_client_screen.dart';
import 'Views/SplashScreen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeChangerProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => LanguageChangeController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final themeProvider = Provider.of<ThemeChangerProvider>(context);
        final userProvider = Provider.of<UserProvider>(context);

        return Consumer<LanguageChangeController>(
          builder: (context, languageChangeController, child) {
            return Directionality(
              textDirection: languageChangeController.textDirection,
              child: GetMaterialApp(
                locale: languageChangeController.appLocale,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'),
                  Locale('ur'),
                ],
                title: 'Wakeel Naama',
                themeMode: themeProvider.themeMode,
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                home: const SplashScreen(),
                // home: userProvider.loggedInUser != null
                //     ? HomePageClientScreen(loggedInUser: userProvider.loggedInUser!)
                //     : const LoginAsClientScreen(),
              ),
            );
          },
        );
      },
    );
  }
}
