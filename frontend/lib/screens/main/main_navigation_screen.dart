import 'package:flutter/material.dart';

import '../home/home_screen.dart';

import '../tasks/task_list_screen.dart';

import '../tasks/create_task_screen.dart';

import '../profile/profile_screen.dart';

class MainNavigationScreen
    extends StatefulWidget {

  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState
    extends State<MainNavigationScreen> {

  int currentIndex = 0;

  final List<Widget> screens = [

    const HomeScreen(),

    const TaskListScreen(),

    const CreateTaskScreen(),

    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: screens[currentIndex],

      bottomNavigationBar:
      BottomNavigationBar(

        currentIndex: currentIndex,

        onTap: (index) {

          setState(() {
            currentIndex = index;
          });
        },

        selectedItemColor:
        Colors.indigo,

        unselectedItemColor:
        Colors.grey,

        type:
        BottomNavigationBarType.fixed,

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tasks',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}