import 'package:go_router/go_router.dart';

import '../screens/auth/login_screen.dart';

import '../screens/auth/register_screen.dart';

import '../screens/home/home_screen.dart';

import '../screens/splash/splash_screen.dart';

import '../screens/tasks/task_list_screen.dart';

import '../screens/tasks/create_task_screen.dart';

import '../screens/tasks/task_detail_screen.dart';

import '../screens/main/main_navigation_screen.dart';

final GoRouter appRouter = GoRouter(

  initialLocation: '/',

  routes: [

    GoRoute(

      path: '/',

      builder: (context, state) =>
      const SplashScreen(),
    ),

    GoRoute(

      path: '/login',

      builder: (context, state) =>
      const LoginScreen(),
    ),

    GoRoute(

      path: '/register',

      builder: (context, state) =>
      const RegisterScreen(),
    ),

    GoRoute(

      path: '/home',

      builder: (context, state) =>
      const MainNavigationScreen(),
    ),

    GoRoute(

      path: '/tasks',

      builder: (context, state) =>
      const TaskListScreen(),
    ),

    GoRoute(

      path: '/create-task',

      builder: (context, state) =>
      const CreateTaskScreen(),
    ),
  ],
);