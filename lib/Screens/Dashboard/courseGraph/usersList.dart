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
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          defaultColumnWidth: FixedColumnWidth(size.width * 0.13),
          border: TableBorder.all(
              color: Colors.black26, width: 1, style: BorderStyle.none),
          children: [
            TableRow(children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text('Last Name',
                          textScaleFactor: 1.5,
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ),
              ),
              TableCell(
                  child: Center(
                      child: Text('Email',
                          textScaleFactor: 1.5,
                          style: TextStyle(fontWeight: FontWeight.bold)))),
              TableCell(
                  child: Center(
                      child: Text('Completed',
                          textScaleFactor: 1.5,
                          style: TextStyle(fontWeight: FontWeight.bold))))
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCell(
                  child: Center(child: Text('villamia')),
                ),
              ),
              TableCell(
                child: Center(child: Text('deanvillamia@gmail.com')),
              ),
              TableCell(
                child: Center(child: Text('yes')),
              ),
            ]),
            TableRow(children: [
              TableCell(child: Center(child: Text('Value'))),
              TableCell(child: Center(child: Text('Value'))),
              TableCell(child: Center(child: Text('in progress'))),
            ]),
            TableRow(children: [
              TableCell(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text('Value')),
              )),
              TableCell(child: Center(child: Text('Value'))),
              TableCell(child: Center(child: Text('no'))),
            ])
          ],
        ),
      ],
    );
  }

  // _tableCell({@required String text}) { ayaw gumana
  //   Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Center(child: Text(text)),
  //   );
  // }
}
