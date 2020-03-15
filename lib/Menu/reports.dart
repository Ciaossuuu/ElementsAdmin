
import 'dart:ui';
import 'package:flutter/material.dart';
import '../Shared/navbutton.dart';
import '../Menu/users.dart';
import '../Menu/lessons.dart';

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Scaffold(
      body: Stack(children: <Widget>[
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
                            buttons(context, Colors.red,Colors.white,Offset(1, 1), 2, 'Reports', Icons.dashboard, Reports()),
                            buttons(context,Colors.white,Colors.black,Offset(0, 0), 0,'Lessons', Icons.book, Lessons()),
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
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child:Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top:10),
                        height: queryData.size.height / 1.15 ,
                        child: ListView(
                          padding: EdgeInsets.all(10),
                          children: <Widget>[
                            GridView(
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: MediaQuery.of(context).size.width >= 1100 ? 3 : 
                            MediaQuery.of(context).size.width >= 600 ? 2 : 1
                          ),
                          children: <Widget>[
                            Card(
                              child: Text(
                                "Tile1",
                                style: TextStyle(
                                  color: Colors.green[900],
                                  fontSize: 20
                                ),
                              ),
                            ),
                            Card(
                              child: Text(
                                "Tile1",
                                style: TextStyle(
                                  color: Colors.green[900],
                                  fontSize: 20
                                ),
                              ),
                            ),
                            Card(
                              child: Text(
                                "Tile1",
                                style: TextStyle(
                                  color: Colors.green[900],
                                  fontSize: 20
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Container(
                            height: queryData.size.height,
                            width: queryData.size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.circular(10.0),
                              boxShadow: <BoxShadow>[BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                blurRadius: 2,
                                offset: Offset(1,1),
                              ),]
                            )
                          )
                        ),
                          ],
                        )
                      ),
                    ]
                  ) 
                )
              )
            )
          ]
        )
      ]),
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