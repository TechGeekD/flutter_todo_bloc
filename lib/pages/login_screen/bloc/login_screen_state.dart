import 'package:equatable/equatable.dart';

abstract class LoginScreenState extends Equatable {}

class AuthenticationUninitialized extends LoginScreenState {
  @override
  String toString() => 'AuthenticationUninitialized';
}

class AuthenticationSuccess extends LoginScreenState {
  @override
  String toString() => 'AuthenticationSuccess';
}

class AuthenticationFailed extends LoginScreenState {
  @override
  String toString() => 'AuthenticationFailed';
}

class Unauthenticated extends LoginScreenState {
  @override
  String toString() => 'Unauthenticated';
}
