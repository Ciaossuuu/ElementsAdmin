import 'package:elementsadmin/Models/lessonModel.dart';
import 'package:elementsadmin/Provider/learningProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateLesson extends StatefulWidget {
  CreateLesson({Key key}) : super(key: key);

  @override
  _CreateLessonState createState() => _CreateLessonState();
}

class _CreateLessonState extends State<CreateLesson> {
  final _formKeyLesson = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController(),
      descriptionController = TextEditingController(),
      videoUrlController = TextEditingController(),
      imageUrlController = TextEditingController(),
      questionController = TextEditingController(),
      choice1Controller = TextEditingController(),
      choice2Controller = TextEditingController(),
      choice3Controller = TextEditingController(),
      choice4Controller = TextEditingController(),
      correctAnswerController = TextEditingController();
  LearningProvider _learningProvider;
  @override
  Widget build(BuildContext context) {
    _learningProvider = Provider.of<LearningProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      title: Text('Add Lesson'),
      content: Container(
        width: size.width * .6,
        height: size.height * .7,
        child: SingleChildScrollView(
          child: Form(
            key: _formKeyLesson,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTextFormField(
                    controller: titleController, label: 'Lesson Title'),
                _buildTextFormField(
                    controller: descriptionController,
                    label: 'Lesson Description'),
                _buildTextFormField(
                    controller: videoUrlController, label: 'Lesson Video URL'),
                _buildTextFormField(
                    controller: imageUrlController, label: 'Lesson Image URL'),
                _buildTextFormField(
                    controller: questionController, label: 'Question'),
                Row(
                  children: [
                    Container(
                      width: size.width * .1,
                      child: _buildTextFormField(
                          controller: choice1Controller, label: 'Choice 1'),
                    ),
                    Container(
                      width: size.width * .1,
                      child: _buildTextFormField(
                          controller: choice2Controller, label: 'Choice 2'),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: size.width * .1,
                      child: _buildTextFormField(
                          controller: choice3Controller, label: 'Choice 3'),
                    ),
                    Container(
                      width: size.width * .1,
                      child: _buildTextFormField(
                          controller: choice4Controller, label: 'Choice 4'),
                    )
                  ],
                ),
                _buildTextFormField(
                    controller: correctAnswerController,
                    label: 'Correct Answer'),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        MaterialButton(
            color: Colors.redAccent,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('CANCEL'),
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        MaterialButton(
            color: Colors.blueAccent,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('ADD'),
            ),
            onPressed: () {
              _formKeyLesson.currentState.validate();
              _addLesson();
            })
      ],
    );
  }

  _buildTextFormField(
      {@required TextEditingController controller, @required String label}) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null) {
          return 'Should not be empty';
        }
        return null;
      },
      decoration: InputDecoration(labelText: label),
    );
  }

  _addLesson() {
    print('form ${_formKeyLesson.currentState.validate()}');
    LessonModel lesson = LessonModel();
    lesson.title = titleController.text;
    lesson.description = descriptionController.text;
    lesson.videoUrl = videoUrlController.text;
    lesson.imageUrl = imageUrlController.text;
    lesson.question = questionController.text;
    List choices = [
      choice1Controller.text,
      choice2Controller.text,
      choice3Controller.text,
      choice4Controller.text,
    ];
    lesson.choices = choices;
    lesson.sequence = _learningProvider.lessons.length;
    lesson.correctAnswer = correctAnswerController.text;

    _learningProvider.addLesson(lesson: lesson);
    Navigator.pop(context);
  }
}
