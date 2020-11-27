import 'package:elementsadmin/Screens/Dashboard/courseGraph/courseData.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class CourseChart extends StatefulWidget {
  @override
  _CourseChartState createState() => _CourseChartState();
}

class _CourseChartState extends State<CourseChart> {
  final List<CourseSeries> data = [
    CourseSeries(
        course: 'course1',
        lesson: 3,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    CourseSeries(
        course: 'course2',
        lesson: 2,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    CourseSeries(
        course: 'course3',
        lesson: 2,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    CourseSeries(
        course: 'course4',
        lesson: 5,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
  ];
  @override
  Widget build(BuildContext context) {
    return CourseBarGraph(data: data);
  }
}

class CourseBarGraph extends StatefulWidget {
  final List<CourseSeries> data;
  CourseBarGraph({@required this.data});
  @override
  _CourseBarGraphState createState() => _CourseBarGraphState();
}

class _CourseBarGraphState extends State<CourseBarGraph> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<CourseSeries, String>> series = [
      charts.Series(
          id: "Courses",
          data: widget.data,
          domainFn: (CourseSeries series, _) => series.course,
          measureFn: (CourseSeries series, _) => series.lesson,
          colorFn: (CourseSeries series, _) => series.barColor)
    ];
    return charts.BarChart(series, animate: true);
  }
}
