import 'package:flutter/material.dart';


  buttons(BuildContext context, Color bcolor, icolor,Offset offset, double blur, String text, IconData icon, Widget route){
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return 
    Padding(
      padding: EdgeInsets.all(10),
      child:Container(
      height: height * .09,
      width: width,
        child:Container(
          height: height * .09,
          width: width,
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.circular(10.0),
              boxShadow: <BoxShadow>[BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                blurRadius: blur,
                offset: offset,
              ),]
            ),
          child: FlatButton(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            onPressed: () {
              Navigator.push(context,
              PageRouteBuilder(pageBuilder: (_,__,___) => route));
            
            },
            color: bcolor,
            child: Padding(
              padding: EdgeInsets.fromLTRB(2,2,2,2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    icon,
                    color: icolor,
                  ),
                  SizedBox(width: 50),
                  Text(
                    text.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14, 
                      color: icolor,
                    ),
                  ),
                  
                ],
              ),
            ), 
          ),
        )
      )
    );
  }
