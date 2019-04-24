import 'package:flutter/material.dart';
import 'package:flutter_todo/services/storage.dart';
import 'package:flutter_todo/models/user.dart';

class ListWidget extends StatefulWidget {
  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  Map<String, List> toDos = {
    'true': <int>[],
    'false': <int>[],
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Storage().read('userList'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Something Went Wrong');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case ConnectionState.done:
              List<User> data = UserList.fromJson(snapshot.data).users;

              return ListView(
                scrollDirection: Axis.vertical,
                children: data.map(
                  (User user) {
                    return ListTile(
                      leading: Icon(
                        Icons.new_releases,
                        color: Colors.purple,
                      ),
                      title: Text('username: ${user.username}'),
                      trailing: Switch(
                        value: toDos['true'].contains(user.id),
                        onChanged: (bool value) {
                          List trues = toDos['true'];
                          List falses = toDos['false'];
                          setState(() {
                            trues.contains(user.id)
                                ? trues.remove(user.id)
                                : trues.add(user.id);
                            falses.contains(user.id)
                                ? falses.remove(user.id)
                                : falses.add(user.id);
                          });
                        },
                      ),
                    );
                  },
                ).toList(),
              );
          }
        },
      ),
    );
  }
}
