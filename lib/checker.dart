// import the package
import 'package:elementsadmin/Tablet/home.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:elementsadmin/Desktop/home.dart';
import 'phone/home.dart';
// Use the widget
class Checker extends StatelessWidget {
  const Checker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
  builder: (context, sizingInformation) {
    if (sizingInformation.deviceScreenType == DeviceScreenType.Desktop) {
          return DesktopHome();
        }

        if (sizingInformation.deviceScreenType == DeviceScreenType.Tablet) {
          return TabletHome();
        }

       

          return PhoneHome();
  }
    );
  }
}