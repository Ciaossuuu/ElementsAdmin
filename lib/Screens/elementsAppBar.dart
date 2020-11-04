import 'package:elementsadmin/Strings/textStyles.dart';
import 'package:flutter/material.dart';

class ElementsAppBar extends StatelessWidget {
  const ElementsAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.deepPurple,
      title: Text(
        ' Elements++',
        style: TextStyle(
            fontFamily: 'IndieFlower',
            fontSize: 35,
            fontWeight: FontWeight.bold),
      ),
      actions: [
        Container(
          width: size.width * .17,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipOval(
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.red,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'John Doe',
                    style: CustomTextStyles.customText(
                        isBold: true,
                        size: FontSizes.medium,
                        color: Colors.white),
                  ),
                  Text('Admin')
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_drop_down, size: 20),
              )
            ],
          ),
        )
      ],
    );
  }
}
