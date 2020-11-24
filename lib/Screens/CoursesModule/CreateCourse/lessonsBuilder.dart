import 'package:elementsadmin/Models/lessonModel.dart';
import 'package:elementsadmin/Provider/learningProvider.dart';
import 'package:elementsadmin/Services/services.dart';
import 'package:elementsadmin/Strings/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LessonBuilder extends StatefulWidget {
  LessonBuilder({Key key, this.lessons}) : super(key: key);
  final List lessons;
  @override
  _LessonBuilderState createState() => _LessonBuilderState();
}

class _LessonBuilderState extends State<LessonBuilder> {
  final GlobalKey<FormState> _formKeyLesson = GlobalKey<FormState>();
  Size size;
  LearningProvider _learningProvider;
  String sequence,
      title,
      description,
      imageUrl,
      videoUrl,
      question,
      correctAnswer;
  bool izTaken = false;
  List<String> choices = [];

  List lessons;

  @override
  Widget build(BuildContext context) {
    _learningProvider = Provider.of<LearningProvider>(context, listen: true);
    this.lessons = _learningProvider.lessons;
    size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.4,
      height: size.height * 0.62,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Row(
                children: [
                  Text(
                    "Lessons",
                    style: CustomTextStyles.customText(
                        isBold: true, size: FontSizes.subHeading),
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //   child: MaterialButton(
          //     color: Colors.greenAccent[400],
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [Text('Add new Lesson'), Icon(Icons.add)],
          //     ),
          //     onPressed: () => _addLesson(context),
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                return _buildLesson(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildLesson(index) {
    LessonModel less = this.lessons[index];
    return Card(
      child: ListTile(
        title: Text(less.title ?? ''),
        subtitle: Text(less.description ?? ''),
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('${less.sequence ?? ''}')],
        ),
      ),
    );
  }

  _addLesson(BuildContext context) {
    bool dropdownValue = false;
    LessonModel lesson = LessonModel();
    //TextEditingController question = TextEditingController();
  }
}
