import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/components/tasks/datasaver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/screens/home/body.dart';

class TaskCreator extends StatelessWidget {
  TaskCreator({Key? key}) : super(key: key);
  String inputTask = "";
  String InputData = Input.input.toString();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            // Demo
            Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width),
              width: MediaQuery.of(context).size.width - 20,
              height: 40,
              decoration: BoxDecoration(
                  color: Color.fromARGB(228, 228, 228, 228),
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              child: Column(
                children: [
                  Text(inputTask),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
