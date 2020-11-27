import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectProgressCard extends StatefulWidget {
  final Color color;
  final String projectName;
  final String value;
  final IconData icon;
  final Color iconColor;
  final onPressed;
  ProjectProgressCard(
      {this.color,
      this.projectName,
      this.value,
      this.icon,
      this.iconColor,
      this.onPressed});
  @override
  _ProjectProgressCardState createState() => _ProjectProgressCardState();
}

class _ProjectProgressCardState extends State<ProjectProgressCard> {
  bool hovered = false;
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return MouseRegion(
      onEnter: (value) {
        setState(() {
          hovered = true;
        });
      },
      onExit: (value) {
        setState(() {
          hovered = false;
        });
      },
      child: MaterialButton(
        hoverColor: Colors.transparent,
        elevation: 0,
        onPressed: widget.onPressed,
        child: AnimatedContainer(
          padding: EdgeInsets.fromLTRB(20, 20, 30, 20),
          duration: Duration(milliseconds: 275),
          height: hovered ? size.width * 0.12 : size.height * 0.23,
          width: hovered ? size.width * 0.215 : size.width * 0.21,
          decoration: BoxDecoration(
              color: hovered ? widget.color : Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 2.0,
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Text(
                            widget.projectName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.025,
                              color: hovered ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Text(
                      widget.value,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: size.width * 0.03,
                        color: hovered ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                widget.icon,
                size: size.width * 0.05,
                color: hovered ? Colors.white : widget.iconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
