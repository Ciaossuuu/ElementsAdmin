import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementsadmin/Models/lessonModel.dart';

class CourseModel {
  String title;
  String description;
  String organizationName;
  String courseImageUrl;
  bool subscribed;
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
}
