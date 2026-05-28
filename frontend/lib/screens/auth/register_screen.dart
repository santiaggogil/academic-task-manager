import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {

  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  @override
  void dispose() {

    nameController.dispose();

    emailController.dispose();

    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Register'),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            TextField(

              controller: nameController,

              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),

            const SizedBox(height: 20),

            TextField(

              controller: emailController,

              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),

            const SizedBox(height: 20),

            TextField(

              controller: passwordController,

              obscureText: true,

              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(

              onPressed: () async {

                try {

                  await context
                      .read<AuthProvider>()
                      .register(

                    name:
                    nameController.text,

                    email:
                    emailController.text,

                    password:
                    passwordController.text,
                  );

                  if (!context.mounted) return;

                  context.go('/login');

                } catch (e) {

                  ScaffoldMessenger.of(context)
                      .showSnackBar(

                    SnackBar(
                      content: Text(
                        e.toString(),
                      ),
                    ),
                  );
                }
              },

              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}