import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/config.dart';
import 'package:flutter_todo/pages/home_screen/index.dart';

import 'package:flutter_todo/pages/init_app/index.dart';
import 'package:flutter_todo/pages/login_screen/index.dart';
import 'package:flutter_todo/pages/splash_screen/index.dart';

import 'package:flutter_todo/repository/user_repository.dart';

class InitApp extends StatefulWidget {
  InitApp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _InitAppState createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> {
  InitAppBloc _initAppBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _initAppBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _initAppBloc = InitAppBloc(
      userRepository: UserRepository(config: ConfigWrapper.of(context)),
    );
    _initAppBloc.dispatch(AppStarted());

    return BlocProvider<InitAppBloc>(
      bloc: _initAppBloc,
      child: BlocBuilder(
        bloc: _initAppBloc,
        builder: (BuildContext context, InitAppState state) {
          if (state is UserUninitialized) {
            return SplashScreen();
          } else if (state is UserUnauthenticated) {
            return LoginScreen(
              title: 'Login',
            );
          } else if (state is UserAuthenticated) {
            return HomeScreen();
          } else {
            return Scaffold(
              body: Container(
                child: Center(
                  child: Text('Something went wrong'),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
