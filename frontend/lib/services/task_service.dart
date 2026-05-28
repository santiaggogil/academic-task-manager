import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/api_constants.dart';

class TaskService {

  final Dio _dio = Dio();

  Future<String?> _getToken() async {

    final prefs =
    await SharedPreferences.getInstance();

    return prefs.getString('token');
  }

  Future<List<dynamic>> getTasks({

    String? search,

    String? status,

  }) async {

    final token = await _getToken();

    String url =
        '${ApiConstants.baseUrl}/tasks';

    List<String> queryParams = [];

    if (search != null &&
        search.isNotEmpty) {

      queryParams.add(
        'search=$search',
      );
    }

    if (status != null &&
        status != 'All') {

      queryParams.add(
        'status=$status',
      );
    }

    if (queryParams.isNotEmpty) {

      url += '?${queryParams.join('&')}';
    }

    final response =
    await _dio.get(

      url,

      options: Options(

        headers: {

          'Authorization':
          'Bearer $token',
        },
      ),
    );

    return response.data;
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

    final token = await _getToken();

    await _dio.post(

      '${ApiConstants.baseUrl}/tasks',

      data: {

        'title': title,

        'description': description,

        'due_date': dueDate,

        'subject_id': subjectId,

        'category_id': categoryId,

        'priority_id': priorityId,

        'status_id': statusId,
      },

      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
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

    final token = await _getToken();

    await _dio.put(

      '${ApiConstants.baseUrl}/tasks/$taskId',

      data: {

        'title': title,

        'description': description,

        'due_date': dueDate,

        'subject_id': subjectId,

        'category_id': categoryId,

        'priority_id': priorityId,

        'status_id': statusId,
      },

      options: Options(

        headers: {

          'Authorization':
          'Bearer $token',
        },
      ),
    );
  }

  Future<void> deleteTask(
      int taskId) async {

    final token = await _getToken();

    await _dio.delete(

      '${ApiConstants.baseUrl}/tasks/$taskId',

      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }
}