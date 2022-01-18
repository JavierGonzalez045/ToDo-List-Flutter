// ignore_for_file: prefer_const_constructors

import 'dart:html';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'task.dart';

enum Status { pending, canceled, completed }
void main() => runApp(const TodoApp());

// ignore: must_be_immutable
class Todo extends MyStatefulWidget {
  Todo(
      {Key? key,
      required this.name,
      required this.taskdate,
      required this.status})
      : super(key: key);
  final String name;
  DateTime taskdate;
  Status status;
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  static const String _title = 'ToDo-List';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
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
  final List<Todo> todos = <Todo>[];
  DateTime taskdate = DateTime.now();
  bool buttonenabled = true;

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
          Padding(padding: const EdgeInsets.symmetric(vertical: 5.0)),
          Text(
            'Insert Due Date',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              fontFamily: "Georgia",
            ),
          ),
          IconButton(
              icon: const Icon(Icons.calendar_today),
              tooltip: 'Due Date',
              onPressed: () => _selectDate(context)),
          //  Text(date.day.toString()),
          //  Text(date.month.toString()),
          //  Text(date.year.toString()),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
                child: const Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addTodoItem(myController.text);
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
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(todos[index].name,
                                style: TextStyle(fontSize: 18)),
                            Padding(padding: EdgeInsets.only(left: 20.0)),
                            Text(
                                "${todos[index].taskdate.day}/${todos[index].taskdate.month}/${todos[index].taskdate.year}",
                                style: TextStyle(fontSize: 18)),
                            Padding(padding: EdgeInsets.only(left: 20.0)),
                            Text(todos[index].status.toString(),
                                style: TextStyle(fontSize: 18)),
                            Spacer(flex: 3),
                            ElevatedButton(
                                onPressed: () {
                                  completedTask();
                                },
                                child: Text('Canceled')),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                            ),
                            ElevatedButton(
                                onPressed: buttonenabled ? () {} : null,
                                child: Text('Completed'))
                          ]),
                    );
                  }))
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: taskdate, // Refer step 1
      firstDate: DateTime.now(), // Required
      lastDate: DateTime(2025), // Required
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(), // This will change to dark theme.
          child: child!,
        );
      },
    );
    if (picked != null && picked != taskdate) {
      setState(() {
        taskdate = picked;
      });
    }
  }

  void _addTodoItem(String name) {
    setState(() {
      todos.add(Todo(
        name: name,
        taskdate: taskdate,
        status: Status.pending,
      ));
      //todos.insert(0, myController.text);
      //todos.map((todos) => myController.text).toList();
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
    }

        //_todos.add(Todos(name: name, checked: false));

        );
  }

  void completedTask() {
    setState(() {
      buttonenabled = false;
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
    });
  }
}
