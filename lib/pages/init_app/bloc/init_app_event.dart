import 'package:equatable/equatable.dart';

abstract class InitAppEvent extends Equatable {
  InitAppEvent([List props = const []]) : super(props);
}

class AppStarted extends InitAppEvent {
  @override
  String toString() => 'AppStarted';
}

