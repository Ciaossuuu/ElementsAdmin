import 'package:elementsadmin/Strings/routes.dart';
import 'package:elementsadmin/Strings/textStyles.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget with PreferredSizeWidget {
  const NavigationBar({Key key}) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
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
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _buildButton(
              //     text: 'Lessons Module',
              //     size: size,
              //     onpressed: () {
              //       Navigator.pushNamed(context, Routes.lessons);
              //     }),
              //      SizedBox(height: size.height * .02),
              _buildButton(
                  text: 'Challenge Module',
                  size: size,
                  onpressed: () {
                    Navigator.pushNamed(context, Routes.challenge);
                  }),
              SizedBox(height: size.height * .02),
              _buildButton(
                  text: 'Users',
                  size: size,
                  onpressed: () {
                    Navigator.pushNamed(context, Routes.users);
                  }),
              SizedBox(height: size.height * .02),
              _buildButton(
                  text: 'Courses',
                  size: size,
                  onpressed: () {
                    Navigator.pushNamed(context, Routes.courses);
                  })
            ],
          )),
    );
  }

  _buildButton(
      {@required Size size,
      @required Function onpressed,
      @required String text}) {
    return MaterialButton(
      height: size.height * .075,
      minWidth: size.width * 0.2,
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
