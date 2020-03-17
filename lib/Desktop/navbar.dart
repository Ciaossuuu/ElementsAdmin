import 'package:flutter/material.dart';
import 'package:elementsadmin/sizes.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   //init this first to get data
    Size size = new Size(context);

 
    return Column(
      children: <Widget>[
         Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: size.width * .05,
                          height: size.height * .10,
                          child: Center(
                            child: Image(
                              image: AssetImage('assets/logos.png'),
                            ),
                          ),
                        ),
                        Text(
                          'Elements++',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
      Container(
                      height: size.height * .15,
                      color: Colors.white,
                      child: Padding(
                        padding:  EdgeInsets.all(15),
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Image(image: AssetImage('assets/admin.png')),
                              Container(
                                height: size.height/ 5,
                                width: size.width / 8.5,
                                  // width: (width * .2) * .8,
                                  // height: height * .10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'David M. Greyyyy',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold, fontSize: 10),
                                        ),
                                        Text('Project Manager'),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
      ],
    );
  }
}
