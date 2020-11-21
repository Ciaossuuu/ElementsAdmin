import 'package:elementsadmin/Models/lessonModel.dart';
import 'package:flutter/material.dart';

class LearningProvider extends ChangeNotifier {
  List<LessonModel> lessons = [];

  void addLesson({@required LessonModel lesson}) {
    this.lessons.add(lesson);
    notifyListeners();
  }
}
