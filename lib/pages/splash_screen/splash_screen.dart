import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/login_screen/index.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.mode_edit),
                const SizedBox(
                  height: 12.0,
                ),
                Text('ToDo Splash Screen'),
                const SizedBox(
                  height: 12.0,
                ),
                InkWell(
                  child: CircularProgressIndicator(),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      LoginScreen.routeName,
                      arguments: LoginScreen(
                        title: 'ToDo',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
