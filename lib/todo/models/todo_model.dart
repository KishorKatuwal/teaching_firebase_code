import 'dart:convert';

List<TodoModel> todoModelFromJson(String str) =>
    List<TodoModel>.from(json.decode(str).map((x) => TodoModel.fromJson(x)));

String todoModelToJson(List<TodoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoModel {
  final String userId;
  final String taskName;
  final String taskId;
  final bool isCompleted;

  TodoModel({
    required this.userId,
    required this.taskName,
    required this.taskId,
    required this.isCompleted,
  });

  TodoModel copyWith({
    String? userId,
    String? taskName,
    String? taskId,
    bool? isCompleted,
  }) =>
      TodoModel(
        userId: userId ?? this.userId,
        taskName: taskName ?? this.taskName,
        taskId: taskId ?? this.taskId,
        isCompleted: isCompleted ?? this.isCompleted,
      );

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        userId: json["userId"],
        taskName: json["taskName"],
        taskId: json["taskId"],
        isCompleted: json["isCompleted"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "taskName": taskName,
        "taskId": taskId,
        "isCompleted": isCompleted,
      };
}
