import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementsadmin/Models/userModel.dart';
import 'package:flutter/material.dart';

class UsersDashboard extends StatefulWidget {
  @override
  _UsersDashboardState createState() => _UsersDashboardState();
}

class _UsersDashboardState extends State<UsersDashboard> {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Wrap(
              children: snapshot.data.docs
                  .map<Widget>((doc) => _displayUsers(
                        doc: doc,
                      ))
                  .toList(),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  _displayUsers({DocumentSnapshot doc}) {
    size = MediaQuery.of(context).size;
    UserModel user = UserModel.get(doc);
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center();
          } else {
            return Column(
              children: [
                Container(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(user.firstName + " " + user.lastName),
                    subtitle: Text(user.email),
                    // trailing: MaterialButton(
                    //   onPressed: () => _updateDialog(context, doc),
                    //   color: Colors.transparent,
                    //   textColor: Colors.yellow[700],
                    //   child: Icon(
                    //     Icons.edit,
                    //     size: 24,
                    //   ),
                    //   padding: EdgeInsets.all(10),
                    //   shape: CircleBorder(),
                    // ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                )
              ],
            );
          }
        });
  }
}
