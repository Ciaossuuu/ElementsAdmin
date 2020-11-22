import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementsadmin/Models/lessonModel.dart';
import 'package:elementsadmin/Screens/CoursesModule/lessonsBuilder.dart';
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
  Size size;
  DocumentSnapshot doc;
  final GlobalKey<FormState> _formKeyCourse = GlobalKey<FormState>();
  String uid, courseImageUrl, title, description, organizationName;
  bool subscribed;

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

  List lesson = [
    LessonModel.dummyLesson(),
    LessonModel.dummyLesson(),
    LessonModel.dummyLesson()
  ];
  LearningProvider lessonProvider;
  @override
  Widget build(BuildContext context) {
    lessonProvider = Provider.of<LearningProvider>(context, listen: false);
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
                  _createCourse(),
                  SizedBox(
                    height: size.height * .1,
                  ),
                  LessonBuilder(),
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

  _createCourse() {
    return Align(
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
                      labelStyle:
                          CustomTextStyles.customText(size: FontSizes.medium),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0))),
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
                      labelStyle:
                          CustomTextStyles.customText(size: FontSizes.medium),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0))),
                  onChanged: (desc) {
                    getDescription(desc);
                  },
                ),
                TextFormField(
                  maxLines: 1,
                  decoration: InputDecoration(
                      labelText: "Organization's Name",
                      labelStyle:
                          CustomTextStyles.customText(size: FontSizes.medium),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0))),
                  onChanged: (org) {
                    getOrganization(org);
                  },
                ),
                TextFormField(
                  maxLines: 1,
                  decoration: InputDecoration(
                      labelText: 'Course Image URL',
                      labelStyle:
                          CustomTextStyles.customText(size: FontSizes.medium),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0))),
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
    );
  }
}
