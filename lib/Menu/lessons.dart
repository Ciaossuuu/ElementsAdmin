
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:easy_dialog/easy_dialog.dart';
import '../Shared/navbutton.dart';
import '../Shared/customexpansiontile.dart' as custom;
import '../Menu/reports.dart';
import '../Menu/users.dart';
import '../Menu/lessons.dart';



class Lessons extends StatefulWidget {
  @override
  _LessonsState createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: width,
            height: height,
            color: Colors.grey[200],
          ),
          Row(
            children: <Widget>[
              Container(
                width: width * .20,
                child: Container(
                  width: width * .20,
                  height: height,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: width * .05,
                            height: height * .10,
                            child: Center(
                              child: Image(
                                image: AssetImage('assets/logos.png'),
                              ),
                            ),
                          ),
                          Text(
                            'Elements++',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      horizontalLine(),
                      Container(
                        height: height * .15,
                        child: Padding(
                          padding:  EdgeInsets.all(15),
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Image(image: AssetImage('assets/admin.png')),
                                Container(
                                  height: queryData.size.height / 5,
                                  width: queryData.size.width / 8.5,
                                    // width: (width * .2) * .8,
                                    // height: height * .10,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'David M. Grey',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold, fontSize: 10),
                                          ),
                                          Text('Project Manager'),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      horizontalLine(),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              buttons(context, Colors.white,Colors.black,Offset(0, 0), 0, 'Reports', Icons.dashboard, Reports()),
                              buttons(context,Colors.red,Colors.white,Offset(1, 1), 2,'Lessons', Icons.book, Lessons()),
                              buttons(context,Colors.white,Colors.black,Offset(0, 0), 0,'Users', Icons.people, Users()),
                            ],
                          )
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                width: queryData.size.width / 1.25,
                height: queryData.size.height,
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Container(
                    width: queryData.size.width,
                    height: queryData.size.height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: custom.ExpansionTile(    
                      headerBackgroundColor: Colors.black,
          iconColor: Colors.white,       
    title: Container(
        child: Text(
            "getCategory(i)",
            style: TextStyle(
            color: Colors.white,
            ),
        ),
        color: Colors.black
    ),
    
    children: <Widget>[
        new Container(
            height: 60.0,
            margin: const EdgeInsets.only(top:10.0, left: 10.0, right:10.0, bottom: 10.0),
            decoration: BoxDecoration(                    
            color: Colors.blue,
            borderRadius: new BorderRadius.all(  Radius.circular(5.0) ),
            ),
        ),
        new Container(
            height: 60.0,
            margin: const EdgeInsets.only(top:10.0, left: 10.0, right:10.0, bottom: 0.0),
            decoration: BoxDecoration(                    
            color: Colors.green,
            borderRadius: new BorderRadius.all(  Radius.circular(5.0) ),
            ),
        )
    ],
    backgroundColor: Colors.white,
)
                  )
                ),
              )
            ]
          )
        ]
      )
    );
  }
  horizontalLine(){
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
        padding:EdgeInsets.symmetric(horizontal:10.0),
        child:Container(
        height:1.0,
        width:width,
        color:Colors.black,
      ),
    );
  }
}