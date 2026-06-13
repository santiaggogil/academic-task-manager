import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../core/constants/api_constants.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final url = '${ApiConstants.baseUrl}/register';
    final data = {
      'name': name,
      'email': email,
      'password': password,
    };

    if (kDebugMode) {
      print('--- AUDITORÍA REGISTRO ---');
      print('URL: $url');
      print('Body: $data');
    }

    try {
      final response = await _dio.post(url, data: data);

      if (kDebugMode) {
        print('Status: ${response.statusCode}');
        print('Response Body: ${response.data}');
      }

      return response.data;
    } catch (e) {
      if (e is DioException && kDebugMode) {
        print('Error Status: ${e.response?.statusCode}');
        print('Error Body: ${e.response?.data}');
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = '${ApiConstants.baseUrl}/login';
    final data = {
      'email': email,
      'password': password,
    };

    if (kDebugMode) {
      print('--- AUDITORÍA LOGIN ---');
      print('URL: $url');
      print('Body: $data');
    }

    try {
      final response = await _dio.post(url, data: data);

      if (kDebugMode) {
        print('Status: ${response.statusCode}');
        print('Response Body: ${response.data}');
        print('Access Token: ${response.data['access_token']}');
      }

      return response.data;
    } catch (e) {
      if (e is DioException && kDebugMode) {
        print('Error Status: ${e.response?.statusCode}');
        print('Error Body: ${e.response?.data}');
      }
      rethrow;
    }
  }
}
