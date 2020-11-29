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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavigationBar(navItem: 3),
          Center(
            child: Container(
              width: size.width * .8,
              height: size.height,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
                child: Column(
                  children: [
                    Container(
                      width: size.width * .7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Quizzes',
                            style: CustomTextStyles.customText(
                                size: FontSizes.heading, isBold: true),
                          ),
                          SizedBox()
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          width: size.width * 0.7,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('quizzes')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return SingleChildScrollView(
                                      child: Scrollbar(
                                          child: ListView(
                                              shrinkWrap: true,
                                              children: snapshot.data.docs
                                                  .map<Widget>(
                                                      (doc) => _quizBuilder(
                                                            doc: doc,
                                                          ))
                                                  .toList())));
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              })),
                    ),
                  ],
                ),
              ),
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
            child: SizedBox(),
          );
        } else {
          return Column(
            children: [
              Card(
                child: Container(
                  child: ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(quiz.title),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(width: size.width * 0.01),
                              MaterialButton(
                                color: Colors.yellow,
                                child: Text('Edit'),
                                onPressed: () {},
                              ),
                              SizedBox(width: size.width * 0.01),
                              MaterialButton(
                                color: Colors.red,
                                child: Text('Delete'),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                      children: <Widget>[
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
