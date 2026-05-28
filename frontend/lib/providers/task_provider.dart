import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../services/task_service.dart';

class TaskProvider extends ChangeNotifier {

  final TaskService _taskService = TaskService();

  List<TaskModel> tasks = [];

  bool isLoading = false;

  String searchQuery = '';

  String statusFilter = 'All';

  Future<void> loadTasks() async {

    isLoading = true;

    notifyListeners();

    try {

      final data = await _taskService.getTasks(
        search: searchQuery,
        status: statusFilter,
      );

      tasks = data
          .map<TaskModel>(
            (task) => TaskModel.fromJson(task),
      )
          .toList();

    } catch (e) {

      debugPrint(
        'Error loading tasks: $e',
      );

    } finally {

      isLoading = false;

      notifyListeners();
    }
  }

  Future<void> updateSearch(
      String value) async {

    searchQuery = value;

    await loadTasks();
  }

  Future<void> updateStatus(
      String value) async {

    statusFilter = value;

    await loadTasks();
  }

  Future<void> createTask({

    required String title,

    required String description,

    required String dueDate,

    required int subjectId,

    required int categoryId,

    required int priorityId,

    required int statusId,

  }) async {

    await _taskService.createTask(

      title: title,

      description: description,

      dueDate: dueDate,

      subjectId: subjectId,

      categoryId: categoryId,

      priorityId: priorityId,

      statusId: statusId,
    );

    await loadTasks();
  }

  Future<void> updateTask({

    required int taskId,

    required String title,

    required String description,

    required String dueDate,

    required int subjectId,

    required int categoryId,

    required int priorityId,

    required int statusId,

  }) async {

    await _taskService.updateTask(

      taskId: taskId,

      title: title,

      description: description,

      dueDate: dueDate,

      subjectId: subjectId,

      categoryId: categoryId,

      priorityId: priorityId,

      statusId: statusId,
    );

    await loadTasks();
  }

  Future<void> deleteTask(
      int taskId) async {

    await _taskService.deleteTask(
      taskId,
    );

    await loadTasks();
  }
}