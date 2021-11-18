class TaskModel {
  TaskModel({
    required this.title,
    this.detail,
    this.start,
    this.end,
    required this.isCompleted,
  });

  String title;
  String? detail;
  DateTime? start;
  DateTime? end;
  bool isCompleted;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        title: json["title"],
        detail: json["detail"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        isCompleted: json["isCompleted"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "detail": detail,
        "start": start!.toIso8601String(),
        "end": end!.toIso8601String(),
        "isCompleted": isCompleted,
      };
}
