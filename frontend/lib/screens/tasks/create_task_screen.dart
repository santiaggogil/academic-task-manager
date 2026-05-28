import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/task_provider.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() =>
      _CreateTaskScreenState();
}

class _CreateTaskScreenState
    extends State<CreateTaskScreen> {

  final _formKey = GlobalKey<FormState>();

  final titleController =
  TextEditingController();

  final descriptionController =
  TextEditingController();

  final dueDateController =
  TextEditingController();

  int subjectId = 1;
  int categoryId = 1;
  int priorityId = 1;
  int statusId = 1;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dueDateController.dispose();
    super.dispose();
  }

  Future<void> createTask() async {

    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    try {

      await context
          .read<TaskProvider>()
          .createTask(

        title:
        titleController.text.trim(),

        description:
        descriptionController.text
            .trim(),

        dueDate:
        dueDateController.text.trim(),

        subjectId: subjectId,

        categoryId: categoryId,

        priorityId: priorityId,

        statusId: statusId,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            'Task created successfully',
          ),
        ),
      );

      context.go('/tasks');

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

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
          'Create Task',
        ),
      ),

      body: SingleChildScrollView(

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
                      value
                          .trim()
                          .isEmpty) {

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
                      value
                          .trim()
                          .isEmpty) {

                    return 'Description is required';
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
                dueDateController,

                decoration:
                const InputDecoration(
                  labelText:
                  'Due Date (YYYY-MM-DD)',
                ),

                validator: (value) {

                  if (value == null ||
                      value.trim().isEmpty) {

                    return 'Due date is required';
                  }

                  final regex = RegExp(
                    r'^\d{4}-\d{2}-\d{2}$',
                  );

                  if (!regex.hasMatch(value)) {

                    return 'Format: YYYY-MM-DD';
                  }

                  return null;
                },
              ),

              const SizedBox(
                height: 20,
              ),

              DropdownButtonFormField<int>(

                value: subjectId,

                decoration:
                const InputDecoration(
                  labelText: 'Subject',
                ),

                items: const [

                  DropdownMenuItem(
                    value: 1,
                    child: Text('Math'),
                  ),

                  DropdownMenuItem(
                    value: 2,
                    child:
                    Text('Programming'),
                  ),
                ],

                onChanged: (value) {

                  setState(() {
                    subjectId = value!;
                  });
                },
              ),

              const SizedBox(
                height: 20,
              ),

              DropdownButtonFormField<int>(

                value: categoryId,

                decoration:
                const InputDecoration(
                  labelText:
                  'Category',
                ),

                items: const [

                  DropdownMenuItem(
                    value: 1,
                    child:
                    Text('Homework'),
                  ),

                  DropdownMenuItem(
                    value: 2,
                    child: Text('Exam'),
                  ),
                ],

                onChanged: (value) {

                  setState(() {
                    categoryId = value!;
                  });
                },
              ),

              const SizedBox(
                height: 20,
              ),

              DropdownButtonFormField<int>(

                value: priorityId,

                decoration:
                const InputDecoration(
                  labelText:
                  'Priority',
                ),

                items: const [

                  DropdownMenuItem(
                    value: 1,
                    child: Text('Low'),
                  ),

                  DropdownMenuItem(
                    value: 2,
                    child:
                    Text('Medium'),
                  ),

                  DropdownMenuItem(
                    value: 3,
                    child: Text('High'),
                  ),
                ],

                onChanged: (value) {

                  setState(() {
                    priorityId = value!;
                  });
                },
              ),

              const SizedBox(
                height: 20,
              ),

              DropdownButtonFormField<int>(

                value: statusId,

                decoration:
                const InputDecoration(
                  labelText:
                  'Status',
                ),

                items: const [

                  DropdownMenuItem(
                    value: 1,
                    child:
                    Text('Pending'),
                  ),

                  DropdownMenuItem(
                    value: 2,
                    child:
                    Text('In Progress'),
                  ),

                  DropdownMenuItem(
                    value: 3,
                    child:
                    Text('Completed'),
                  ),
                ],

                onChanged: (value) {

                  setState(() {
                    statusId = value!;
                  });
                },
              ),

              const SizedBox(
                height: 40,
              ),

              SizedBox(

                width:
                double.infinity,

                child: ElevatedButton(

                  onPressed:
                  createTask,

                  child:
                  const Text(
                    'Create Task',
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