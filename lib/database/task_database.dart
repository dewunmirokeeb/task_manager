// ignore_for_file: prefer_const_declarations

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/models/user.dart';

class TaskDataBase {
  static final TaskDataBase instance = TaskDataBase._initialize();
  static Database? _database;
  TaskDataBase._initialize();

  Future _createDB(Database db, int version) async {
    final userusernametype = 'Text primary key not null';
    final texttype = 'Text Not Null';
    final booltype = 'Bool not null';

    await db.execute('''CREATE TABLE $usertable (
      ${UserFields.username} $userusernametype,
      ${UserFields.name} $texttype
    )''');

    await db.execute('''CREATE TABLE $tasktable (
      ${TaskField.username} $texttype,
      ${TaskField.taskname} $texttype,
      ${TaskField.taskdetails} $booltype,
      ${TaskField.created} $texttype,
      FOREIGN KEY (${TaskField.username}) REFERENCES $usertable (${UserFields.username})
    )''');
  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<Database> _initDB(String filename) async {
    final databasepath = await getDatabasesPath();
    final path = join(databasepath, filename);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: _onConfigure,
    );
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDB('todo.db');
      return _database;
    }
  }

  Future<User> createuser(User user) async {
    final db = await instance.database;
    await db!.insert(usertable, user.tojson());
    return user;
  }

  Future<User> getUser(String username) async {
    final db = await instance.database;
    final maps = await db!.query(
      usertable,
      columns: UserFields.allFields,
      where: '${UserFields.username} = ?',
      whereArgs: [username],
    );
    if (maps.isNotEmpty) {
      return User.fromjson(maps.first);
    } else {
      throw Exception('$username not found in the data base.');
    }
  }

  Future<List<User>> getAllUsers() async {
    final db = await instance.database;
    final results = await db!.query(
      usertable,
      orderBy: '${UserFields.username} ASC',
    );
    return results.map((e) => User.fromjson(e)).toList();
  }

  Future<int> updateUser(User user) async {
    final db = await instance.database;
    return db!.update(
      usertable,
      user.tojson(),
      where: '${UserFields.username} = ?',
      whereArgs: [user.username],
    );
  }

  Future<int> deleteUser(String username) async {
    final db = await instance.database;
    return db!.delete(
      usertable,
      where: '${UserFields.username} = ?',
      whereArgs: [username],
    );
  }

  Future<Task> createTask(Task task, String table) async {
    final db = await instance.database;
    await db!.insert(
      table,
      task.tojson(),
    );
    return task;
  }

  Future<List<Task>> gettask(String username, String table) async {
    final db = await instance.database;
    final result = await db!.query(
      table,
      orderBy: '${TaskField.created} DESC',
      where: '${TaskField.taskname} = ?',
      whereArgs: [username],
    );
    return result.map((e) => Task.fromjson(e)).toList();
  }

  Future<int> deleteTask(Task task, String table) async {
    final db = await instance.database;
    return db!.delete(
      table,
      where: '${TaskField.taskname} = ? AND ${TaskField.username} = ?',
      whereArgs: [task.taskname, task.username],
    );
  }
}
