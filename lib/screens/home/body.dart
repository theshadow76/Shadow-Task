import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/components/menu/menu.dart';
import 'package:flutter_application_1/components/tasks/tasks.dart';
import 'package:flutter_application_1/screens/home/home.dart';
import 'package:flutter_application_1/screens/login/loginv2.dart';
import 'package:flutter_application_1/screens/menu/menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/screens/register/register.dart';
import 'package:flutter_application_1/screens/register/registerBody.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/screens/register/registerv2.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyWidgetState();
}

List<HomePage> takss = [];

class Todo {
  final String title;

  const Todo(this.title);
}

bool isGoodToGo = false;
double Inode = 15;

final todos = List.generate(20, (i) => Todo("TestTaks"));
final dateOne = List.generate(20, (i) => Todo("TestTasks"));

class _MyWidgetState extends State<HomePage> {
  List<String> todos = [];
  List dateOne = [];
  String dateTwo = "";
  String input = "";
  DateTime selectedDate = DateTime.now();
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  createTodos() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('MyTodos').doc(input);
    Map<String, String> todos = {"todoTitle": input};
    documentReference.set(todos).whenComplete(() => {print("$input created")});
  }

  var tsks = (() => {
        Scaffold(
          body: Container(
            margin: EdgeInsets.only(top: 0),
            width: 200,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.black,
            ),
            child: Material(
              elevation: 1,
            ),
          ),
        )
      });

  Future FlutterAuthOne() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => registerv2()));
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2022, 6),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  CollectionReference users = FirebaseFirestore.instance.collection('testuser');

  final userData = registerpage().emailController.toString();

  Widget build(BuildContext context) {
    FlutterAuthOne();
    return MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Color.fromARGB(255, 64, 67, 201)),
        home: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Add TodoList"),
                      content: TextField(
                        onChanged: (String value) {
                          input = value;
                        },
                      ),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () {
                              createTodos();
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              //TODO: add date picker
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Material(
                                      child: CalendarDatePicker(
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2070),
                                          onDateChanged:
                                              (DateTime newDateTime) {
                                            dateTwo = newDateTime.toString();
                                            setState(() {
                                              dateOne.add(dateTwo);
                                              
                                            });
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop('CalendarDatePicker');
                                            FirebaseFirestore.instance
                                                .collection('UserData')
                                                .doc(registerpage().userId)
                                                .set({"taskData": todos});
                                          }),
                                    );
                                  });
                            },
                            child: Text("Add"))
                      ],
                    );
                  });
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: Column(
            children: <Widget>[
              Column(
                children: [
                  Align(
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (() => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            menu()))
                              }),
                          child: Container(
                              margin: EdgeInsets.only(top: 50, left: 50),
                              child: Image.asset("assets/images/menuidffg.png",
                                  width: 60, height: 60)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 50, left: 70),
                          child: Text("ShadowTask",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24)),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 50, left: 90),
                            child: Image.asset(
                                'assets/images/calendarifggf.png',
                                width: 24,
                                height: 24))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 88),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 199,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(45.0))),
                    child: Align(
                      child: Column(children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(top: 40, left: 200),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "Tasks",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 24),
                            )),
                        Container(
                          alignment: AlignmentDirectional.center,
                          child: Row(
                            children: [
                              Container(
                                alignment: AlignmentDirectional.topCenter,
                                width: 250,
                                height:
                                    MediaQuery.of(context).size.height - 270,
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Container(
                                        child: ListView.builder(
                                          itemCount: todos.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Dismissible(
                                              key: Key(todos[index]),
                                              child: Card(
                                                elevation: 4,
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: ListTile(
                                                  title: Text(todos[index]),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                alignment: AlignmentDirectional.topCenter,
                                width: 250,
                                height:
                                    MediaQuery.of(context).size.height - 270,
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Container(
                                        child: ListView.builder(
                                          itemCount: dateOne.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Dismissible(
                                              key: Key(dateOne[index]),
                                              child: Card(
                                                elevation: 4,
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: ListTile(
                                                  title: Text(dateOne[index]),
                                                  trailing: IconButton(
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        dateOne.removeAt(index);
                                                        todos.removeAt(index);
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
