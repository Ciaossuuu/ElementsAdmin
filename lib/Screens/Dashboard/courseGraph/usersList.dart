import 'package:elementsadmin/Strings/textStyles.dart';
import 'package:flutter/material.dart';

class ListOfUsers extends StatefulWidget {
  @override
  _ListOfUsersState createState() => _ListOfUsersState();
}

class _ListOfUsersState extends State<ListOfUsers> {
  int _value = 1;
  String dropdownValue = 'Course 1';
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * .05),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Send Certificate",
                  style: CustomTextStyles.customText(
                      isBold: true, size: FontSizes.heading)),
              Container(
                  width: size.width * 0.9,
                  child: Divider(thickness: 1, color: Colors.grey)),
              SizedBox(height: size.height * 0.04),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: size.width * .4,
                        height: size.height * .62,
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
                          child: _listOfUsers(),
                        ),
                      ),
                    ),
                  ])
            ]),
      ),
    );
  }

  _listOfUsers() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DropdownButton<String>(
            value: dropdownValue,
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: <String>['Course 1', 'Course 2', 'Course 3', 'Course 4']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Column(
            children: [
              _userCard(
                  fname: 'rhowel',
                  lname: 'parayno',
                  email: 'rhowep@gmail.com',
                  progress: 'Completed',
                  onPressed: () {}),
              _userCard(
                  fname: 'elfel',
                  lname: 'opleda',
                  email: 'eopleda@gmail.com',
                  progress: 'in Progress',
                  onPressed: null),
              _userCard(
                  fname: 'dean',
                  lname: 'villamia',
                  email: 'ianvillamia@gmail.com',
                  progress: 'in Progress',
                  onPressed: null),
              _userCard(
                  fname: 'axe',
                  lname: 'chuchu',
                  email: 'axechuchu@gmail.com',
                  progress: 'Completed',
                  onPressed: () {}),
              SizedBox(
                height: size.height * 0.02,
              )
            ],
          )
        ]);
  }

  _userCard(
      {@required String fname,
      @required String lname,
      @required String email,
      @required String progress,
      @required onPressed}) {
    return Container(
      width: size.width * 0.4,
      color: Colors.white,
      child: ListTile(
        title: Text('$fname $lname'),
        subtitle: Text('$email'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$progress'),
            MaterialButton(
              onPressed: onPressed,
              color: Colors.transparent,
              textColor: Colors.yellow[700],
              child: Icon(
                Icons.send,
                size: 24,
              ),
              padding: EdgeInsets.all(15),
              shape: CircleBorder(),
            ),
          ],
        ),
      ),
    );
  }
}
