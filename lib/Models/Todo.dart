import 'package:flutter/src/foundation/key.dart';
import 'package:todo_list_flutter/main.dart';

class Todo extends MyStatefulWidget {
  Todo({
    required this.name,
    required this.taskdate,
    required this.status,
    required this.id,
  });

  final String name;
  DateTime taskdate;
  Status status;
  String id;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        name: json["title"],
        taskdate: DateTime.parse(json["dueDate"]),
        status: json["status"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": name,
        "dueDate": taskdate.toIso8601String(),
        "status": status,
        "id": id,
      };
}
