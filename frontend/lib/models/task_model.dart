class TaskModel {

  final int id;

  final String title;

  final String description;

  final String dueDate;

  final int subjectId;

  final int categoryId;

  final int priorityId;

  final int statusId;

  final String subjectName;

  final String categoryName;

  final String priorityName;

  final String statusName;

  TaskModel({

    required this.id,

    required this.title,

    required this.description,

    required this.dueDate,

    required this.subjectId,

    required this.categoryId,

    required this.priorityId,

    required this.statusId,

    required this.subjectName,

    required this.categoryName,

    required this.priorityName,

    required this.statusName,
  });

  factory TaskModel.fromJson(
      Map<String, dynamic> json) {

    return TaskModel(

      id: json['id'] ?? 0,

      title: json['title'] ?? '',

      description:
      json['description'] ?? '',

      dueDate:
      json['due_date'] ?? '',

      subjectId:
      json['subject_id'] ?? 0,

      categoryId:
      json['category_id'] ?? 0,

      priorityId:
      json['priority_id'] ?? 0,

      statusId:
      json['status_id'] ?? 0,

      subjectName:
      json['subject']['name'] ?? '',

      categoryName:
      json['category']['name'] ?? '',

      priorityName:
      json['priority']['name'] ?? '',

      statusName:
      json['status']['name'] ?? '',
    );
  }
}