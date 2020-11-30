import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementsadmin/Models/lessonModel.dart';
import 'package:flutter/material.dart';

class CourseModel {
  String title;
  String description;
  String organizationName;
  String courseImageUrl;
  bool subscribed;
  String ref;

  // List<String,LessonModel> lessons;
  List<LessonModel> lessons = [];
  CourseModel.getData({DocumentSnapshot doc}) {
    this.title = doc.data()['title'];
    this.courseImageUrl = doc.data()['courseImageUrl'];
    this.description = doc.data()['description'];
    this.organizationName = doc.data()['organizationName'];
    this.subscribed = doc.data()['subscribed'];
    //  this.lessons = doc.data()['lessons'];
    for (var item in doc.data()['lessons']) {
      // this.lessons.add(lesson);
      LessonModel less = LessonModel.getData(item);
      //print(less.runtimeType);
      lessons.add(less);
    }
    // print(lessons.length);
  }
  CourseModel() {}
  static toMap({@required CourseModel courseModel}) {
    List lessons = [];
    courseModel.lessons.forEach((lesson) {
      var less = LessonModel().toMap(lesson: lesson);
      lessons.add(less);
    });

    var course = {
      'title': courseModel.title,
      'description': courseModel.description,
      'organizationName': courseModel.organizationName,
      'courseImageUrl': courseModel.courseImageUrl,
      'lessons': lessons,
      'subscribed': false,
      'score': 0
    };

    return course;
  }

  static addRef({@required CourseModel courseModel, @required String ref}) {
    List lessons = [];
    courseModel.lessons.forEach((lesson) {
      var less = LessonModel().toMap(lesson: lesson);
      lessons.add(less);
    });

    var course = {
      'title': courseModel.title,
      'description': courseModel.description,
      'organizationName': courseModel.organizationName,
      'courseImageUrl': courseModel.courseImageUrl,
      'lessons': lessons,
      'subscribed': false,
      'score': 0,
      'ref': ref,
      'izCompleted': false
    };

    return course;
  }
}
