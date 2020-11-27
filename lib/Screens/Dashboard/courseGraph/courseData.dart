import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class CourseSeries {
  final String course;
  final int lesson;
  final charts.Color barColor;

  CourseSeries({
    @required this.course,
    @required this.lesson,
    this.barColor,
  });
}
