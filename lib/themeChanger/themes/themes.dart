import 'package:flutter/material.dart';
import 'package:projctwakeell/Utils/colors.dart';

class AppThemes {
  AppThemes._();
  /// Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    // colorScheme: ColorScheme.fromSeed(seedColor: AppColors.tealB3),
    useMaterial3: true,
    primaryColor:  AppColors.tealB3,
  );

  /// Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    // colorScheme: ColorScheme.fromSeed(seedColor: AppColors.tealB3),
    useMaterial3: true,
      primaryColor: AppColors.tealB3,
  );

}