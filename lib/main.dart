import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/route/routemanager.dart';
import 'package:task_manager/services/task_service.dart';
import 'package:task_manager/services/user_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => UserService()),
        ),
        ChangeNotifierProvider(
          create: ((context) => TaskService()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rokeeb\'s Flutter portfolio app 1',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RouteManager.loginscreen,
        onGenerateRoute: RouteManager.generateroute,
      ),
    );
  }
}
