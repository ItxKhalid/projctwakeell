import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChangerProvider with ChangeNotifier {
  static const _themeModeKey = 'theme_mode';
  SharedPreferences? _prefs;
  late ThemeMode _themeMode=ThemeMode.dark;

  ThemeChangerProvider() {
    _initTheme();
  }

  Future<void> _initTheme() async {
    _prefs = await SharedPreferences.getInstance();
    _themeMode = ThemeMode.values[_prefs?.getInt(_themeModeKey) ?? ThemeMode.dark.index];
    notifyListeners();
  }

  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    _prefs?.setInt(_themeModeKey, themeMode.index);
    notifyListeners();
  }
}
