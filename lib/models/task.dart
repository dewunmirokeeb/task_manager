import 'package:flutter/rendering.dart';

const String tasktable = 'task';

class TaskField {
  static const String username = 'username';
  static const String taskname = 'task';
  static const String taskdetails = 'taskdetails';
  static const String created = 'created';
  static final List<String> tasks = [
    username,
    taskdetails,
    taskname,
    created,
  ];
}

class Task {
  final String username;
  final String taskname;
  final String taskdetails;
  final DateTime created;

  Task({
    required this.username,
    required this.taskname,
    required this.taskdetails,
    required this.created,
  });

  Map<String, Object?> tojson() => {
        TaskField.username: username,
        TaskField.taskname: taskname,
        TaskField.taskdetails: taskdetails,
        TaskField.created: created.toIso8601String(),
      };

  static Task fromjson(Map<String, Object?> json) => Task(
        username: json[TaskField.username] as String,
        taskname: json[TaskField.taskname] as String,
        taskdetails: json[TaskField.taskdetails] as String,
        created: DateTime.parse(json[TaskField.created] as String),
      );

  @override
  // ignore: avoid_renaming_method_parameters
  bool operator ==(covariant Task task) {
    // ignore: unnecessary_this
    return (this.taskname == task.taskname) &&
        // ignore: unnecessary_this
        (this
                .taskdetails
                .toUpperCase()
                .compareTo(task.taskdetails.toUpperCase()) ==
            0);
  }

  @override
  int get hashCode => hashValues(taskname, taskdetails);
}
