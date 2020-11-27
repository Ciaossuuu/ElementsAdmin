import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:elementsadmin/Screens/Dashboard/quizGraph/quizData.dart';

class QuizChart extends StatefulWidget {
  final String level;
  QuizChart({@required this.level});
  @override
  _QuizChartState createState() => _QuizChartState();
}

class _QuizChartState extends State<QuizChart> {
  final List<QuizSeries> data = [
    QuizSeries(
        users: 'rhowel',
        score: 5,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    QuizSeries(
        users: 'dean',
        score: 4,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    QuizSeries(
        users: 'elfel',
        score: 3,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    QuizSeries(
        users: 'axe',
        score: 2,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
  ];
  @override
  Widget build(BuildContext context) {
    return QuizBarGraph(
      data: data,
      level: widget.level,
    );
  }
}

class QuizBarGraph extends StatefulWidget {
  final List<QuizSeries> data;
  final String level;
  QuizBarGraph({@required this.data, @required this.level});
  @override
  _QuizBarGraphState createState() => _QuizBarGraphState();
}

class _QuizBarGraphState extends State<QuizBarGraph> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<QuizSeries, String>> series = [
      charts.Series(
          id: "Quizzes",
          data: widget.data,
          domainFn: (QuizSeries series, _) => series.users,
          measureFn: (QuizSeries series, _) => series.score,
          colorFn: (QuizSeries series, _) => series.barColor)
    ];
    return Stack(children: <Widget>[
      AnimatedPositioned(
        // use top,bottom,left and right property to set the location and Transform.rotate to rotate the widget if needed
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(widget.level),
        ),
        duration: Duration(seconds: 3),
      ),
      charts.BarChart(series, animate: true)
    ]);
  }
}
