import 'package:cloud_firestore/cloud_firestore.dart';

class QuizModel {
  String title;
  String level;
  int score;
  bool isTaken;
  List questions;

  QuizModel.getData({DocumentSnapshot doc}) {
    this.title = doc.data()['title'];
    this.level = doc.data()['level'];
    this.score = doc.data()['score'];
    this.isTaken = doc.data()['isTaken'];
    this.questions = doc.data()['questions'];
  }
}
