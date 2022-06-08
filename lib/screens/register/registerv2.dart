import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/screens/login/loginv2.dart';
import 'package:url_launcher/url_launcher.dart';

class registerv2 extends StatefulWidget {
  const registerv2({Key? key}) : super(key: key);

  @override
  State<registerv2> createState() => _loginv2State();
}

// ignore: camel_case_types
class _loginv2State extends State<registerv2> {
  String errorText = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screensizewidth = MediaQuery.of(context).padding;
    double screenSizeWith = MediaQuery.of(context).size.width;
    String screenwidthstr = screensizewidth.toString();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Scaffold(
        body: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 34),
                child: Text(
                  "ShadowTask",
                  style: TextStyle(
                      color: Color.fromARGB(150, 0, 0, 0), fontSize: 40),
                ),
              ),
            ),
            Center(
              child: Container(
                width: screenSizeWith - 40,
                margin: EdgeInsets.only(top: 126),
                child: TextField(
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(hintText: "Email"),
                  controller: emailController,
                ),
              ),
            ),
            Center(
              child: Container(
                width: screenSizeWith - 70,
                margin: EdgeInsets.only(top: 90),
                child: TextField(
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(hintText: "Password"),
                  obscureText: true,
                ),
              ),
            ),
            Container(
              child: Text(errorText, style: TextStyle(color: Colors.red)),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 50),
                width: MediaQuery.of(context).size.width - 70,
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(120, 16, 196, 113),
                  )),
                  onPressed: (() => {}),
                  child: Container(
                      child: Text(
                    "Register",
                    style: TextStyle(fontSize: 32, color: Colors.grey[700]),
                  )),
                ),
              ),
            ),
            Center(
              child: Container(
                  margin: EdgeInsets.only(top: 25),
                  child: Image.asset(
                    'images/1534129544.png',
                    width: 39,
                    height: 38,
                  )),
            ),
            GestureDetector(
              onTap: (() => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => loginv2()))
                  }),
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text("Don’t have an account? Register here!"),
                ),
              ),
            )
          ],
        ),
        persistentFooterButtons: [
          Row(
            children: [
              GestureDetector(
                onTap: (() => {
                      launch(
                          'https://www.instagram.com/tienda_shadowtech_software/')
                    }),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'images/instagram.png',
                      width: 27,
                      height: 27,
                    )),
              ),
              GestureDetector(
                onTap: (() => {launch('http://www.theshadowtech.com/')}),
                child: Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(left: screenSizeWith - 70),
                    child: Image.asset(
                      'images/web.png',
                      width: 27,
                      height: 27,
                    )),
              ),
            ],
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
        errorText = "The password provided is to weak";
      } else if (e.code == 'email-already-in-use') {
        errorText = "The account already exists for that email";
      }
    } catch (e) {
      errorText = "Account created";
    }
  }
}
