import 'dart:convert';

import 'package:http/http.dart'
as http;

import '../core/constants/api_constants.dart';

import '../models/dashboard_stats_model.dart';

class DashboardService {

  Future<DashboardStatsModel>
  getStats(String token) async {

    final response =
    await http.get(

      Uri.parse(
        '${ApiConstants.baseUrl}/tasks/stats',
      ),

      headers: {

        'Authorization':
        'Bearer $token',
      },
    );

    if (response.statusCode == 200) {

      return DashboardStatsModel
          .fromJson(
        jsonDecode(
          response.body,
        ),
      );
    }

    throw Exception(
      'Error loading stats',
    );
  }
}