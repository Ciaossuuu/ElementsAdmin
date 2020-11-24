import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementsadmin/Models/lessonModel.dart';

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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavigationBar(navItem: 3),
          Container(
            width: size.width * .6,
            height: size.height,
            child: Center(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('lessons')
                      .orderBy('sequence')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Wrap(
                            children: snapshot.data.docs
                                .map((doc) => _lessonCard(
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
          ),
          SizedBox(
            width: size.width * .08,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
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
