import 'package:flutter/material.dart';

class QuestionModel {
  int sequence;
  String question;
  String correctAnswer;
  List choices;

  QuestionModel.getData(data) {
    this.sequence = data['sequence'];
    this.question = data['question'];
    this.correctAnswer = data['correctAnswer'];
    this.choices = data['choices'];
  }

  QuestionModel() {}
  toMap({@required QuestionModel question}) {
    var map = {
      'sequence': question.sequence,
      'question': question.question,
      'correctAnswer': question.correctAnswer,
      'choices': question.choices
    };
    return map;
  }
}
