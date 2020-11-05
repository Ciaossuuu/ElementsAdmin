import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementsadmin/Models/courseModel.dart';
import 'package:elementsadmin/Screens/CoursesModule/courseBuilder.dart';
import 'package:elementsadmin/Screens/elementsAppBar.dart';
import 'package:elementsadmin/Screens/navigationBar.dart';
import 'package:elementsadmin/Strings/routes.dart';

import 'package:flutter/material.dart';

class CoursesModule extends StatefulWidget {
  CoursesModule({Key key}) : super(key: key);

  @override
  _CourseModuleState createState() => _CourseModuleState();
}

class _CourseModuleState extends State<CoursesModule> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.courseBuilder);
        },
        child: Icon(Icons.add),
      ),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * .1),
          child: ElementsAppBar()),
      body: Row(
        children: [
          NavigationBar(),
          Center(
            child: Container(
              width: size.width * .8,
              height: size.height,
              color: Colors.grey[300],
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('courses')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Wrap(
                            children: snapshot.data.docs
                                .map<Widget>((doc) => _courseBuilder(
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
        ],
      ),
    );
  }

  _courseBuilder({DocumentSnapshot doc}) {
    CourseModel course = CourseModel.getData(doc: doc);
    return Card(
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () {},
        child: Container(
          width: 250,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(children: [
              Text(course.title),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(course.courseImageUrl),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  course.description,
                  textAlign: TextAlign.center,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.all(0),
      // title: Text("My title"),
      content: CourseBuilder(),
      actions: [],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
