import 'dart:ui';

import 'package:flutter/material.dart';
class Size{
  var  width ;
    var height;
Size(BuildContext context){
   height = MediaQuery.of(context).size.height;
   width = MediaQuery.of(context).size.width;
}

}