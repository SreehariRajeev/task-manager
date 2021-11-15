class TaskModel {
  TaskModel({
    this.taskTitle,
    this.subtaskList,
  });

  String? taskTitle;
  List<SubtaskList>? subtaskList;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        taskTitle: json["task-title"],
        subtaskList: List<SubtaskList>.from(
            json["subtask-list"].map((x) => SubtaskList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "task-title": taskTitle,
        "subtask-list": List<dynamic>.from(subtaskList!.map((x) => x.toJson())),
      };
}

class SubtaskList {
  SubtaskList({
    this.subtaskTitle,
    this.subtaskDetail,
    this.subtaskStart,
    this.subtaskEnd,
  });

  String? subtaskTitle;
  String? subtaskDetail;
  DateTime? subtaskStart;
  DateTime? subtaskEnd;

  factory SubtaskList.fromJson(Map<String, dynamic> json) => SubtaskList(
        subtaskTitle: json["subtask-title"],
        subtaskDetail: json["subtask-detail"],
        subtaskStart: DateTime.parse(json["subtask-start"]),
        subtaskEnd: DateTime.parse(json["subtask-end"]),
      );

  Map<String, dynamic> toJson() => {
        "subtask-title": subtaskTitle,
        "subtask-detail": subtaskDetail,
        "subtask-start": subtaskStart!.toIso8601String(),
        "subtask-end": subtaskEnd!.toIso8601String(),
      };
}
