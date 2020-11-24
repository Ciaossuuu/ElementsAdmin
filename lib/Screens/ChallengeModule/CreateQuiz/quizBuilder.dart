import 'package:elementsadmin/Provider/questionProvider.dart';
import 'package:elementsadmin/Strings/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizBuilder extends StatefulWidget {
  @override
  _QuizBuilderState createState() => _QuizBuilderState();
}

class _QuizBuilderState extends State<QuizBuilder> {
  TextEditingController title = TextEditingController(),
      description = TextEditingController(),
      organizationName = TextEditingController(),
      coureImageUrl = TextEditingController();
  QuestionProvider questionProvider;
  List quizzes;
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    questionProvider = Provider.of<QuestionProvider>(context, listen: true);
    this.quizzes = questionProvider.quizzes;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Center(child: Text('Add')),
      ),
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
                                        controller: title,
                                        label: 'Difficulty Level'),
                                  ),
                                  Container(
                                    width: size.width * .3,
                                    child: _buildTextFormField(
                                      controller: description,
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
                  buildQuestions(),
                ],
              ),
              SizedBox(height: size.height * 0.05),
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
                      onPressed: () {}),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  buildQuestions() {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Questions",
                    style: CustomTextStyles.customText(
                        isBold: true, size: FontSizes.subHeading),
                  ),
                  MaterialButton(
                    color: Colors.green,
                    child: Text('Add Question',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
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
    return Card(
      child: ListTile(
        title: Text('Question: What am I?'),
        subtitle: Text('Correct Answer: stupid'),
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('1')],
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
    );
  }
}
