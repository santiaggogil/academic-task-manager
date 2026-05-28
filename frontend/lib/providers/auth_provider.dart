import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {

  final AuthService _authService = AuthService();

  bool isLoading = false;

  String? token;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {

    isLoading = true;

    notifyListeners();

    try {

      await _authService.register(
        name: name,
        email: email,
        password: password,
      );

    } catch (e) {

      rethrow;

    } finally {

      isLoading = false;

      notifyListeners();
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {

    isLoading = true;

    notifyListeners();

    try {

      final response = await _authService.login(
        email: email,
        password: password,
      );

      token = response['access_token'];

      final prefs =
      await SharedPreferences.getInstance();

      await prefs.setString(
        'token',
        token!,
      );

    } catch (e) {

      rethrow;

    } finally {

      isLoading = false;

      notifyListeners();
    }
  }

  Future<void> loadToken() async {

    final prefs =
    await SharedPreferences.getInstance();

    token = prefs.getString('token');

    notifyListeners();
  }

  Future<void> logout() async {

    final prefs =
    await SharedPreferences.getInstance();

    await prefs.remove('token');

    token = null;

    notifyListeners();
  }

  bool get isAuthenticated =>
      token != null;
}