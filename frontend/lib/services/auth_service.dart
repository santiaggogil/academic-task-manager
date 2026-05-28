import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';

class AuthService {

  final Dio _dio = Dio();

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {

    final response = await _dio.post(
      '${ApiConstants.baseUrl}/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    return response.data;
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {

    final response = await _dio.post(
      '${ApiConstants.baseUrl}/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    return response.data;
  }
}