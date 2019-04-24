import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/config.dart';
import 'package:flutter_todo/pages/home_screen/widgets/list_widget.dart';
import 'package:flutter_todo/pages/login_screen/index.dart';
import 'package:flutter_todo/repository/user_repository.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LoginScreenBloc _loginScreenBloc;


  @override
  Widget build(BuildContext context) {
    _loginScreenBloc = LoginScreenBloc(
      userRepository: UserRepository(
        config: ConfigWrapper.of(context),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _loginScreenBloc.dispatch(UnauthenticateUser());
            },
          )
        ],
      ),
      body: BlocListener(
        bloc: _loginScreenBloc,
        listener: (BuildContext context, LoginScreenState state) {
          if (state is Unauthenticated) {
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          } else {
            print('UnauthFailed');
          }
        },
        child: ListWidget(),
      ),
    );
  }
}
