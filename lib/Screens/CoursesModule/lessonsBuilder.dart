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

  getSequence(seq) {
    this.sequence = seq;
  }

  getTitle(titles) {
    this.title = titles;
  }

  getDescription(desc) {
    this.description = desc;
  }

  getImageURL(image) {
    this.imageUrl = image;
  }

  getVideoURL(video) {
    this.videoUrl = video;
  }

  getQuestion(questions) {
    this.question = questions;
  }

  getCorrectAns(answer) {
    this.correctAnswer = answer;
  }

  getChoices(choice) {
    this.choices = choice;
  }

  getIzTaken(taken) {
    this.izTaken = taken;
  }

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
          Container(
            child: MaterialButton(
              color: Colors.greenAccent[400],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Add new Lesson'), Icon(Icons.add)],
              ),
              onPressed: () => _addLesson(context),
            ),
          ),
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
    showDialog<String>(
      context: context,
      child: Container(
        child: AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text('Add Lesson'),
          content: Container(
            width: size.width * .6,
            height: size.height * .7,
            child: SingleChildScrollView(
              child: Form(
                key: _formKeyLesson,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          width: size.width * 0.09,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'No.'),
                            onChanged: (seq) {
                              getSequence(seq);
                              lesson.sequence = int.parse(seq);
                            },
                          ),
                        ),
                        SizedBox(width: size.width * 0.01),
                        Container(
                          width: size.width * 0.5,
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Lesson Title'),
                            onChanged: (titles) {
                              getTitle(titles);
                              lesson.title = titles;
                            },
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Lesson Description'),
                      onChanged: (desc) {
                        getDescription(desc);
                        lesson.description = desc;
                      },
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: "Lesson Video URL"),
                      onChanged: (video) {
                        getVideoURL(video);
                      },
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Lesson Image URL'),
                      onChanged: (image) {
                        getImageURL(image);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Question'),
                      onChanged: (String question) {
                        getQuestion(question);
                      },
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * .1,
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Choice 1'),
                            validator: (value) {
                              choices.add(value);
                              return;
                            },
                          ),
                        ),
                        Container(
                          width: size.width * .1,
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Choice 2'),
                            validator: (value) {
                              choices.add(value);
                              return;
                            },
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * .1,
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Choice 3'),
                            validator: (value) {
                              choices.add(value);
                              return;
                            },
                          ),
                        ),
                        Container(
                          width: size.width * .1,
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Choice 4'),
                            validator: (value) {
                              choices.add(value);
                              return;
                            },
                          ),
                        )
                      ],
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Correct Answer'),
                      onChanged: (String correctAnswer) {
                        getCorrectAns(correctAnswer);
                      },
                    ),
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
                  _formKeyLesson.currentState.validate();
                  _learningProvider.addLesson(lesson: lesson);
                  //DatabaseService().addLesson(sequence, title, description, videoUrl, imageUrl, question, choices, correctAnswer, izTaken);
                  print(lesson.sequence);
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
