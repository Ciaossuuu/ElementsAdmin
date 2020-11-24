import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementsadmin/Models/courseModel.dart';
import 'package:elementsadmin/Models/lessonModel.dart';

import 'package:elementsadmin/Screens/CoursesModule/CreateCourse/createLesson.dart';
import 'package:elementsadmin/Screens/CoursesModule/CreateCourse/lessonsBuilder.dart';
import 'package:elementsadmin/Screens/elementsAppBar.dart';
import 'package:elementsadmin/Services/services.dart';
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

class _CourseBuilderState extends State<CourseBuilder> {
  Size size;
  LearningProvider _learningProvider;
  TextEditingController title = TextEditingController(),
      description = TextEditingController(),
      organizationName = TextEditingController(),
      coureImageUrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _learningProvider = Provider.of<LearningProvider>(context, listen: true);
    size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var baseDialog = CreateLesson();
          showDialog(
              context: context, builder: (BuildContext context) => baseDialog);
        },
        child: Center(child: Text('Add')),
      ),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Let’s create a course",
                                style: CustomTextStyles.customText(
                                    isBold: true, size: FontSizes.subHeading),
                              ),
                              _buildTextFormField(
                                  controller: title, label: 'Course Title'),
                              _buildTextFormField(
                                  controller: description,
                                  label: 'Course Description',
                                  maxLines: 4),
                              _buildTextFormField(
                                  controller: organizationName,
                                  label: 'Organization Name'),
                              _buildTextFormField(
                                  controller: coureImageUrl,
                                  label: 'Course Image Url'),
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
                    onPressed: () {
                      CourseModel course = CourseModel();
                      course.title = title.text;
                      course.description = description.text;
                      course.organizationName = organizationName.text;
                      course.courseImageUrl = coureImageUrl.text;
                      course.lessons = _learningProvider.lessons;
                      DatabaseService().addCourses(courseModel: course);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildTextFormField(
      {@required TextEditingController controller,
      @required String label,
      int maxLines}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: CustomTextStyles.customText(size: FontSizes.medium),
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(5.0))),
    );
  }
}
