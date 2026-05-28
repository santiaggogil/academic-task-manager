import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';

import 'routes/app_router.dart';

import 'core/theme/app_theme.dart';

import 'providers/task_provider.dart';

import 'providers/dashboard_provider.dart';

void main() {

  runApp(
    MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => TaskProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => DashboardProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(

      debugShowCheckedModeBanner: false,

      title: 'Academic Task Manager',

      theme: AppTheme.lightTheme,

      routerConfig: appRouter,
    );
  }
}