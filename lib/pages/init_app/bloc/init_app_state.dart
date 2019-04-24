import 'package:equatable/equatable.dart';

abstract class InitAppState extends Equatable {}

class UserUninitialized extends InitAppState {
  @override
  String toString() => 'UserUninitialized';
}

class UserAuthenticated extends InitAppState {
  @override
  String toString() => 'UserAuthenticated';
}

class UserUnauthenticated extends InitAppState {
  @override
  String toString() => 'UserUnauthenticated';
}
