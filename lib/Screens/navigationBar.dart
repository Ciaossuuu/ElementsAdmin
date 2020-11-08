import 'package:elementsadmin/Strings/routes.dart';
import 'package:elementsadmin/Strings/textStyles.dart';
import 'package:flutter/material.dart';

// class NavigationBar extends StatefulWidget {
//   const NavigationBar({Key key, this.color}) : super(key: key);
//   final Color color;
//   @override
//   _NavigationBarState createState() => _NavigationBarState();
// }

// class _NavigationBarState extends State<NavigationBar> {
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Container(
//       width: size.width * .2,
//       height: size.height,
//       decoration: BoxDecoration(color: Colors.white, boxShadow: [
//         BoxShadow(
//           spreadRadius: 1,
//           blurRadius: 2,
//           color: Colors.grey,
//           offset: Offset(2, 0),
//         )
//       ]),
//       child: Padding(
//           padding: const EdgeInsets.only(top: 30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     ' Elements++',
//                     style: TextStyle(
//                         fontFamily: 'IndieFlower',
//                         fontSize: 35,
//                         fontWeight: FontWeight.bold),
//                   )),
//               SizedBox(height: size.height * .05),
//               _buildButton(
//                   text: 'Dashboard',
//                   size: size,
//                   color: widget.color,
//                   onpressed: () {
//                     Navigator.pushNamed(context, Routes.def);
//                   }),
//               SizedBox(height: size.height * .02),
//               _buildButton(
//                   text: 'Courses Module',
//                   size: size,
//                   onpressed: () {
//                     Navigator.pushNamed(context, Routes.courses);
//                   }),
//               SizedBox(height: size.height * .02),
//               _buildButton(
//                   text: 'Challenge Module',
//                   size: size,
//                   onpressed: () {
//                     Navigator.pushNamed(context, Routes.challenge);
//                   }),
//               SizedBox(height: size.height * .02),
//               _buildButton(
//                   text: 'Users',
//                   size: size,
//                   onpressed: () {
//                     Navigator.pushNamed(context, Routes.users);
//                   }),
//             ],
//           )),
//     );
//   }
//  }
class NavigationButton {
  static buildButton(
      {@required Size size,
      @required Function onpressed,
      @required String text,
      @required Color color}) {
    return MaterialButton(
      elevation: 0,
      height: size.height * .075,
      minWidth: size.width * 0.2,
      color: color,
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
