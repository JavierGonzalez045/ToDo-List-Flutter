// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo_list_flutter/models/ApiService.dart';
import 'package:http/http.dart' as http;

enum Status { pending, canceled, completed }
void main() => runApp(const TodoApp());

// ignore: must_be_immutable
class Todo extends MyStatefulWidget {
  Todo(
      {Key? key,
      required this.name,
      required this.taskdate,
      required this.status,
      required this.button})
      : super(key: key);
  final String name;
  DateTime taskdate;
  Status status;
  bool button;
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  static const String _title = 'ToDo-List';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(brightness: Brightness.light),
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
              fontFamily: "Sans-serif",
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
              } else if (value.length >= 20) {
                return 'Maximun characters length exceeded';
              }
              var isExist = false;
              for (var todos in todos) {
                if (todos.name == myController.text) {
                  isExist = true;
                }
              }

              if (isExist) {
                return 'Same name task';
              }
              return null;
            },
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 5.0)),
          Text(
            'Insert Due Date:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              fontFamily: "Sans-serif",
            ),
          ),
          Text(
              taskdate.day.toString() +
                  '/' +
                  taskdate.month.toString() +
                  '/' +
                  taskdate.year.toString(),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  fontFamily: "Sans-serif")),
          IconButton(
              icon: const Icon(Icons.calendar_today),
              tooltip: 'Due Date',
              onPressed: () => _selectDate(context)),
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
                            Text(todos[index].status.name,
                                style: TextStyle(fontSize: 18)),
                            Spacer(flex: 3),
                            ElevatedButton(
                                onPressed: todos[index].button
                                    ? () {
                                        canceledTask(myController.text, index);
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                                child: Text('Canceled')),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                            ),
                            ElevatedButton(
                                onPressed: todos[index].button
                                    ? () {
                                        completedTask(myController.text, index);
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green),
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

  _addTodoItem(String name) {
    setState(() {
      todos.add(Todo(
        name: name,
        taskdate: taskdate,
        status: Status.pending,
        button: true,
      ));
    });
    myController.clear();
  }

  completedTask(String name, int index) {
    setState(() {
      todos[index].status = Status.completed;
      todos[index].button = false;
    });
  }

  canceledTask(String name, int index) {
    setState(() {
      todos[index].status = Status.canceled;
      todos[index].button = false;
    });
  }
}
