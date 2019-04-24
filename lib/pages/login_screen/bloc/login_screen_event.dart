import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class LoginScreenEvent extends Equatable {
  LoginScreenEvent([List props = const []]) : super(props);
}

class AuthenticateUser extends LoginScreenEvent {
  AuthenticateUser({
    @required this.username,
    @required this.password,
  }) : super([username, password]);

  final String username;
  final String password;

  @override
  String toString() =>
      'AuthenticateUser { username: $username, password: $password }';
}

class UnauthenticateUser extends LoginScreenEvent {
  @override
  String toString() => 'UnauthenticateUser';
}
