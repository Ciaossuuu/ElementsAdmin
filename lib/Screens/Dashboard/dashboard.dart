import 'package:elementsadmin/Strings/routes.dart';
import 'package:flutter/material.dart';

import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementsadmin/Models/lessonModel.dart';

import 'package:elementsadmin/Services/services.dart';
import 'package:elementsadmin/Strings/textStyles.dart';
import 'package:flutter/material.dart';

import '../navigationBar.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  CollectionReference users = FirebaseFirestore.instance.collection('lessons');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavigationBar(navItem: 1),
          Container(
              width: size.width * .8,
              height: size.height,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
              )),
        ],
      ),
    );
  }

  //Lesson Cards
  Widget _lessonCard({DocumentSnapshot doc}) {
    // LessonModel lesson = LessonModel.getData(doc: doc);
    Future getData() async {
      var database = FirebaseFirestore.instance;
      QuerySnapshot snapshot = await database.collection('lessons').get();
      return snapshot.docs;
    }

    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SizedBox(
              height: 210.0,
              width: 200.0,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                height: size.height * .37,
                width: size.width * .17,
                child: GridView.count(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 1,
                    children: [
                      Card(
                          elevation: 2,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.white,
                          ))
                    ])),
          );
        }
      },
    );
  }
}
