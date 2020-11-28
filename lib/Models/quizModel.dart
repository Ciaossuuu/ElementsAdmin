import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementsadmin/Models/questionModel.dart';
import 'package:flutter/material.dart';

class QuizModel {
  String title;
  String level;
  int score;
  bool isTaken;
  List<QuestionModel> questions = [];

  QuizModel.getData({DocumentSnapshot doc}) {
    this.title = doc.data()['title'];
    this.level = doc.data()['level'];
    this.score = doc.data()['score'];
    this.isTaken = doc.data()['isTaken'];
    //this.questions = doc.data()['questions'];
    for (var item in doc.data()['questions']) {
      // this.lessons.add(lesson);
      QuestionModel q = QuestionModel.getData(item);
      //print(less.runtimeType);
      questions.add(q);
    }
  }

  QuizModel() {}
  static toMap({@required QuizModel quizModel}) {
    List questions = [];
    quizModel.questions.forEach((question) {
      var q = QuestionModel().toMap(question: question);
      questions.add(q);
    });

    var quiz = {
      'title': quizModel.title,
      'level': quizModel.level,
      'score': 0,
      'isTaken': false,
      'questions': questions
    };

    return quiz;
  }
}
