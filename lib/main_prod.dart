import 'package:flutter/material.dart';
import 'package:flutter_todo/config.dart';
import 'package:flutter_todo/env/prod.dart';
import 'package:flutter_todo/main.dart';

void main() {
  runApp(ConfigWrapper(
    config: Config.fromJson(config),
    child: ToDoApp(),
  ));
}
