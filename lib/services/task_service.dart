import 'package:flutter/foundation.dart';
import 'package:task_manager/database/task_database.dart';
import 'package:task_manager/models/task.dart';

class TaskService with ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  // void settodoing(
  //   String username,
  // ) async {
  //   _tasks = await TaskDataBase.instance.gettask(username, tasktable);
  // }

  Future<String> gettasks(String username) async {
    try {
      _tasks = await TaskDataBase.instance.gettask(username, tasktable);
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    Future.delayed(const Duration(minutes: 2));
    return 'ok';
  }

  Future<String> deletetask(Task task) async {
    try {
      await TaskDataBase.instance.deleteTask(task, tasktable);
    } catch (e) {
      return e.toString();
    }
    String result = await gettasks(
      task.username,
    );
    return result;
  }

  Future<String> createtask(Task task) async {
    try {
      await TaskDataBase.instance.createTask(task, tasktable);
    } catch (e) {
      return e.toString();
    }
    String result = await gettasks(task.username);
    return result;
  }
}
