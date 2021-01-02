import 'package:elementsadmin/Models/userModel.dart';
import 'package:elementsadmin/Screens/Dashboard/courseGraph/courseGraph.dart';
import 'package:elementsadmin/Screens/Dashboard/cards/progressCard.dart';
import 'package:elementsadmin/Screens/Dashboard/quizGraph/quizGraph.dart';
import 'package:elementsadmin/Screens/Dashboard/courseGraph/usersList.dart';
import 'package:elementsadmin/Screens/Dashboard/users/users.dart';
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
  final UserModel users;
  Dashboard({Key key, @required this.users}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future getDocs() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("users").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      print(a.id);
    }
  }

  Size size;
  bool courseHidden = true, quizHidden = false, userHidden = false;
  DocumentSnapshot doc;
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
                  child: Container(
                    width: size.width,
                    height: size.height,
                    child: SingleChildScrollView(
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
                                    userHidden = false;
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
                                    userHidden = false;
                                  });
                                },
                              ),
                              SizedBox(
                                width: size.width * 0.02,
                              ),
                              ProjectProgressCard(
                                color: Color(0xffFAAA1E),
                                projectName: 'Users',
                                value: '4',
                                icon: Icons.people,
                                iconColor: Color(0xffFAAA1E),
                                onPressed: () {
                                  setState(() {
                                    userHidden = true;
                                    courseHidden = false;
                                    quizHidden = false;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.08,
                          ),
                          Visibility(
                            visible: courseHidden,
                            child: Container(
                              width: size.width * .8,
                              height: size.height,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.03),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListOfUsers()),
                                        );
                                      },
                                      color: Colors.greenAccent,
                                      child: Text('Send Certificate'),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    Card(
                                      child: Container(
                                        width: size.width * 0.45,
                                        height: size.height * 0.45,
                                        child: CourseChart(),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          Visibility(
                            visible: quizHidden,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          Visibility(
                            visible: userHidden,
                            child: Container(
                              width: size.width * 0.6,
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    return SingleChildScrollView(
                                      child: Wrap(
                                        children: snapshot.data.docs
                                            .map<Widget>((doc) => _displayUsers(
                                                  doc: doc,
                                                ))
                                            .toList(),
                                      ),
                                    );
                                  }
                                  return Center(
                                      child: CircularProgressIndicator());
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))),
        ],
      ),
    );
  }

  _displayUsers({DocumentSnapshot doc}) {
    size = MediaQuery.of(context).size;
    UserModel user = UserModel.get(doc);
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center();
          } else {
            return Column(
              children: [
                Container(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(user.firstName + " " + user.lastName),
                    subtitle: Text(user.email),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                )
              ],
            );
          }
        });
  }
}
