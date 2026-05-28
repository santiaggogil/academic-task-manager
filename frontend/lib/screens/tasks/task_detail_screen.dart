import 'package:flutter/material.dart';

import '../../models/task_model.dart';

import 'package:go_router/go_router.dart';

class TaskDetailScreen
    extends StatelessWidget {

  final TaskModel task;

  const TaskDetailScreen({

    super.key,

    required this.task,
  });

  @override
  Widget build(BuildContext context) {

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
          'Task Detail',
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Text(

              task.title,

              style: const TextStyle(

                fontSize: 32,

                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(

              task.description,

              style:
              const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 30),

            buildInfo(
              'Due Date',
              task.dueDate,
            ),

            buildInfo(
              'Subject ID',
              '${task.subjectId}',
            ),

            buildInfo(
              'Category ID',
              '${task.categoryId}',
            ),

            buildInfo(
              'Priority ID',
              '${task.priorityId}',
            ),

            buildInfo(
              'Status ID',
              '${task.statusId}',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfo(
      String title,
      String value,
      ) {

    return Padding(

      padding:
      const EdgeInsets.only(
        bottom: 16,
      ),

      child: Row(

        children: [

          Text(

            '$title: ',

            style: const TextStyle(

              fontWeight:
              FontWeight.bold,

              fontSize: 18,
            ),
          ),

          Text(
            value,
            style:
            const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}