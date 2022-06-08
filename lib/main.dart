import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/screens/home/body.dart';
import 'package:flutter_application_1/screens/register/register.dart';
import 'package:flutter_application_1/screens/register/registerBody.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      
    } else {}
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 64, 67, 201)),
      home: home(),
    );
  }
}

class redirectRegister {
  Widget build(BuildContext context) {
    return Scaffold(
        body: AlertDialog(
      title: Text("You need to register"),
      content: Text("Ho ho, we did not find your account"),
    ));
  }
}
