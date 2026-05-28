import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class SplashScreen
    extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {

  @override
  void initState() {

    super.initState();

    checkLogin();
  }

  Future<void> checkLogin() async {

    final authProvider =
    context.read<AuthProvider>();

    await authProvider.loadToken();

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    if (authProvider.isAuthenticated) {

      context.go('/home');

    } else {

      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: const [

            Icon(
              Icons.school,
              size: 100,
              color: Colors.indigo,
            ),

            SizedBox(height: 20),

            Text(

              'Academic Task Manager',

              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 40),

            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}