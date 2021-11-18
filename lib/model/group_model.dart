class GroupModel {
  GroupModel({
    required this.group,
  });

  String group;

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        group: json["group"],
      );

  Map<String, dynamic> toJson() => {
        "group": group,
      };
}
