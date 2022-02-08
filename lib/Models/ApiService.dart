import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart';

import 'Todo.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final String url = 'https://localhost:5001/api/Tasks';

  Future<List<todo>> getPosts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<todo> posts = body
          .map(
            (dynamic item) => todo.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
