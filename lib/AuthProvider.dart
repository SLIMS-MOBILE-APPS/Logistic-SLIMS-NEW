import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/AuthenticationModels.dart';
import 'Models/LogisticLoginModels.dart';

class AuthProvider with ChangeNotifier {
  AuthenticationAPIModels? _authResponse;
  LogisticLoginModels? _loginResponse;

  // Getters for the responses
  AuthenticationAPIModels? get authResponse => _authResponse;
  LogisticLoginModels? get loginResponse => _loginResponse;

  // Getter for isAuthenticated
  Future<bool> get isAuthenticated async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAuthenticated') ?? false;
  }

  // Save authentication response
  Future<void> saveAuthResponse(AuthenticationAPIModels? authModel) async {
    final prefs = await SharedPreferences.getInstance();

    if (authModel != null) {
      _authResponse = authModel;
      notifyListeners();

      String authData = jsonEncode(authModel.toJson());
      prefs.setString('authResponse', authData);
      await prefs.setBool('isAuthenticated', true);

      print("Auth response saved: $authData");  // Debugging log
    } else {
      _authResponse = null;
      notifyListeners();

      await prefs.setBool('isAuthenticated', false);
      print("Invalid auth response: Authentication failed.");
    }
  }


  // Save login response
  Future<void> saveLoginResponse(LogisticLoginModels? loginModel) async {
    final prefs = await SharedPreferences.getInstance();

    if (loginModel != null) {
      _loginResponse = loginModel;
      notifyListeners();

      String loginData = jsonEncode(loginModel.toJson());
      prefs.setString('loginResponse', loginData);
      print("Login response saved: $loginData");
    } else {
      _loginResponse = null;
      notifyListeners();

      print("Invalid login response: Login failed.");
    }
  }

  // Load both responses from SharedPreferences
  Future<void> loadResponses() async {
    final prefs = await SharedPreferences.getInstance();

    final authData = prefs.getString('authResponse');
    if (authData != null) {
      print("Auth data loaded: $authData");
      _authResponse = AuthenticationAPIModels.fromJson(jsonDecode(authData));
    } else {
      print("No auth data found in SharedPreferences");
    }

    final loginData = prefs.getString('loginResponse');
    if (loginData != null) {
      _loginResponse = LogisticLoginModels.fromJson(jsonDecode(loginData));
    } else {
      print("No login data found in SharedPreferences");
    }

    notifyListeners();
  }



  // Clear both responses
  Future<void> clearResponses() async {
    _authResponse = null;
    //_loginResponse = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.remove('authResponse');
   // prefs.remove('loginResponse');
    await prefs.setBool('isAuthenticated', false);
  }

  Future<void> logout() async {
    await clearResponses();
    print("User has been logged out.");
  }
}
