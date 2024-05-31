import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeController extends ChangeNotifier {
  Locale? _locale;
  String languageCodeKey = 'languageCode';
  TextDirection _textDirection = TextDirection.ltr;

  Locale? get appLocale => _locale;
  TextDirection get textDirection => _textDirection;

  int _current = 0;

  int get current => _current;

  void setCurrent(int index) {
    _current = index;
    notifyListeners();
  }

  LanguageChangeController() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final preferences = await SharedPreferences.getInstance();
    final languageCode = preferences.getString(languageCodeKey);
    if (languageCode != null) {
      _locale = Locale(languageCode);
      _textDirection = languageCode == 'ur' ? TextDirection.rtl : TextDirection.ltr;
      _current = languageCode == 'ur' ? 1 : 0;  // Assuming 'ur' is at index 1 and 'en' is at index 0
    } else {
      _locale = const Locale('en');
      _textDirection = TextDirection.ltr;
      _current = 0;
    }
    notifyListeners();
  }

  Future<void> changeLanguage(Locale locale) async {
    _locale = locale;
    _textDirection = locale.languageCode == 'ur' ? TextDirection.rtl : TextDirection.ltr;
    _current = locale.languageCode == 'ur' ? 1 : 0;  // Update current index based on the selected language
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(languageCodeKey, locale.languageCode);
    notifyListeners();
  }
}
