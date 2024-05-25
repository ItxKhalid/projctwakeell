import 'package:flutter/material.dart';
import 'package:projctwakeell/service/Userclass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';  // For JSON encoding and decoding

class UserProvider with ChangeNotifier {
  UserModel? _loggedInUser;

  UserProvider() {
    _loadUserFromPrefs();
  }

  UserModel? get loggedInUser => _loggedInUser;

  void _loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('loggedInUser');
    if (userData != null) {
      _loggedInUser = UserModel.fromMap(json.decode(userData));
      notifyListeners();
    }
  }

  Future<void> setLoggedInUser(UserModel user) async {
    _loggedInUser = user;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedInUser', json.encode(user.toMap()));
    notifyListeners();
  }

  Future<void> logout() async {
    _loggedInUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedInUser');
    notifyListeners();
  }
}
