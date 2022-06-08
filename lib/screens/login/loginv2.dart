import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
                      color: Color.fromARGB(150, 0, 0, 0), fontSize: 40,),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 126),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(hintText: "Email"),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 90),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(hintText: "Password"),
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
                    width: 39,
                    height: 38,
                  )),
            ),
            GestureDetector(
              onTap: (() => {
                Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => registerv2()))
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
                  launch('https://www.instagram.com/tienda_shadowtech_software/')
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
                onTap: (() => {
                  launch('http://www.theshadowtech.com/')
                }),
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
}
