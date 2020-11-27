import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class QuizSeries {
  final String users;
  final int score;
  final charts.Color barColor;

  QuizSeries({
    @required this.users,
    @required this.score,
    this.barColor,
  });
}
