import 'package:elementsadmin/Strings/routes.dart';
import 'package:elementsadmin/Strings/textStyles.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  final int navItem;
  NavigationBar({@required this.navItem});
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  bool item1 = false, item2 = false, item3 = false, item4 = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switch (widget.navItem) {
      case 1:
        item1 = true;
        break;
      case 2:
        item2 = true;
        break;
      case 3:
        item3 = true;
        break;
      case 4:
        item4 = true;
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .2,
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
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    ' Elements++',
                    style: TextStyle(
                        fontFamily: 'IndieFlower',
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(height: size.height * .05),
              _buildButton(
                  text: 'Dashboard',
                  size: size,
                  color: Colors.purple,
                  izSelected: item1,
                  onpressed: () {
                    Navigator.pushNamed(context, Routes.dashboard);
                  }),
              SizedBox(height: size.height * .02),
              _buildButton(
                  izSelected: item2,
                  text: 'Learning Module',
                  color: Colors.purple,
                  size: size,
                  onpressed: () {
                    Navigator.pushNamed(context, Routes.courses);
                  }),
              SizedBox(height: size.height * .02),
              _buildButton(
                  izSelected: item3,
                  color: Colors.purple,
                  text: 'Challenge Module',
                  size: size,
                  onpressed: () {
                    Navigator.pushNamed(context, Routes.challenge);
                  }),
              SizedBox(height: size.height * .02),
              _buildButton(
                  izSelected: item4,
                  text: 'Users',
                  color: Colors.purple,
                  size: size,
                  onpressed: () {
                    Navigator.pushNamed(context, Routes.users);
                  }),
              SizedBox(height: size.height * .4),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: size.width * 0.08,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, Routes.def);
                    },
                    color: Colors.purple,
                    child: Padding(
                      padding: EdgeInsets.all(9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: size.width * 0.011,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: size.width * 0.01,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  _buildButton(
      {@required Size size,
      @required Function onpressed,
      @required bool izSelected,
      @required String text,
      @required Color color}) {
    return MaterialButton(
      elevation: 0,
      height: size.height * .075,
      minWidth: size.width * 0.2,
      color: izSelected ? Colors.purple[300] : Colors.white,
      highlightColor: Colors.purple,
      hoverColor: Colors.deepPurple[300],
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text,
            style: CustomTextStyles.customText(
                isBold: true, size: FontSizes.large)),
      ),
      onPressed: onpressed,
    );
  }
}
