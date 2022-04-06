import 'package:flutter/material.dart';
import 'package:task_manager/screens/notescreens.dart';
import 'package:task_manager/screens/registrationscreen.dart';
import 'package:task_manager/screens/add_task_.dart';
import 'package:task_manager/screens/all_task.dart';
import 'package:task_manager/screens/homscreen.dart';
import 'package:task_manager/screens/loginscreen.dart';

class RouteManager {
  static const String homescreen = '/';
  static const String loginscreen = '/homescreen';
  static const String addtaskscreen = '/loginscreen';
  static const String registrationscreen = '/loginscreen/regitrationscreen';
  static const String alltaskscreen = '//homescreen';
  static const String notescreen = '/homescreen/notescreen';
  static Route<dynamic> generateroute(RouteSettings settings) {
    switch (settings.name) {
      case homescreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case loginscreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case registrationscreen:
        return MaterialPageRoute(
            builder: (context) => const RegistrationScreen());
      case addtaskscreen:
        return MaterialPageRoute(builder: (context) => const AddTaskScreen());
      case alltaskscreen:
        return MaterialPageRoute(builder: (context) => const AllTaskScreen());
      case notescreen:
        return MaterialPageRoute(builder: (context) => const NoteScreen());
      default:
        throw const FormatException(
          'Route not found! check Route folder again',
        );
    }
  }
}
