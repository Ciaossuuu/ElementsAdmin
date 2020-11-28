import 'package:elementsadmin/Models/questionModel.dart';
import 'package:elementsadmin/Models/quizModel.dart';
import 'package:elementsadmin/Provider/questionProvider.dart';
import 'package:elementsadmin/Screens/ChallengeModule/CreateQuiz/createQuestion.dart';
import 'package:elementsadmin/Screens/ChallengeModule/CreateQuiz/questionBuilder.dart';
import 'package:elementsadmin/Services/services.dart';
import 'package:elementsadmin/Strings/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizBuilder extends StatefulWidget {
  @override
  _QuizBuilderState createState() => _QuizBuilderState();
}

class _QuizBuilderState extends State<QuizBuilder> {
  final GlobalKey<FormState> _formKeyQuiz = GlobalKey<FormState>();
  TextEditingController level = TextEditingController(),
      title = TextEditingController();
  QuestionProvider _questionsProvider;

  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    _questionsProvider = Provider.of<QuestionProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * .05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("New Quiz",
                  style: CustomTextStyles.customText(
                      isBold: true, size: FontSizes.heading)),
              Container(
                  width: size.width * 0.9,
                  child: Divider(thickness: 1, color: Colors.grey)),
              SizedBox(height: size.height * 0.04),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: size.width * .45,
                      height: size.height * .25,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2,
                                color: Colors.grey,
                                offset: Offset(2, 2),
                                spreadRadius: 1)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Form(
                          key: _formKeyQuiz,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Let’s create a quiz",
                                style: CustomTextStyles.customText(
                                    isBold: true, size: FontSizes.subHeading),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: size.width * .1,
                                    child: _buildTextFormField(
                                        controller: level,
                                        label: 'Difficulty Level'),
                                  ),
                                  Container(
                                    width: size.width * .3,
                                    child: _buildTextFormField(
                                      controller: title,
                                      label: 'Title',
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      //color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  QuestionBuilder(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      color: Colors.red,
                      child: Text('CANCEL',
                          style: CustomTextStyles.customText(
                              isBold: true, size: FontSizes.small)),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  SizedBox(width: size.width * 0.02),
                  MaterialButton(
                      color: Colors.green,
                      child: Text('SAVE',
                          style: CustomTextStyles.customText(
                              isBold: true, size: FontSizes.small)),
                      onPressed: () {
                        _formKeyQuiz.currentState.validate();
                        if (title.text != '') {
                          QuizModel quiz = QuizModel();
                          quiz.level = level.text;
                          quiz.title = title.text;
                          quiz.questions = _questionsProvider.questions;

                          DatabaseService()
                              .addQuizzes(quizModel: quiz)
                              .then((value) {
                            showAlertDialog(
                              context: context,
                              message: 'Quiz Added',
                              title: 'Success',
                            );
                          });
                          Future.delayed(Duration(milliseconds: 2500), () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                        } else {
                          showAlertDialog(
                              context: context,
                              message: 'Please Input a Quiz',
                              title: 'Error');
                        }
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildTextFormField(
      {@required TextEditingController controller,
      @required String label,
      int maxLines}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: CustomTextStyles.customText(size: FontSizes.medium),
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(5.0))),
      validator: (value) {
        if (value.length == 0) {
          return 'Should not be empty';
        }
        return null;
      },
    );
  }

  showAlertDialog(
      {@required BuildContext context,
      @required String title,
      @required String message}) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
