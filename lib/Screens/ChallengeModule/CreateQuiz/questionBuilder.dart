import 'package:elementsadmin/Models/questionModel.dart';
import 'package:elementsadmin/Provider/questionProvider.dart';
import 'package:elementsadmin/Screens/ChallengeModule/CreateQuiz/createQuestion.dart';
import 'package:elementsadmin/Strings/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionBuilder extends StatefulWidget {
  @override
  _QuestionBuilderState createState() => _QuestionBuilderState();
}

class _QuestionBuilderState extends State<QuestionBuilder> {
  QuestionProvider questionProvider;
  String sequence, question, correctAnswer;
  List<String> choices = [];
  List questions;
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    questionProvider = Provider.of<QuestionProvider>(context, listen: true);
    this.questions = questionProvider.questions;
    return Container(
      width: size.width * 0.4,
      height: size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Questions",
                    style: CustomTextStyles.customText(
                        isBold: true, size: FontSizes.subHeading),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.all(15),
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.add, color: Colors.white),
                        Text('Add',
                            style: TextStyle(
                              color: Colors.white,
                            ))
                      ],
                    ),
                    onPressed: () {
                      var baseDialog = CreateQuestion();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => baseDialog);
                    },
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return _buildQuestion(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildQuestion(index) {
    QuestionModel q = this.questions[index];
    return Card(
      child: ListTile(
        title: Text('Question: ${q.question}' ?? ''),
        subtitle: Text('Correct Answer: ${q.correctAnswer}' ?? ''),
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('${q.sequence ?? ''}')],
        ),
      ),
    );
  }
}
