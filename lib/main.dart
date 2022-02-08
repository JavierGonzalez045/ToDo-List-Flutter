import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'Models/Todo.dart';
import 'Models/ApiService.dart';

enum Status { pending, canceled, completed }
void main() => runApp(const TodoApp());

// ignore: must_be_immutable
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
  late Future<todo> futureTodo;
  final HttpService httpService = HttpService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController myController = TextEditingController();
  final List<todo> todos = <todo>[];
  DateTime taskdate = DateTime.now();
  final dateFormate = DateFormat("dd-MM-yyyy");

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
              } else if (value.length >= 20) {
                return 'Maximun characters length exceeded';
              }
              var isExist = false;
              for (var todos in todos) {
                if (todos.title == myController.text) {
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
              fontFamily: "Georgia",
            ),
          ),
          Text(dateFormate.format(taskdate),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  fontFamily: "Georgia")),
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
                            Text(todos[index].title,
                                style: TextStyle(fontSize: 18)),
                            Padding(padding: EdgeInsets.only(left: 20.0)),
                            Text(
                                "${todos[index].duedate.day}/${todos[index].duedate.month}/${todos[index].duedate.year}",
                                style: TextStyle(fontSize: 18)),
                            Padding(padding: EdgeInsets.only(left: 20.0)),
                            Text(todos[index].status.name,
                                style: TextStyle(fontSize: 18)),
                            Spacer(flex: 3),
                            ElevatedButton(
                                onPressed: todos[index].status == Status.pending
                                    ? () {
                                        updateTask(myController.text, index,
                                            Status.canceled);
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                                child: Text('Canceled')),
                            const Padding(
                              padding: EdgeInsets.all(5.0),
                            ),
                            ElevatedButton(
                                onPressed: todos[index].status == Status.pending
                                    ? () {
                                        updateTask(myController.text, index,
                                            Status.completed);
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green),
                                child: Text('Completed'))
                          ]),
                    );
                  })),
          FutureBuilder(
            future: httpService.getPosts(),
            builder:
                (BuildContext context, AsyncSnapshot<List<todo>> snapshot) {
              if (snapshot.hasData) {
                List<todo>? posts = snapshot.data;
                return ListView(
                  children: posts!
                      .map(
                        (todo post) => ListTile(
                          title: Text(post.title),
                        ),
                      )
                      .toList(),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          )
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
      todos.add(todo(
        title: name,
        duedate: taskdate,
        status: Status.pending,
        id: '',
      ));
    });
    myController.clear();
    taskdate = DateTime.now();
  }

  updateTask(String name, int index, Status status) {
    setState(() {
      todos[index].status = status;
    });
  }
}

//----------------------------------------------------------------------