import 'package:flutter/material.dart';

import 'package:flutter_todo/pages/login_screen/widgets/index.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({this.title});

  static final String routeName = '/login';

  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map<String, String> userCreds = Map();

  @override
  void initState() {
    setState(() {
      userCreds.putIfAbsent('username', () => "");
      userCreds.putIfAbsent('password', () => "");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InputFieldsWidget(userCreds, setUserCreds),
                  ButtonBarWidget(userCreds, setUserCreds),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  setUserCreds(key, update) {
    print(update);
    setState(() {
      this.userCreds[key] = update.toString();
    });
  }
}
