import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementsadmin/Models/model.dart';
import 'package:elementsadmin/Services/services.dart';
import 'package:elementsadmin/Strings/textStyles.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        title: Text(
          ' Elements++',
          style: TextStyle(
              fontFamily: 'IndieFlower',
              fontSize: 35,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            width: size.width * .17,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipOval(
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.red,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'John Doe',
                      style: CustomTextStyles.customText(
                          isBold: true,
                          size: FontSizes.medium,
                          color: Colors.white),
                    ),
                    Text('Admin')
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_drop_down, size: 20),
                )
              ],
            ),
          )
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width * .22,
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
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    highlightColor: Colors.purple,
                    hoverColor: Colors.deepPurple[300],
                    height: size.height * .075,
                    minWidth: size.width * 0.1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Lessons Module',
                          style: CustomTextStyles.customText(
                              isBold: true, size: FontSizes.large)),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/lessons'),
                  ),
                  SizedBox(height: size.height * .02),
                  MaterialButton(
                    height: size.height * .075,
                    minWidth: size.width * 0.2,
                    color: Colors.deepPurple[300],
                    highlightColor: Colors.purple,
                    hoverColor: Colors.deepPurple[300],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Challenge Module',
                          style: CustomTextStyles.customText(
                              isBold: true, size: FontSizes.large)),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/challenge'),
                  ),
                  SizedBox(height: size.height * .02),
                  MaterialButton(
                    height: size.height * .075,
                    minWidth: size.width * 0.2,
                    highlightColor: Colors.purple,
                    hoverColor: Colors.deepPurple[300],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Users',
                          style: CustomTextStyles.customText(
                              isBold: true, size: FontSizes.large)),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/users'),
                  ),
                ],
              ),
            ),
          ),
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
    LessonModel lesson = LessonModel.getData(doc: doc);
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
