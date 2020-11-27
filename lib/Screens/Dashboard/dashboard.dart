import 'package:elementsadmin/Screens/Dashboard/courseGraph/courseGraph.dart';
import 'package:elementsadmin/Screens/Dashboard/cards/progressCard.dart';
import 'package:elementsadmin/Screens/Dashboard/quizGraph/quizGraph.dart';
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
  bool courseHidden = false, quizHidden = false, userHidden = false;
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
                  padding: const EdgeInsets.all(30),
                  child: ListView(
                    children: [
                      Container(
                        width: size.width,
                        height: size.height,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProjectProgressCard(
                                  color: Color(0xffFF4C60),
                                  projectName: 'Courses',
                                  value: '2',
                                  icon: Icons.menu_book,
                                  iconColor: Color(0xffFF4C60),
                                  onPressed: () {
                                    setState(() {
                                      courseHidden = true;
                                      quizHidden = false;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                ProjectProgressCard(
                                  color: Color(0xff6C6CE5),
                                  projectName: 'Quizzes',
                                  value: '3',
                                  icon: Icons.question_answer,
                                  iconColor: Color(0xff6C6CE5),
                                  onPressed: () {
                                    setState(() {
                                      courseHidden = false;
                                      quizHidden = true;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                ProjectProgressCard(
                                  color: Color(0xffFAAA1E),
                                  projectName: 'Users',
                                  value: '5',
                                  icon: Icons.people,
                                  iconColor: Color(0xffFAAA1E),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.1,
                            ),
                            Visibility(
                              visible: courseHidden,
                              child: Container(
                                width: size.width * 0.5,
                                height: size.height * 0.5,
                                child: CourseChart(),
                              ),
                            ),
                            Visibility(
                              visible: quizHidden,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: size.width * 0.22,
                                    height: size.height * 0.22,
                                    child: QuizChart(level: 'Easy'),
                                  ),
                                  Container(
                                    width: size.width * 0.22,
                                    height: size.height * 0.22,
                                    child: QuizChart(level: 'Medium'),
                                  ),
                                  Container(
                                    width: size.width * 0.22,
                                    height: size.height * 0.22,
                                    child: QuizChart(level: 'Hard'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))),
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
