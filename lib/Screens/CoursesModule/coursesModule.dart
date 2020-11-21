import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementsadmin/Models/courseModel.dart';
import 'package:elementsadmin/Screens/CoursesModule/courseBuilder.dart';
import 'package:elementsadmin/Screens/elementsAppBar.dart';
import 'package:elementsadmin/Screens/navigationBar.dart';
import 'package:elementsadmin/Services/services.dart';
import 'package:elementsadmin/Strings/routes.dart';

import 'package:flutter/material.dart';

class CoursesModule extends StatefulWidget {
  CoursesModule({Key key}) : super(key: key);

  @override
  _CourseModuleState createState() => _CourseModuleState();
}

class _CourseModuleState extends State<CoursesModule> {
  Size size;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DocumentSnapshot doc;
  String uid, title, description, organizationName, courseImageUrl;
  getTitle(titles) {
    this.title = titles;
  }

  getImageURL(image) {
    this.courseImageUrl = image;
  }

  getDescription(desc) {
    this.description = desc;
  }

  getOrganization(org) {
    this.organizationName = org;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
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
              ),
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
                        color: Colors.white,
                        onpressed: () {
                          Navigator.pushNamed(context, Routes.def);
                        }),
                    SizedBox(height: size.height * 0.02),
                    NavigationButton.buildButton(
                        text: 'Courses Module',
                        size: size,
                        color: Colors.deepPurple[400],
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
                  ]),
            ),
          ),
          Center(
            child: Container(
              width: size.width * .8,
              height: size.height,
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
                child: Column(
                  children: [
                    Container(
                      width: size.width * .7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MaterialButton(
                            color: Colors.greenAccent[400],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text('New Course'), Icon(Icons.add)],
                            ),
                            onPressed: () => Navigator.pushNamed(
                                context, Routes.courseBuilder),
                          ),
                          SizedBox()
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Container(
                      width: size.width * 0.7,
                      color: Colors.white,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('courses')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return SingleChildScrollView(
                                child: ListView(
                                    shrinkWrap: true,
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _courseBuilder({DocumentSnapshot doc}) {
    size = MediaQuery.of(context).size;
    CourseModel course = CourseModel.getData(doc: doc);
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('courses').snapshots(),
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
                Container(
                  child: ExpansionTile(
                    title: Text(course.title),
                    children: <Widget>[
                      ListTile(
                        title: Column(
                          children: [
                            Container(
                              width: size.width * 0.2,
                              child: Image(
                                  image: NetworkImage(course.courseImageUrl)),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Text(course.description),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MaterialButton(
                              color: Colors.blue,
                              child: Text('View'),
                              onPressed: () {},
                            ),
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
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                )
              ],
            );
          }
        });
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

  _addCourse(BuildContext context) {
    showDialog<String>(
      context: context,
      child: Container(
        child: AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text('Add Course'),
          content: Container(
            width: size.width * .6,
            height: size.height * .7,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Course Title'),
                      onChanged: (titles) {
                        getTitle(titles);
                      },
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Course Description'),
                      onChanged: (desc) {
                        getDescription(desc);
                      },
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: "Organization's Name"),
                      onChanged: (org) {
                        getOrganization(org);
                      },
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Course Image URL'),
                      onChanged: (image) {
                        getImageURL(image);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('ADD'),
                onPressed: () {
                  _formKey.currentState.validate();
                  DatabaseService().addCourses(doc, title, description,
                      organizationName, courseImageUrl);
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
