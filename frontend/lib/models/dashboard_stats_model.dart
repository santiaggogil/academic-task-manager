class DashboardStatsModel {

  final int totalTasks;

  final int pendingTasks;

  final int completedTasks;

  DashboardStatsModel({

    required this.totalTasks,

    required this.pendingTasks,

    required this.completedTasks,
  });

  factory DashboardStatsModel.fromJson(
      Map<String,dynamic> json,
      ){

    return DashboardStatsModel(

      totalTasks:
      json['total_tasks'] ?? 0,

      pendingTasks:
      json['pending_tasks'] ?? 0,

      completedTasks:
      json['completed_tasks'] ?? 0,
    );
  }

  double get completionRate {

    if(totalTasks == 0){
      return 0;
    }

    return completedTasks / totalTasks;
  }

  int get completionPercentage {

    if(totalTasks == 0){
      return 0;
    }

    return (
        (completedTasks / totalTasks) * 100
    ).round();
  }
}