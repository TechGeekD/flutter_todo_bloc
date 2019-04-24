import 'package:meta/meta.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_todo/config.dart';
import 'package:flutter_todo/models/user.dart';

import 'package:flutter_todo/services/api.dart';
import 'package:flutter_todo/services/storage.dart';

class UserRepository {
  UserRepository({
    this.config,
  }) : assert(config != null) {
    this.request = API(config: config).request;
  }

  final Config config;
  dynamic request;
  final Storage storage = Storage();

  Future getUsersList() async {
    List<User> userList;

    final response = await request(method: 'GET', path: '/users');
    userList = UserList.fromJson(response).users;

    await storage.write(key: 'userList', value: userList);

    return userList;
  }

  Future getUserById({@required String userId}) async {
    final response =
        await request(method: 'GET', path: '/users', query: {'id': userId});
    final User userDetails = User.fromJson(response[0]);

    await storage.write(key: 'userDetails', value: userDetails);
    await storage
        .write(key: 'userAuth', value: {'auth': true, 'token': userDetails.id});

    return userDetails;
  }

  Future<bool> hasToken() async {
    await Future.delayed(Duration(seconds: 1));

    final Map<String, dynamic> userAuth = await storage.read('userAuth');

    return userAuth != null ? userAuth.containsValue(true) : false;
  }

  Future authenticateUser({@required String username, @required String password}) async {
    final response = await request(
        method: 'GET',
        path: '/users',
        query: {'username': username, 'id': password});
    final User userDetails = User.fromJson(response[0]);

    await storage.write(key: 'userDetails', value: userDetails);
    await storage
        .write(key: 'userAuth', value: {'auth': true, 'token': userDetails.id});

    return userDetails;
  }

  Future<bool> logoutUser() async {
    await storage.deleteAll();

    return true;
  }
}
