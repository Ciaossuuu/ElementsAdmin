import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementsadmin/Models/courseModel.dart';
import 'package:elementsadmin/Models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  CollectionReference lesson = FirebaseFirestore.instance.collection('lessons');
  CollectionReference courses =
      FirebaseFirestore.instance.collection('courses');
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference quizzes =
      FirebaseFirestore.instance.collection('quizzes');
  FirebaseAuth auth = FirebaseAuth.instance;
  UserModel user = UserModel();

  //add
  Future<void> addLesson(
      //String ref,
      DocumentSnapshot doc,
      int sequence,
      String title,
      String description,
      String videoUrl,
      String imageUrl,
      String question,
      List choices,
      String correctAnswer,
      bool izTaken) async {
    return lesson
        .doc(doc.id)
        .set({
          'sequence': sequence,
          'title': title,
          'description': description,
          'url': videoUrl,
          'imageUrl': imageUrl,
          'question': question,
          'choices': choices,
          'correctAnswer': correctAnswer,
          'izTaken': izTaken
        })
        .then((value) => print("Lesson Added"))
        .catchError((error) => print("Failed to add lesson: $error"));
  }

  //update
  Future<void> updateLesson(DocumentSnapshot doc, String sequence, String title,
      String video_url, String video_time, String header, String description) {
    return lesson
        .doc(doc.id)
        .update({
          'sequence': sequence,
          'title': title,
          'video_url': video_url,
          'video_time': video_time,
          'header': header,
          'description': description
        })
        .then((value) => print("Lesson Updated"))
        .catchError((error) => print("Failed to update lesson: $error"));
  }

  //delete
  Future<void> deleteLesson(DocumentSnapshot doc, String sequence) {
    return lesson
        .doc(doc.id)
        .delete()
        .then((value) => print("Lesson Deleted"))
        .catchError((error) => print("Failed to delete lesson: $error"));
  }

  //add courses
  Future<void> addCourses({@required CourseModel courseModel}) async {
    var map = await CourseModel.toMap(courseModel: courseModel);
    print(map.runtimeType);
    return courses.add(map).then((value) async {
      print('course added');
      //update now !
      await courses.doc(value.id).update({'ref': value.id}).then((value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .get()
            .then((value) {
          value.docs.forEach((user) {
            addCourseToUser(map: map, uid: user.id);
          });
        });
      });
    }).catchError((error) => print("Failed to add course: $error"));

    // .then((value) async {

    // });
  }

  void addCourseToUser({String uid, map}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('courses')
          .add(map)
          .then((value) => print('success added to users'));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addCoursesToUsers(
      title, description, organizationName, courseImageUrl) async {
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((doc) async {
        return users
            .doc(doc.id)
            .collection('courses')
            .add({
              'title': title,
              'description': description,
              'organizationName': organizationName,
              'courseImageUrl': courseImageUrl
            })
            .then((value) => print("User's Course Added"))
            .catchError((error) => print("Failed to add course: $error"));
      });
    });
  }

  Future<void> addQuizzes(DocumentSnapshot doc, String title, String level,
      int score, bool isTaken, List questions) async {
    return quizzes.doc(doc.id).set({
      'title': title,
      'level': level,
      'score': score,
      'isTaken': isTaken,
      'questions': questions,
    });
  }
}
