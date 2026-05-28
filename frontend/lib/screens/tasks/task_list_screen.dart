import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/task_provider.dart';
import '../../widgets/task_card.dart';

import 'task_detail_screen.dart';
import 'edit_task_screen.dart';

import 'package:go_router/go_router.dart';

class TaskListScreen
    extends StatefulWidget {

  const TaskListScreen({
    super.key,
  });

  @override
  State<TaskListScreen> createState() =>
      _TaskListScreenState();
}

class _TaskListScreenState
    extends State<TaskListScreen> {

  @override
  void initState() {

    super.initState();

    Future.microtask(() {

      context
          .read<TaskProvider>()
          .loadTasks();
    });
  }

  Future<void> confirmDelete(
      int taskId) async {

    final provider =
    context.read<TaskProvider>();

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          title: const Text(
            'Delete Task',
          ),

          content: const Text(
            'Are you sure you want to delete this task?',
          ),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(
                  context,
                );
              },

              child:
              const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(

              onPressed:
                  () async {

                Navigator.pop(
                  context,
                );

                await provider
                    .deleteTask(
                  taskId,
                );

                if (!mounted)
                  return;

                ScaffoldMessenger
                    .of(
                  context,
                )
                    .showSnackBar(

                  const SnackBar(

                    content: Text(
                      'Task deleted successfully',
                    ),
                  ),
                );
              },

              child:
              const Text(
                'Delete',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final provider =
    context.watch<TaskProvider>();

    return Scaffold(

      appBar: AppBar(

        leading: IconButton(

          icon: const Icon(
            Icons.arrow_back,
          ),

          onPressed: () {

            context.go('/home');
          },
        ),

        title: const Text(
          'Tasks',
        ),
      ),

      body: Column(

        children: [

          Padding(

            padding:
            const EdgeInsets
                .all(16),

            child: TextField(

              decoration:
              const InputDecoration(

                hintText:
                'Search tasks',

                prefixIcon:
                Icon(
                  Icons.search,
                ),
              ),

              onChanged:
                  (value) {

                provider
                    .updateSearch(
                  value,
                );
              },
            ),
          ),

          Padding(

            padding:
            const EdgeInsets
                .symmetric(
              horizontal: 16,
            ),

            child:
            DropdownButtonFormField<
                String>(

              value: provider
                  .statusFilter,

              items: const [

                DropdownMenuItem(
                  value: 'All',
                  child:
                  Text('All'),
                ),

                DropdownMenuItem(
                  value:
                  'Pending',
                  child:
                  Text(
                    'Pending',
                  ),
                ),

                DropdownMenuItem(
                  value:
                  'Completed',
                  child:
                  Text(
                    'Completed',
                  ),
                ),
              ],

              onChanged:
                  (value) {

                if (value !=
                    null) {

                  provider
                      .updateStatus(
                    value,
                  );
                }
              },
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          Expanded(

            child:
            provider.isLoading

                ? const Center(
              child:
              CircularProgressIndicator(),
            )

                : provider
                .tasks
                .isEmpty

                ? const Center(
              child:
              Text(
                'No tasks found',
              ),
            )

                : ListView
                .builder(

              itemCount:
              provider
                  .tasks
                  .length,

              itemBuilder:
                  (
                  context,
                  index,
                  ) {

                final task =
                provider.tasks[
                index];

                return TaskCard(

                  task:
                  task,

                  onTap:
                      () {

                    Navigator
                        .push(

                      context,

                      MaterialPageRoute(

                        builder:
                            (_) =>
                            TaskDetailScreen(
                              task:
                              task,
                            ),
                      ),
                    );
                  },

                  onEdit:
                      () {

                    Navigator
                        .push(

                      context,

                      MaterialPageRoute(

                        builder:
                            (_) =>
                            EditTaskScreen(
                              task:
                              task,
                            ),
                      ),
                    );
                  },

                  onDelete:
                      () {

                    confirmDelete(
                      task.id,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}