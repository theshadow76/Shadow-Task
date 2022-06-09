import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/components/menu/menu.dart';
import 'package:flutter_application_1/components/tasks/tasks.dart';
import 'package:flutter_application_1/components/tasks/tasksCreator.dart';
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
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _MyWidgetState();
}

List<HomePage> takss = [];

class Todo {
  final String title;

  const Todo(this.title);
}

class Input {
  static String input = "";
}

bool isGoodToGo = false;
double Inode = 15;

final todos = List.generate(20, (i) => Todo("TestTaks"));
final dateOne = List.generate(20, (i) => Todo("TestTasks"));

class _MyWidgetState extends State<HomePage> {
  List<String> todos = [];
  List dateOne = [];
  String input = Input.input.toString();
  String dateTwo = "";
  List<String> Inp = [];
  DateTime selectedDate = DateTime.now();

  // para el datasaver

  void initState() {
    // TODO: implement initState
    super.initState();
    String input;
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
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.black,
            ),
            child: const Material(
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

  // creador de tasks / save data
  String? _content;
  String DataValue = "";
  _MyWidgetState({this.input = ""});
  callBack(varDataTasks) {
    setState(() {
      input = varDataTasks;
    });
  }
  // data saver
  // String DataSaver = '{"TaskData" : {"TaskTitle" : "' + input + '"}}';

  // Find the Documents path

  int Inode = 1;

  Widget build(BuildContext context) {
    double screenSizeWith = MediaQuery.of(context).size.width;
    FlutterAuthOne();
    return MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Color.fromARGB(255, 64, 66, 201)),
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
                          input = value; // aqui es para obtener el data
                          TaskCreator().inputTask = input;
                          String Taskdt = input;
                        },
                      ),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () {
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
                                              int Inodes = Inode++;
                                            });
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop('CalendarDatePicker');
                                            FirebaseFirestore.instance
                                                .collection('MyTodos')
                                                .doc("data ")
                                                .set({"taskData": input});
                                          }),
                                    );
                                  });
                            },
                            child: const Text("Add"))
                      ],
                    );
                  });
            },
            child: const Icon(
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 40),
                              child: const Icon(
                                Icons.menu_sharp,
                                size: 28.2,
                                color: Color.fromARGB(212, 255, 255, 255),
                              )),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 40),
                          child: const Text("ShadowTask",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24)),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 40),
                          child: const Icon(
                            Icons.calendar_month_sharp,
                            size: 28.2,
                            color: Color.fromARGB(212, 255, 255, 255),
                          ),
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(top: 88),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 156.2,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(45.0))),
                      child: Align(
                        child: Column(children: <Widget>[
                          Container(
                              margin: const EdgeInsets.only(top: 40),
                              width: MediaQuery.of(context).size.width,
                              child: const Text(
                                "Tasks",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 33, 33, 33),
                                    fontSize: 24),
                              )),
                          Container(
                            height: 50,
                            child: TaskCreator(),
                          )
                        ]),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class CreatTaskBtnBody extends StatelessWidget {
  const CreatTaskBtnBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List dateOne = [];
    String dateTwo = "";
    String input = "";
    return Scaffold();
  }
}



/*
                            //empiesa aqui
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
                                          // aqui las tasks nombre
                                          child: ListView.builder(
                                            shrinkWrap: true,
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
                                                    trailing: IconButton(
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          // para modificar algo despues de borar la task
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
                                          // y aqui el tasks de date
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
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          dateOne
                                                              .removeAt(index);
                                                          todos.removeAt(index);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ), //termina aqui
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ), */
