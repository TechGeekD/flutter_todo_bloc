import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_todo/config.dart';
import 'package:flutter_todo/models/user.dart';
import 'package:flutter_todo/pages/home_screen/index.dart';
import 'package:flutter_todo/repository/user_repository.dart';

import 'package:flutter_todo/pages/splash_screen/index.dart';
import 'package:flutter_todo/pages/login_screen/bloc/index.dart';

class ButtonBarWidget extends StatefulWidget {
  ButtonBarWidget(this.userCreds, this.setUserCreds);

  final Function setUserCreds;
  final Map<String, String> userCreds;

  @override
  _ButtonBarWidgetState createState() => _ButtonBarWidgetState();
}

class _ButtonBarWidgetState extends State<ButtonBarWidget> {
  Future _getUserList;
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  LoginScreenBloc _loginScreenBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this._getUserList = this._memoizer.runOnce(() async {
      return await UserRepository(config: ConfigWrapper.of(context))
          .getUsersList();
    });

    _loginScreenBloc = LoginScreenBloc(
      userRepository: UserRepository(config: ConfigWrapper.of(context)),
    );

    return BlocListener(
      bloc: _loginScreenBloc,
      listener: (BuildContext context, LoginScreenState state) {
        if (state is AuthenticationSuccess) {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        } else if (state is AuthenticationFailed) {
          print('AuthFailed');
        }
      },
      child: BlocBuilder(
        bloc: _loginScreenBloc,
        builder: (BuildContext context, LoginScreenState state) {
          return ButtonTheme.bar(
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                UserList(context, widget.setUserCreds),
                FlatButton(
                  child: const Text('Register'),
                  onPressed: () {
                    _navigateToSplashScreen(context);
                  },
                ),
                FlatButton(
                  child: const Text('Login'),
                  onPressed: () {
                    _authenticateUser();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget UserList(context, setUserCreds) => FutureBuilder(
        future: _getUserList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case ConnectionState.done:
              final List<User> userList = snapshot.data;

              return DropdownButton<String>(
                hint: Text('Choose a user'),
                items: userList.map(
                  (User value) {
                    return DropdownMenuItem<String>(
                      value: value.id.toString(),
                      child: Text(value.username),
                    );
                  },
                ).toList(),
                onChanged: (newValue) {
                  final user = userList.firstWhere((item) {
                    return item.id.toString() == newValue;
                  });
                  setUserCreds('username', user.username);
                  setUserCreds('password', user.id);
                },
              );
          }
        },
      );

  void _navigateToSplashScreen(BuildContext context) {
    Navigator.pushNamed(context, SplashScreen.routeName);
  }

  void _authenticateUser() {
    _loginScreenBloc.dispatch(AuthenticateUser(
      username: widget.userCreds['username'],
      password: widget.userCreds['password'],
    ));
  }
}
