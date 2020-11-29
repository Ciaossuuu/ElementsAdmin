import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementsadmin/Models/courseModel.dart';
import 'package:elementsadmin/Screens/CoursesModule/CreateCourse/courseBuilder.dart';
import 'package:elementsadmin/Screens/elementsAppBar.dart';
import 'package:elementsadmin/Screens/navigationBar.dart';
import 'package:elementsadmin/Services/services.dart';
import 'package:elementsadmin/Strings/routes.dart';
import 'package:elementsadmin/Strings/textStyles.dart';

import 'package:flutter/material.dart';

class CoursesModule extends StatefulWidget {
  CoursesModule({Key key}) : super(key: key);

  @override
  _CourseModuleState createState() => _CourseModuleState();
}

class _CourseModuleState extends State<CoursesModule> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return CourseBuilder();
          }));
        },
        child: Icon(Icons.add),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavigationBar(navItem: 2),
          Center(
            child: Container(
              width: size.width * .8,
              height: size.height,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: size.width * .7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Courses',
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
                                    .collection('courses')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    return Scrollbar(
                                      child: SingleChildScrollView(
                                        child: ListView(
                                            shrinkWrap: true,
                                            children: snapshot.data.docs
                                                .map<Widget>(
                                                    (doc) => _courseBuilder(
                                                          doc: doc,
                                                        ))
                                                .toList()),
                                      ),
                                    );
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
              child: SizedBox(),
            );
          } else {
            return Column(
              children: [
                Card(
                  child: Container(
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
                              // MaterialButton(
                              //   color: Colors.blue,
                              //   child: Text('View'),
                              //   onPressed: () {},
                              // ),
                              // SizedBox(width: size.width * 0.01),
                              // MaterialButton(
                              //   color: Colors.yellow,
                              //   child: Text('Edit'),
                              //   onPressed: () {},
                              // ),
                              // SizedBox(width: size.width * 0.01),
                              // MaterialButton(
                              //   color: Colors.red,
                              //   child: Text('Delete'),
                              //   onPressed: () {},
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
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
}
