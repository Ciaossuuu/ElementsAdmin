import 'package:elementsadmin/Models/lessonModel.dart';
import 'package:flutter/material.dart';

class LearningProvider extends ChangeNotifier {
  LessonModel lesson;
  List lessons = [];

  LearningProvider() {
    LessonModel _lesson;
    _lesson.title = "h";
    _lesson.sequence = 1;
    _lesson.description = "1";
    _lesson.imageUrl = "1";
    _lesson.videoUrl = "1";
    this.lesson = _lesson;
    notifyListeners();
  }

  void addLesson(lesson) {
    this.lessons.add(lesson);
    notifyListeners();
  }
}
