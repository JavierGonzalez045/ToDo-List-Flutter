// ignore_for_file: prefer_const_constructors

import 'dart:html';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';

class Todos {
  Todos({
    required this.name,
  });
  final String name;
}

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
  TextEditingController myController = TextEditingController();
  List<Todos> todos = <Todos>[];
  DateTime date = DateTime.now();
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
          Text(
            "Insert Due Date",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              fontFamily: "Georgia",
            ),
          ),
          ElevatedButton(
              child: Text('select date'), onPressed: selectTimePicker(context)),
          Text(date.day.toString()),
          Text(date.month.toString()),
          Text(date.year.toString()),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addTodoItem();
                  }
                },
                // Validate returns true if the form is valid, or false otherwise.
              )),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: todos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      margin: EdgeInsets.all(2),
                      child: Center(
                          child: Text(
                        '${todos[index]}',
                        style: TextStyle(fontSize: 18),
                      )),
                    );
                  }))
        ],
      ),
    );
  }

  selectTimePicker(BuildContext context) {
    Future<Null> selectTimePicker(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(1940),
          lastDate: DateTime(2030));
      if (picked != null && picked != date) {
        setState(() {
          date = picked;
          print(date.toString());
        });
      }
    }
  }

  void _addTodoItem() {
    setState(() {
      todos.add(Todos(name: myController.text));
      todos.map((todos) => Todos(name: myController.text)).toList();
      //todos.insert(0,myController.value);
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
    }

        //_todos.add(Todos(name: name, checked: false));

        );
  }
}
