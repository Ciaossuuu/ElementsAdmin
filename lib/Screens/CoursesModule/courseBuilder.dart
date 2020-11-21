import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementsadmin/Screens/elementsAppBar.dart';
import 'package:elementsadmin/Strings/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:elementsadmin/Screens/navigationBar.dart';
import 'package:elementsadmin/Provider/learningProvider.dart';
import 'package:provider/provider.dart';

class CourseBuilder extends StatefulWidget {
  CourseBuilder({Key key}) : super(key: key);

  @override
  _CourseBuilderState createState() => _CourseBuilderState();
}

class _CourseBuilderState extends State<CourseBuilder>
    with TickerProviderStateMixin {
  List lesson = ['lesson1', 'lesson2', 'lesson3'];
  Size size;
  LearningProvider _learningProvider;

  DocumentSnapshot doc;
  final GlobalKey<FormState> _formKeyCourse = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyLesson = GlobalKey<FormState>();
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * .05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("New Course",
                  style: CustomTextStyles.customText(
                      isBold: true, size: FontSizes.heading)),
              Container(
                  width: size.width * 0.9,
                  child: Divider(thickness: 1, color: Colors.grey)),
              SizedBox(height: size.height * 0.04),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: size.width * .4,
                      height: size.height * .62,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2,
                                color: Colors.grey,
                                offset: Offset(2, 2),
                                spreadRadius: 1)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Form(
                          key: _formKeyCourse,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Let’s create a course",
                                style: CustomTextStyles.customText(
                                    isBold: true, size: FontSizes.subHeading),
                              ),
                              TextFormField(
                                maxLines: 1,
                                decoration: InputDecoration(
                                    labelText: 'Course Title',
                                    labelStyle: CustomTextStyles.customText(
                                        size: FontSizes.medium),
                                    border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(5.0))),
                                onChanged: (titles) {
                                  getTitle(titles);
                                },
                              ),
                              TextFormField(
                                textAlignVertical: TextAlignVertical.top,
                                maxLines: 4,
                                decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    labelText: 'Course Description',
                                    labelStyle: CustomTextStyles.customText(
                                        size: FontSizes.medium),
                                    border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(5.0))),
                                onChanged: (desc) {
                                  getDescription(desc);
                                },
                              ),
                              TextFormField(
                                maxLines: 1,
                                decoration: InputDecoration(
                                    labelText: "Organization's Name",
                                    labelStyle: CustomTextStyles.customText(
                                        size: FontSizes.medium),
                                    border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(5.0))),
                                onChanged: (org) {
                                  getOrganization(org);
                                },
                              ),
                              TextFormField(
                                maxLines: 1,
                                decoration: InputDecoration(
                                    labelText: 'Course Image URL',
                                    labelStyle: CustomTextStyles.customText(
                                        size: FontSizes.medium),
                                    border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(5.0))),
                                onChanged: (image) {
                                  getImageURL(image);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      //color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    height: size.height * .1,
                  ),
                  Container(
                    width: size.width * 0.4,
                    height: size.height * 0.62,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(25),
                            child: Row(
                              children: [
                                Text(
                                  "Lessons",
                                  style: CustomTextStyles.customText(
                                      isBold: true, size: FontSizes.subHeading),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Card(
                                  child: Text('lesson'),
                                )
                              ],
                            ),
                          ),
                        )
                        // MaterialButton(
                        //   color: Colors.greenAccent[400],
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [Text('Add new Lesson'), Icon(Icons.add)],
                        //   ),
                        //   onPressed: () => _addLesson(context),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: Colors.red,
                    child: Text('CANCEL',
                        style: CustomTextStyles.customText(
                            isBold: true, size: FontSizes.small)),
                    onPressed: () {},
                  ),
                  SizedBox(width: size.width * 0.02),
                  MaterialButton(
                    color: Colors.green,
                    child: Text('SAVE',
                        style: CustomTextStyles.customText(
                            isBold: true, size: FontSizes.small)),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _addLesson(BuildContext context) {
    String dropdownValue = 'isTaken?';
    showDialog<String>(
      context: context,
      child: Container(
        child: AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text('Add Lesson'),
          content: Container(
            width: size.width * .6,
            height: size.height * .7,
            child: SingleChildScrollView(
              child: Form(
                key: _formKeyLesson,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          width: size.width * 0.09,
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'No.'),
                            onChanged: (seq) {},
                          ),
                        ),
                        SizedBox(width: size.width * 0.01),
                        Container(
                          width: size.width * 0.5,
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Lesson Title'),
                            onChanged: (titles) {},
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Lesson Description'),
                      onChanged: (desc) {
                        getDescription(desc);
                      },
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: "Lesson Video URL"),
                      onChanged: (org) {
                        getOrganization(org);
                      },
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Lesson Image URL'),
                      onChanged: (image) {
                        getImageURL(image);
                      },
                    ),
                    DropdownButton<bool>(
                      hint: Text('is Taken?'),
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (val) {},
                      items: <bool>[true, false].map((bool value) {
                        return new DropdownMenuItem<bool>(
                          value: value,
                          child: new Text(value.toString()),
                        );
                      }).toList(),
                    )
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
                  _formKeyLesson.currentState.validate();
                  //DatabaseService().addCourses(doc, title, description, organizationName, courseImageUrl);
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }

  _addButton() {
    return InkWell(
      splashColor: Colors.amber,
      onTap: () => _addLesson(context),
      child: Container(
        width: size.width * .2,
        height: size.height * .075,
        decoration: BoxDecoration(
            color: Color.fromRGBO(154, 211, 188, 1),
            borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: ClipOval(
            child: Container(
              width: 50,
              height: 50,
              color: Color.fromRGBO(235, 89, 82, 1),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildTextFormField({
    TextEditingController controller,
    @required String label,
    int maxLines,
  }) {
    return TextFormField(
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: CustomTextStyles.customText(size: FontSizes.medium)),
      onChanged: (val) {},
    );
  }
}
