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
          Container(
            width: size.width * .2,
            height: size.height,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 2,
                color: Colors.grey,
                offset: Offset(2, 0),
              )
            ]),
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        ' Elements++',
                        style: TextStyle(
                            fontFamily: 'IndieFlower',
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(height: size.height * 0.05),
                  NavigationButton.buildButton(
                      text: 'Dashboard',
                      size: size,
                      color: Colors.deepPurple[400],
                      onpressed: () {
                        Navigator.pushNamed(context, Routes.def);
                      }),
                  SizedBox(height: size.height * 0.02),
                  NavigationButton.buildButton(
                      text: 'Courses Module',
                      size: size,
                      color: Colors.white,
                      onpressed: () {
                        Navigator.pushNamed(context, Routes.courses);
                      }),
                  SizedBox(height: size.height * 0.02),
                  NavigationButton.buildButton(
                      text: 'Challenge Module',
                      size: size,
                      color: Colors.white,
                      onpressed: () {
                        Navigator.pushNamed(context, Routes.challenge);
                      }),
                  SizedBox(height: size.height * 0.02),
                  NavigationButton.buildButton(
                      text: 'Users',
                      size: size,
                      color: Colors.white,
                      onpressed: () {
                        Navigator.pushNamed(context, Routes.users);
                      }),
                ],
              ),
            ),
          ),
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
