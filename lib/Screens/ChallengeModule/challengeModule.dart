import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementsadmin/Models/lessonModel.dart';
import 'package:elementsadmin/Models/quizModel.dart';
import 'package:elementsadmin/Screens/ChallengeModule/CreateQuiz/quizBuilder.dart';

import 'package:elementsadmin/Services/services.dart';
import 'package:elementsadmin/Strings/routes.dart';
import 'package:elementsadmin/Strings/textStyles.dart';
import 'package:flutter/material.dart';

import '../navigationBar.dart';

class ChallengeModule extends StatefulWidget {
  ChallengeModule({Key key}) : super(key: key);

  @override
  _ChallengeModuleState createState() => _ChallengeModuleState();
}

class _ChallengeModuleState extends State<ChallengeModule> {
  CollectionReference users = FirebaseFirestore.instance.collection('lessons');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return QuizBuilder();
          }));
        },
        child: Icon(Icons.add),
      ),
      body: Row(
        children: [
          NavigationBar(
            navItem: 3,
          ),
          Container(
            width: size.width * .8,
            height: size.height,
            color: Colors.white,
            padding: EdgeInsets.all(35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quizzes',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.all(35),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('quizzes')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return Scrollbar(
                            child: ListView(
                                shrinkWrap: true,
                                children: snapshot.data.docs
                                    .map<Widget>((doc) => _quizBuilder(
                                          doc: doc,
                                        ))
                                    .toList()),
                          );
                        }

                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _quizBuilder({DocumentSnapshot doc}) {
    QuizModel quiz = QuizModel.getData(doc: doc);
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('quizzes').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SizedBox(
              height: 210.0,
              width: 200.0,
            ),
          );
        } else {
          return Column(
            children: [
              Card(
                child: Container(
                  child:
                      ExpansionTile(title: Text(quiz.title), children: <Widget>[
                    ListTile(
                      title: Column(
                        children: [
                          SizedBox(height: size.height * 0.02),
                          Text(quiz.level),
                        ],
                      ),
                    ),
                  ]),
                ),
              )
            ],
          );
        }
      },
    );
  }
}
