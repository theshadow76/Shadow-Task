import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/menu/menubody.dart';

void main() {
  runApp(const menu());
}

class menu extends StatefulWidget {
  const menu({Key? key}) : super(key: key);

  @override
  State<menu> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<menu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Container(
        decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/backgroundMenu.jpeg"),
                fit: BoxFit.cover
              )
            ),
        child: menuhome(),
      )
    );
  }
}