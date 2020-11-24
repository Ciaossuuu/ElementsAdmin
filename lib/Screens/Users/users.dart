import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementsadmin/Models/userModel.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:elementsadmin/Services/services.dart';
import 'package:elementsadmin/Services/userService.dart';
import 'package:elementsadmin/Strings/routes.dart';
import 'package:elementsadmin/Strings/textStyles.dart';
import 'package:flutter/material.dart';

import '../navigationBar.dart';

class Users extends StatefulWidget {
  Users({Key key}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  CollectionReference users = FirebaseFirestore.instance.collection('lessons');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Size size;
  String firstName, lastName, email;

  getFirstName(fn) {
    this.firstName = fn;
  }

  getLastName(ln) {
    this.lastName = ln;
  }

  getEmail(mail) {
    this.email = mail;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavigationBar(navItem: 4),
          Center(
            child: Container(
              width: size.width * .8,
              height: size.height,
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
                child: Column(
                  children: [
                    Container(
                      width: size.width * .7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Users',
                            style: CustomTextStyles.customText(
                                size: FontSizes.heading, isBold: true),
                          ),
                          SizedBox()
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          width: size.width * 0.7,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return SingleChildScrollView(
                                      child: Wrap(
                                          children: snapshot.data.docs
                                              .map<Widget>(
                                                  (doc) => _displayUsers(
                                                        doc: doc,
                                                      ))
                                              .toList()));
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              })),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Lesson Cards
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
                    trailing: MaterialButton(
                      onPressed: () => _updateDialog(context, doc),
                      color: Colors.transparent,
                      textColor: Colors.yellow[700],
                      child: Icon(
                        Icons.edit,
                        size: 24,
                      ),
                      padding: EdgeInsets.all(10),
                      shape: CircleBorder(),
                    ),
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

  _updateDialog(BuildContext context, DocumentSnapshot doc) {
    UserModel user = UserModel.get(doc);
    bool isEnabled = false;
    showDialog<String>(
      context: context,
      child: StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Update Lessons'),
                CustomSwitch(
                  activeColor: Colors.greenAccent,
                  value: isEnabled,
                  onChanged: (value) {
                    setState(() {
                      isEnabled = value;
                    });
                  },
                ),
              ],
            ),
            content: Container(
              width: size.width * .3,
              height: size.height * .5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        width: size.width * .145,
                        child: TextFormField(
                          enabled: isEnabled,
                          initialValue: user.firstName,
                          decoration: InputDecoration(labelText: 'First Name'),
                          onChanged: (String fn) {
                            getFirstName(fn);
                          },
                        ),
                      ),
                      SizedBox(width: size.width * .01),
                      Container(
                        width: size.width * .145,
                        child: TextFormField(
                          enabled: isEnabled,
                          initialValue: user.lastName,
                          decoration: InputDecoration(labelText: 'Last Name'),
                          onChanged: (String ln) {
                            getLastName(ln);
                          },
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    enabled: isEnabled,
                    initialValue: user.email,
                    decoration: InputDecoration(labelText: 'Email'),
                    onChanged: (String mail) {
                      getEmail(mail);
                    },
                  ),
                ],
              ),
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
                    UserService().updateUsers(doc, firstName, lastName, email);
                    Navigator.pop(context);
                  })
            ]);
      }),
    );
  }
}
