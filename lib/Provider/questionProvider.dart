import 'package:elementsadmin/Models/quizModel.dart';
import 'package:flutter/material.dart';

class QuestionProvider extends ChangeNotifier {
  List<QuizModel> quizzes = [];

  void addLesson({@required QuizModel quiz}) {
    this.quizzes.add(quiz);
    notifyListeners();
  }
}
