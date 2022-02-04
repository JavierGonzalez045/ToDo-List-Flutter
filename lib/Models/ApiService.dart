import 'dart:convert';
import 'dart:async';
import 'Todo.dart';
import 'package:http/http.dart' as http;

Future<Todo> getTodo() async {
  final response = await http.get(Uri.parse('https://localhost:5001/api'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Todo.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
