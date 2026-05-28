import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../widgets/dashboard_card.dart';
import '../../widgets/progress_card.dart';

import '../../providers/auth_provider.dart';
import '../../providers/dashboard_provider.dart';
import '../../providers/task_provider.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final authProvider =
    context.read<AuthProvider>();

    final dashboardProvider =
    context.watch<DashboardProvider>();

    final taskProvider =
    context.watch<TaskProvider>();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {

      if (dashboardProvider.stats == null) {

        dashboardProvider.loadStats(
          authProvider.token!,
        );
      }
    });

    WidgetsBinding.instance
        .addPostFrameCallback((_) {

      if (taskProvider.tasks.isEmpty) {

        taskProvider.loadTasks();
      }
    });

    if (dashboardProvider.isLoading) {

      return const Scaffold(

        body: Center(

          child:
          CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Academic Task Manager',
        ),
      ),

      body: SingleChildScrollView(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const Text(

              'Welcome back 👋',

              style: TextStyle(

                fontSize: 28,

                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(

              'Manage your academic tasks efficiently.',

              style: TextStyle(

                fontSize: 16,

                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            DashboardCard(

              title: 'Total Tasks',

              value:
              dashboardProvider
                  .stats
                  ?.totalTasks
                  .toString() ??
                  '0',

              icon:
              Icons.assignment,
            ),

            const SizedBox(height: 15),

            DashboardCard(

              title:
              'Pending Tasks',

              value:
              dashboardProvider
                  .stats
                  ?.pendingTasks
                  .toString() ??
                  '0',

              icon:
              Icons.pending_actions,
            ),

            const SizedBox(height: 15),

            DashboardCard(

              title:
              'Completed Tasks',

              value:
              dashboardProvider
                  .stats
                  ?.completedTasks
                  .toString() ??
                  '0',

              icon:
              Icons.check_circle,
            ),

            const SizedBox(height: 20),

            ProgressCard(

              percentage:
              dashboardProvider
                  .stats
                  ?.completionPercentage ??
                  0,
            ),

            const SizedBox(height: 30),

            const Text(

              'Recent Tasks',

              style: TextStyle(

                fontSize: 20,

                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            if (taskProvider.tasks.isEmpty)

              const Card(

                child: Padding(

                  padding:
                  EdgeInsets.all(20),

                  child: Center(

                    child: Text(
                      'No tasks available',
                    ),
                  ),
                ),
              )

            else

              ListView.builder(

                shrinkWrap: true,

                physics:
                const NeverScrollableScrollPhysics(),

                itemCount:
                taskProvider.tasks.length > 5
                    ? 5
                    : taskProvider.tasks.length,

                itemBuilder:
                    (context, index) {

                  final task =
                  taskProvider.tasks[index];

                  return Card(

                    child: ListTile(

                      leading:
                      const Icon(
                        Icons.task,
                      ),

                      title:
                      Text(
                        task.title,
                      ),

                      subtitle:
                      Text(
                        task.description,
                      ),
                    ),
                  );
                },
              ),

            const SizedBox(height: 30),

            SizedBox(

              width:
              double.infinity,

              child:
              ElevatedButton.icon(

                onPressed: () {

                  context.go(
                    '/tasks',
                  );
                },

                icon:
                const Icon(
                  Icons.list,
                ),

                label:
                const Text(
                  'View Tasks',
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(

              width:
              double.infinity,

              child:
              ElevatedButton.icon(

                onPressed: () {

                  context.go(
                    '/create-task',
                  );
                },

                icon:
                const Icon(
                  Icons.add,
                ),

                label:
                const Text(
                  'Create Task',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}