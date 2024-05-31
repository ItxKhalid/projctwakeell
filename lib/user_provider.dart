import 'package:flutter/material.dart';
import 'package:projctwakeell/Utils/images.dart';
import 'package:projctwakeell/service/Userclass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';  // For JSON encoding and decoding

class UserProvider with ChangeNotifier {
  UserModel? _loggedInUser;
  LawyerModel? _loggedInLawyer;

  UserProvider() {
    _loadUserFromPrefs();
    _loadLawyerFromPrefs();
  }

  UserModel? get loggedInUser => _loggedInUser;
  LawyerModel? get loggedInLawyer => _loggedInLawyer;

  void _loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('loggedInUser');
    if (userData != null) {
      _loggedInUser = UserModel.fromMap(json.decode(userData));
      notifyListeners();
    }
  }
  void _loadLawyerFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('loggedInLawyer');
    if (userData != null) {
      _loggedInLawyer = LawyerModel.fromMap(json.decode(userData));
      notifyListeners();
    }
  }

  Future<void> setLoggedInUser(UserModel user) async {
    _loggedInUser = user;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedInUser', json.encode(user.toMap()));
    notifyListeners();
  }

  Future<void> setLoggedInLawyer(LawyerModel user) async {
    _loggedInLawyer = user;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedInLawyer', json.encode(user.toMap()));
    notifyListeners();
  }

  Future<void> logout() async {
    _loggedInUser = null;
    _loggedInLawyer = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedInUser');
    await prefs.remove('loggedInLawyer');
    notifyListeners();
  }
}
