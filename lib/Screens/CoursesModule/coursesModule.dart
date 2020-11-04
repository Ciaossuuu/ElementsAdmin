import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementsadmin/Screens/elementsAppBar.dart';
import 'package:elementsadmin/Screens/navigationBar.dart';

import 'package:flutter/material.dart';

class CoursesModule extends StatefulWidget {
  CoursesModule({Key key}) : super(key: key);

  @override
  _CourseModuleState createState() => _CourseModuleState();
}

class _CourseModuleState extends State<CoursesModule> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * .1),
          child: ElementsAppBar()),
      body: Row(
        children: [
          NavigationBar(),
          Center(
            child: Container(
              width: size.width * .8,
              color: Colors.blueAccent,
              height: size.height,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('courses')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Wrap(
                            children: snapshot.data.docs
                                .map<Widget>((doc) => _courseBuilder(
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
        ],
      ),
    );
  }

  _courseBuilder({DocumentSnapshot doc}) {
    //  print(doc.data());
    return Card(
      child: Container(
        width: 250,
        height: 250,
        color: Colors.red,
        child: Text('data'),
      ),
    );
  }
}
