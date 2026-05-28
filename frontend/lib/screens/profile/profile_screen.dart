import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:go_router/go_router.dart';

import '../../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Profile'),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.stretch,

          children: [

            const CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),

            const SizedBox(height: 20),

            const Text(

              'Academic Task Manager',

              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton.icon(

              onPressed: () async {

                await context
                    .read<AuthProvider>()
                    .logout();

                if (!context.mounted) return;

                context.go('/login');
              },

              icon: const Icon(Icons.logout),

              label: const Text(
                'Logout',
              ),

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}