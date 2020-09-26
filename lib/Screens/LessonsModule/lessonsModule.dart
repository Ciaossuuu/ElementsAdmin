import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementsadmin/Models/model.dart';
import 'package:elementsadmin/Services/services.dart';
import 'package:elementsadmin/Strings/textStyles.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';

class LessonsModule extends StatefulWidget {
  LessonsModule({Key key}) : super(key: key);

  @override
  _LessonsModuleState createState() => _LessonsModuleState();
}

class _LessonsModuleState extends State<LessonsModule> {
  CollectionReference users = FirebaseFirestore.instance.collection('lessons');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> choices = [];
  String sequence,
      title,
      video_url,
      video_time,
      header,
      description,
      banner_url,
      question,
      correctAnswer;
  Size size;

  getSequence(number) {
    this.sequence = number;
  }

  getTitle(titles) {
    this.title = titles;
  }

  getVideoReference(videoRef) {
    this.video_url = videoRef;
  }

  getVideoTime(videoTime) {
    this.video_time = videoTime;
  }

  getHeader(headers) {
    this.header = headers;
  }

  getDesc(desc) {
    this.description = desc;
  }

  getBanner(banner) {
    this.banner_url = banner;
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

  /*_toggleSwitch() {
    setState(() {
      isEnabled = !isEnabled;
      print("isEnabled : $isEnabled");
    });
  }*/

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        title: Text(
          ' Elements++',
          style: TextStyle(
              fontFamily: 'IndieFlower',
              fontSize: 35,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            width: size.width * .17,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipOval(
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.red,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'John Doe',
                      style: CustomTextStyles.customText(
                          isBold: true,
                          size: FontSizes.medium,
                          color: Colors.white),
                    ),
                    Text('Admin')
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_drop_down, size: 20),
                )
              ],
            ),
          )
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width * .22,
            height: size.height,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 2,
                color: Colors.grey,
                offset: Offset(2, 0),
              )
            ]),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    color: Colors.deepPurple[400],
                    highlightColor: Colors.purple,
                    hoverColor: Colors.deepPurple[300],
                    height: size.height * .075,
                    minWidth: size.width * 0.1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Lessons Module',
                          style: CustomTextStyles.customText(
                              isBold: true, size: FontSizes.large)),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/lessons'),
                  ),
                  SizedBox(height: size.height * .01),
                  MaterialButton(
                    height: size.height * .075,
                    minWidth: size.width * 0.2,
                    highlightColor: Colors.purple,
                    hoverColor: Colors.deepPurple[300],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Challenge Module',
                          style: CustomTextStyles.customText(
                              isBold: true, size: FontSizes.large)),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/challenge'),
                  ),
                  SizedBox(height: size.height * .01),
                  MaterialButton(
                    height: size.height * .075,
                    minWidth: size.width * 0.2,
                    highlightColor: Colors.purple,
                    hoverColor: Colors.deepPurple[300],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Users',
                          style: CustomTextStyles.customText(
                              isBold: true, size: FontSizes.large)),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/users'),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: size.width * .6,
            height: size.height,
            child: Center(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('lessons')
                      .orderBy('sequence')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Wrap(
                            children: snapshot.data.docs
                                .map((doc) => _lessonCard(
                                      doc: doc,
                                    ))
                                .toList()),
                      );
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ),
          SizedBox(
            width: size.width * .08,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent[400],
        onPressed: () => _addDialog(
          context,
        ),
        child: Icon(Icons.add),
      ),
    );
  }

  //Add Dialog
  _addDialog(BuildContext context) {
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
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          width: size.width * .09,
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Lesson No.'),
                            onChanged: (String sequence) {
                              getSequence(sequence);
                            },
                          ),
                        ),
                        SizedBox(width: size.width * .01),
                        Container(
                          width: size.width * .5,
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Title'),
                            onChanged: (String title) {
                              getTitle(title);
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * .09,
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Video Time'),
                            onChanged: (String video_time) {
                              getVideoTime(video_time);
                            },
                          ),
                        ),
                        SizedBox(width: size.width * .01),
                        Container(
                          width: size.width * .5,
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Video URL'),
                            onChanged: (String video_url) {
                              getVideoReference(video_url);
                            },
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Header'),
                      onChanged: (String header) {
                        getHeader(header);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Description'),
                      onChanged: (String description) {
                        getDesc(description);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Banner URL'),
                      onChanged: (String banner_url) {
                        getBanner(banner_url);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Question'),
                      onChanged: (String question) {
                        getDesc(question);
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
                        getBanner(correctAnswer);
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
                  _formKey.currentState.validate();
                  DatabaseService().addLesson(
                      sequence,
                      title,
                      video_url,
                      video_time,
                      header,
                      description,
                      banner_url,
                      question,
                      choices,
                      correctAnswer);
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }

  //Update Dialog
  _updateDialog(BuildContext context, DocumentSnapshot doc) {
    LessonModel lesson = LessonModel.getData(doc: doc);
    bool isEnabled = false;
    showDialog<String>(
      context: context,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text('Update Lesson'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: size.width * .6,
              height: size.height * .7,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    CustomSwitch(
                      activeColor: Colors.greenAccent,
                      value: isEnabled,
                      onChanged: (value) {
                        setState(() {
                          isEnabled = value;
                        });
                      },
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * .09,
                          child: TextFormField(
                            enabled: isEnabled,
                            initialValue: lesson.sequence,
                            decoration:
                                InputDecoration(labelText: 'Lesson No.'),
                            onChanged: (String sequence) {
                              getSequence(sequence);
                            },
                          ),
                        ),
                        SizedBox(width: size.width * .01),
                        Container(
                          width: size.width * .5,
                          child: TextFormField(
                            enabled: isEnabled,
                            initialValue: lesson.title,
                            decoration: InputDecoration(labelText: 'Title'),
                            onChanged: (String title) {
                              getTitle(title);
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * .09,
                          child: TextFormField(
                            enabled: isEnabled,
                            initialValue: lesson.video_time,
                            maxLines: 3,
                            decoration:
                                InputDecoration(labelText: 'Video Time'),
                            onChanged: (String video_time) {
                              getVideoTime(video_time);
                            },
                          ),
                        ),
                        SizedBox(width: size.width * .01),
                        Container(
                          width: size.width * .5,
                          child: TextFormField(
                            enabled: isEnabled,
                            initialValue: lesson.video_url,
                            maxLines: 3,
                            decoration: InputDecoration(labelText: 'Video URL'),
                            onChanged: (String video_url) {
                              getVideoReference(video_url);
                            },
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      enabled: isEnabled,
                      initialValue: lesson.header,
                      decoration: InputDecoration(labelText: 'Header'),
                      onChanged: (String header) {
                        getHeader(header);
                      },
                    ),
                    TextFormField(
                      enabled: isEnabled,
                      initialValue: lesson.description,
                      minLines: 3,
                      maxLines: 5,
                      decoration: InputDecoration(labelText: 'Description'),
                      onChanged: (String description) {
                        getDesc(description);
                      },
                    ),
                    TextFormField(
                      enabled: isEnabled,
                      initialValue: lesson.banner_url,
                      minLines: 2,
                      maxLines: 3,
                      decoration: InputDecoration(labelText: 'Banner URL'),
                      onChanged: (String banner_url) {
                        getBanner(banner_url);
                      },
                    ),
                    TextFormField(
                      enabled: isEnabled,
                      initialValue: lesson.question,
                      decoration: InputDecoration(labelText: 'Question'),
                      onChanged: (String question) {
                        getDesc(question);
                      },
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * .1,
                          child: TextFormField(
                            enabled: isEnabled,
                            initialValue: lesson.choices[0],
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
                            enabled: isEnabled,
                            initialValue: lesson.choices[1],
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
                            enabled: isEnabled,
                            initialValue: lesson.choices[2],
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
                            enabled: isEnabled,
                            initialValue: lesson.choices[3],
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
                      enabled: isEnabled,
                      initialValue: lesson.correctAnswer,
                      decoration: InputDecoration(labelText: 'Correct Answer'),
                      onChanged: (String correctAnswer) {
                        getBanner(correctAnswer);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('UPDATE'),
              onPressed: () {
                DatabaseService().updateLesson(doc, sequence, title, video_url,
                    video_time, header, description);
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  _deleteDialog(BuildContext context, DocumentSnapshot doc) {
    LessonModel lesson = LessonModel.getData(doc: doc);
    showDialog<String>(
        context: context,
        child: AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text(
              'Are you sure you want to delete Lesson ${lesson.sequence}?'),
          actions: <Widget>[
            new FlatButton(
                child: const Text('NO'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('YES'),
                onPressed: () {
                  DatabaseService().deleteLesson(doc, sequence);
                  Navigator.pop(context);
                }),
          ],
        ));
  }

  //Lesson Cards
  Widget _lessonCard({DocumentSnapshot doc}) {
    LessonModel lesson = LessonModel.getData(doc: doc);
    Future getData() async {
      var database = FirebaseFirestore.instance;
      QuerySnapshot snapshot = await database.collection('lessons').get();
      return snapshot.docs;
    }

    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SizedBox(
              height: 210.0,
              width: 200.0,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                height: size.height * .37,
                width: size.width * .17,
                child: GridView.count(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 1,
                    children: [
                      Card(
                          elevation: 2,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Lesson ' + lesson.sequence,
                                  style: CustomTextStyles.customText(
                                    size: FontSizes.large,
                                    isBold: true,
                                  ),
                                ),
                                Text(lesson.title, textAlign: TextAlign.center),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      child: Wrap(
                                          runSpacing: 5,
                                          spacing: 7,
                                          children: [
                                            RaisedButton.icon(
                                                elevation: 1.0,
                                                icon:
                                                    Icon(Icons.edit, size: 16),
                                                color: Colors.yellow,
                                                label: Text('Update',
                                                    style: TextStyle(
                                                        fontSize: 12.0)),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                onPressed: () => _updateDialog(
                                                    context, doc)),
                                            RaisedButton.icon(
                                              elevation: 1.0,
                                              icon:
                                                  Icon(Icons.delete, size: 16),
                                              color: Colors.red,
                                              label: Text('Delete',
                                                  style: TextStyle(
                                                      fontSize: 12.0)),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              onPressed: () =>
                                                  _deleteDialog(context, doc),
                                            ),
                                          ]),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ))
                    ])),
          );
        }
      },
    );
  }
}
