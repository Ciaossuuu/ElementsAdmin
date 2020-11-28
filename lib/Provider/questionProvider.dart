import 'package:elementsadmin/Models/questionModel.dart';
import 'package:elementsadmin/Models/quizModel.dart';
import 'package:flutter/material.dart';

class QuestionProvider extends ChangeNotifier {
  List<QuestionModel> questions = [];

  void addQuestion({@required QuestionModel question}) {
    this.questions.add(question);
    notifyListeners();
  }
}
