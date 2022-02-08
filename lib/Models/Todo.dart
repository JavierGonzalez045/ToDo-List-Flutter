import 'package:flutter/src/foundation/key.dart';
import 'package:todo_list_flutter/main.dart';
import 'dart:convert';

class todo extends MyStatefulWidget {
  String title;
  DateTime duedate;
  Status status;
  String id;

  todo({
    required this.title,
    required this.duedate,
    required this.status,
    required this.id,
  });

  factory todo.fromJson(Map<String, dynamic> json) {
    return todo(
      title: json['title'] as String,
      duedate: json['duedate'] as DateTime,
      status: json['status'] as Status,
      id: json['id'],
    );
  }
}
  
/* 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['dueDate'] = this.duedate;
    data['status'] = this.status;
    data['id'] = this.id;
    return data;
  }
}
 */