import 'package:elementsadmin/Screens/elementsAppBar.dart';
import 'package:elementsadmin/Strings/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:elementsadmin/Screens/navigationBar.dart';

class CourseBuilder extends StatefulWidget {
  CourseBuilder({Key key}) : super(key: key);

  @override
  _CourseBuilderState createState() => _CourseBuilderState();
}

class _CourseBuilderState extends State<CourseBuilder> {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 89, 82, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: size.height * .05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: size.width * .8,
                  height: size.height * .62,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(245, 180, 97, 1),
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        Text(
                          "Let’s create your course",
                          style: CustomTextStyles.customText(
                              isBold: true, size: FontSizes.heading),
                        ),
                        _buildTextFormField(label: 'Title'),
                        _buildTextFormField(label: 'Description', maxLines: 3),
                        _buildTextFormField(label: 'Organization Name'),
                        _buildTextFormField(label: 'Course Image Url'),
                      ],
                    ),
                  ),
                  //color: Colors.red,
                ),
              ),
              SizedBox(
                height: size.height * .1,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: size.width * .12),
                  child: Text(
                    'Lessons:',
                    style: CustomTextStyles.customText(
                        color: Colors.white,
                        isBold: true,
                        size: FontSizes.large),
                  ),
                ),
              ),
              _addButton(),
            ],
          ),
        ),
      ),
    );
  }

  _addButton() {
    return InkWell(
      splashColor: Colors.amber,
      onTap: () {},
      child: Container(
        width: size.width * .6,
        height: size.height * .075,
        decoration: BoxDecoration(
            color: Color.fromRGBO(154, 211, 188, 1),
            borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: ClipOval(
            child: Container(
              width: 50,
              height: 50,
              color: Color.fromRGBO(235, 89, 82, 1),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildTextFormField(
      {TextEditingController controller,
      @required String label,
      int maxLines}) {
    return TextFormField(
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          labelStyle: CustomTextStyles.customText(
              isBold: true, size: FontSizes.medium)),
    );
  }
}
