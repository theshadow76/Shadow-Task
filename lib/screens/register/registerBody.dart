import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/screens/home/home.dart';
import 'package:flutter_application_1/screens/login/login.dart';
import 'package:flutter_application_1/screens/support/supportbody.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class registerpage extends StatelessWidget {
  registerpage({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var userId = "";

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/taskdata.txt');
  }

  Future<String> getFilePath() async {
    Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/taskdata.txt'; // 3

    return filePath;
  }

  void saveFile() async {
    File file = File(await getFilePath()); // 1
    print(userId);
    file.writeAsString(userId); // 2
  }

  void WriteData() {
    Future<File> writeCounter(int counter) async {
      final file = await _localFile;

      // Write the file
      return file.writeAsString(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 100, top: 10),
                  child: Text(
                    "ShadowTask",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, top: 20),
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 23),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: "Email here"),
                    controller: emailController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 23),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: "Password here"),
                    controller: passwordController,
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => login()))
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 27),
                    child: Text(
                      "Already have a account? Login here!",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _firebaseAuth
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((value) => {
                              userId = value.user!.uid.toString(),
                              FirebaseFirestore.instance
                                  .collection('UserData')
                                  .doc(value.user?.uid)
                                  .set({"email": value.user?.email})
                            });
                  },
                  child: Container(
                    width: 130,
                    height: 55,
                    margin: EdgeInsets.only(top: 30, left: 70),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        color: Colors.black),
                    child: Center(
                      child: Text(
                        "Accept",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 27),
                    child: GestureDetector(
                      onTap: () => {launch('mailto:shadowtech011@gmail.com')},
                      child: Text(
                        "Having problems? press here for support!",
                        style: TextStyle(color: Colors.white),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Future signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AlertDialog(
          title: Text("password to weak"),
          content: Text("The password provided is to weak"),
        );
      } else if (e.code == 'email-already-in-use') {
        AlertDialog(
          title: Text("email is already in use"),
          content: Text("The account already exists for that email"),
        );
      }
    } catch (e) {
      AlertDialog(
        title: Text("passed"),
        content: Text("Account created!"),
      );
    }
  }
}
