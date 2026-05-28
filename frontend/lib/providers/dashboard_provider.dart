import 'package:flutter/material.dart';

import '../models/dashboard_stats_model.dart';

import '../services/dashboard_service.dart';

class DashboardProvider
    extends ChangeNotifier {

  DashboardStatsModel? stats;

  bool isLoading = false;

  final DashboardService
  _dashboardService =
  DashboardService();

  Future<void> loadStats(
      String token) async {

    isLoading = true;

    notifyListeners();

    try {

      stats =
      await _dashboardService
          .getStats(token);

    } finally {

      isLoading = false;

      notifyListeners();
    }
  }
}