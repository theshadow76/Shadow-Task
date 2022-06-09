import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/screens/home/body.dart';
import 'package:flutter_application_1/screens/register/registerv2.dart';
import 'package:url_launcher/url_launcher.dart';

class loginv2 extends StatefulWidget {
  const loginv2({Key? key}) : super(key: key);

  @override
  State<loginv2> createState() => _loginv2State();
}

// ignore: camel_case_types
class _loginv2State extends State<loginv2> {
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
                margin: const EdgeInsets.only(top: 34),
                child: const Text(
                  "ShadowTask",
                  style: TextStyle(
                    color: Color.fromARGB(150, 0, 0, 0),
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: screenSizeWith - 40,
                margin: const EdgeInsets.only(top: 126),
                child: TextField(
                  style: const TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(hintText: "Email"),
                  controller: emailController,
                ),
              ),
            ),
            Center(
              child: Container(
                width: screenSizeWith - 70,
                margin: const EdgeInsets.only(top: 90),
                child: TextField(
                  style: const TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(hintText: "Password"),
                  obscureText: true,
                  controller: passwordController,
                ),
              ),
            ),
            Container(
              child: Text(errorText, style: TextStyle(color: Colors.red)),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 50),
                width: MediaQuery.of(context).size.width - 70,
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(120, 16, 196, 113),
                  )),
                  onPressed: signIn,
                  child: Container(
                      child: Text(
                    "LOG IN",
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
                    width: 42,
                    height: 42,
                  )),
            ),
            GestureDetector(
              onTap: (() => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => registerv2()))
                  }),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: const Text(
                    "Don’t have an account? Register here!",
                    style: TextStyle(fontSize: 18),
                  ),
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
                      width: 39,
                      height: 39,
                    )),
              ),
              GestureDetector(
                onTap: (() => {launch('http://www.theshadowtech.com/')}),
                child: Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(left: screenSizeWith - 82),
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

  Future signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          errorText = "User not found";
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          errorText = "Incorrect password";
        });
      }
    }
  }
}
