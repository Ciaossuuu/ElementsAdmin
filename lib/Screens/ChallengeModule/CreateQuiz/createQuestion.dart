import 'package:elementsadmin/Models/questionModel.dart';
import 'package:elementsadmin/Provider/questionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateQuestion extends StatefulWidget {
  @override
  _CreateQuestionState createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {
  final GlobalKey<FormState> _formKeyQuestion = GlobalKey<FormState>();
  QuestionProvider _questionProvider;
  TextEditingController questionController = TextEditingController(),
      choice1Controller = TextEditingController(),
      choice2Controller = TextEditingController(),
      choice3Controller = TextEditingController(),
      choice4Controller = TextEditingController(),
      correctAnswerController = TextEditingController();
  Size size;
  @override
  Widget build(BuildContext context) {
    _questionProvider = Provider.of<QuestionProvider>(context, listen: false);
    size = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      title: Text('Add a question'),
      content: Container(
        width: size.width * .4,
        height: size.height * .4,
        child: SingleChildScrollView(
          child: Form(
            key: _formKeyQuestion,
            child: Column(
              children: <Widget>[
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
        new FlatButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            }),
        new FlatButton(
            child: const Text('ADD'),
            onPressed: () {
              if (_formKeyQuestion.currentState.validate()) {
                Navigator.pop(context);
              }
              _addQuestion();
            }),
      ],
    );
  }

  _buildTextFormField(
      {@required TextEditingController controller, @required String label}) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value.length == 0) {
          return 'Should not be empty';
        }
        return null;
      },
      decoration: InputDecoration(labelText: label),
    );
  }

  _addQuestion() {
    print('form ${_formKeyQuestion.currentState.validate()}');
    QuestionModel question = QuestionModel();

    question.question = questionController.text;
    List choices = [
      choice1Controller.text,
      choice2Controller.text,
      choice3Controller.text,
      choice4Controller.text,
    ];
    question.choices = choices;
    question.sequence = _questionProvider.questions.length;
    question.correctAnswer = correctAnswerController.text;

    _questionProvider.addQuestion(question: question);
  }
}
