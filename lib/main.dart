// ignore_for_file: prefer_const_constructors

import 'dart:html';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'task.dart';

enum Status { pending, canceled, completed }

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
  List todos = [];
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
          Text(
            "Insert Due Date",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              fontFamily: "Georgia",
            ),
          ),
          ElevatedButton(
              child: Text('select date'),
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
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(100.0)),
                            Text('${todos[index]}' '${taskdate.toString()}',
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

  // selectTimePicker(BuildContext context) {
  //   Future<Null> selectTimePicker(BuildContext context) async {
  //     final DateTime? picked = await showDatePicker(
  //         context: context,
  //         initialDate: date,
  //         firstDate: DateTime(1940),
  //         lastDate: DateTime(2030));
  //     if (picked != null && picked != date) {
  //       setState(() {
  //         date = picked;
  //         print(date.toString());
  //       });
  //     }
  //   }
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: taskdate, // Refer step 1
      firstDate: DateTime(2000), // Required
      lastDate: DateTime(2025), // Required
    );
    if (picked != null && picked != taskdate) {
      setState(() {
        taskdate = picked;
      });
    }
  }

  void _addTodoItem() {
    setState(() {
      todos.insert(0, myController.text);
      //todos.map((todos) => Todos(name: myController.toString())).toList();
      //todos.insert(0,myController.value);
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
