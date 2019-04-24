import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/home_screen/index.dart';
import 'package:flutter_todo/pages/init_app/index.dart';
import 'package:flutter_todo/pages/login_screen/index.dart';
import 'package:flutter_todo/pages/splash_screen/index.dart';

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InitApp(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        SplashScreen.routeName: (BuildContext context) => SplashScreen(),
        LoginScreen.routeName: (BuildContext context) =>
            LoginScreen(title: 'ToDo'),
        HomeScreen.routeName: (BuildContext context) => HomeScreen(),
      },
    );
  }
}
