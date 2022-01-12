// ignore_for_file: prefer_const_constructors

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(Todo());
}

class Todo extends StatelessWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome to Flutter',
        home: Scaffold(
            appBar:
                AppBar(title: Text('ToDo-List'), backgroundColor: Colors.grey),
            body:
                Column(crossAxisAlignment: CrossAxisAlignment.start, // grey box
                    children: [
                  Text(
                    "Insert Task Name",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      fontFamily: "Georgia",
                    ),
                  ),
                  TextField(
                      decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term',
                  )),
                  Text(
                    "Insert Date",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      fontFamily: "Georgia",
                    ),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blue, primary: Colors.white),
                      onPressed: () {},
                      child: Text('Text Button'))
                ])));
  }
}
