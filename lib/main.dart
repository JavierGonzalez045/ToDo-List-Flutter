// ignore_for_file: prefer_const_constructors

import 'dart:html';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';

class Todos {
  Todos({required this.name, required this.checked});
  final String name;
  bool checked;
}

// class TodoItem extends StatelessWidget {
//  TodoItem({
//     required this.todos,
//     required this.onTodoChanged,
//   }) : super(key: ObjectKey(todos));

//   final Todos todos;
//   final onTodoChanged;
// }

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  static const String _title = 'ToDo-List';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController myController = TextEditingController();
  final List<Todos> _todos = <Todos>[];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Insert Task Name",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              fontFamily: "Georgia",
            ),
          ),
          TextFormField(
            controller: myController,
            decoration: const InputDecoration(
              hintText: 'Insert Task',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              } else if (value.startsWith(' ')) {
                return 'Please enter valid text';
              }
              return null;
            },
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () => Text(this.myController.toString())
                  // Validate returns true if the form is valid, or false otherwise.
                  ))
        ],
      ),
    );
  }

  void _addTodoItem(String name) {
    setState(() {
      if (_formKey.currentState!.validate()) {
        // If the form is valid, display a snackbar. In the real world,
        // you'd often call a server or save the information in a database.
      }
      myController.value;
      //_todos.add(Todos(name: name, checked: false));
    });
    myController.clear();
  }
}
