import 'package:flutter/material.dart';
import 'package:elementsadmin/Desktop/navbar.dart';
class DesktopHome extends StatelessWidget {
  const DesktopHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      width: width,
      color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          Container(
            width: width*.2,
            height: height,
            color: Colors.red,
            child: NavBar(),
          ),
              
        ],
      ),
    );
  }
}
