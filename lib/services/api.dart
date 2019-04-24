import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_todo/config.dart';

class API {
  API({this.config}) : assert(config != null);

  final Config config;

  request({
    String method,
    String path,
    Map<String, String> query = const {},
    Map<String, dynamic> data = const {},
    Map<String, String> headers = const {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  }) async {
    final Uri uri = Uri.https(config.apiUrl, path, query);

    print('******** uri ******** $uri');
    final request = http.Request(method.toLowerCase(), uri)
      ..headers.addAll(headers)
      ..body = jsonEncode(data);

    final stream = await request.send().then((onValue) => onValue.stream);

    final response =
        await stream.bytesToString().then((onData) => onData.toString());

    return jsonDecode(response);
  }
}
