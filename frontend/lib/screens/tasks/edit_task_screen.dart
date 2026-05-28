import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../models/task_model.dart';
import '../../providers/task_provider.dart';

class EditTaskScreen extends StatefulWidget {

  final TaskModel task;

  const EditTaskScreen({

    super.key,

    required this.task,
  });

  @override
  State<EditTaskScreen> createState() =>
      _EditTaskScreenState();
}

class _EditTaskScreenState
    extends State<EditTaskScreen> {

  final _formKey =
  GlobalKey<FormState>();

  late TextEditingController
  titleController;

  late TextEditingController
  descriptionController;

  @override
  void initState() {

    super.initState();

    titleController =
        TextEditingController(
          text: widget.task.title,
        );

    descriptionController =
        TextEditingController(
          text: widget.task.description,
        );
  }

  @override
  void dispose() {

    titleController.dispose();

    descriptionController.dispose();

    super.dispose();
  }

  Future<void> updateTask() async {

    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    try {

      await context
          .read<TaskProvider>()
          .updateTask(

        taskId:
        widget.task.id,

        title:
        titleController.text
            .trim(),

        description:
        descriptionController
            .text
            .trim(),

        dueDate:
        widget.task.dueDate,

        subjectId:
        widget.task.subjectId,

        categoryId:
        widget.task.categoryId,

        priorityId:
        widget.task.priorityId,

        statusId:
        widget.task.statusId,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            'Task updated successfully',
          ),
        ),
      );

      context.pop();

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content:
          Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
        const Text('Edit Task'),
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(20),

        child: Form(

          key: _formKey,

          child: Column(

            children: [

              TextFormField(

                controller:
                titleController,

                decoration:
                const InputDecoration(
                  labelText: 'Title',
                ),

                validator: (value) {

                  if (value == null ||
                      value.trim().isEmpty) {

                    return 'Title is required';
                  }

                  if (value.length < 3) {

                    return 'Minimum 3 characters';
                  }

                  return null;
                },
              ),

              const SizedBox(
                height: 20,
              ),

              TextFormField(

                controller:
                descriptionController,

                decoration:
                const InputDecoration(
                  labelText:
                  'Description',
                ),

                maxLines: 3,

                validator: (value) {

                  if (value == null ||
                      value.trim().isEmpty) {

                    return 'Description is required';
                  }

                  if (value.length < 3) {

                    return 'Minimum 3 characters';
                  }

                  return null;
                },
              ),

              const SizedBox(
                height: 40,
              ),

              SizedBox(

                width:
                double.infinity,

                child:
                ElevatedButton(

                  onPressed:
                  updateTask,

                  child:
                  const Text(
                    'Update Task',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}