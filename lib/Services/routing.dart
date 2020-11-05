import 'package:elementsadmin/Screens/CoursesModule/courseBuilder.dart';
import 'package:elementsadmin/Screens/CoursesModule/coursesModule.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:elementsadmin/Strings/routes.dart';
import 'package:elementsadmin/Screens/Authentication/login.dart';
import 'package:elementsadmin/Screens/LessonsModule/lessonsModule.dart';
import 'package:elementsadmin/Screens/ChallengeModule/challengemodule.dart';
import 'package:elementsadmin/Screens/Users/users.dart';

class FluroRouter {
  static Router router = Router();

  static Handler _signInHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          LoginPage());
  // static Handler _lessonsModule = Handler(
  //     handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
  //         LessonsModule());
  static Handler _challengeModule = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          ChallengeModule());
  static Handler _coursesModule = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          CoursesModule());
  static Handler _users = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Users());
  static Handler _courseBuilder = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          CourseBuilder());

//-----------------------Routenames----------------------------------------//
  static void setupRouter() {
    router.define(Routes.def,
        handler: _signInHandler, transitionType: TransitionType.fadeIn);
    // router.define(Routes.lessons,
    //     handler: _lessonsModule, transitionType: TransitionType.fadeIn);
    router.define(Routes.challenge,
        handler: _challengeModule, transitionType: TransitionType.fadeIn);
    router.define(Routes.courses,
        handler: _coursesModule, transitionType: TransitionType.fadeIn);
    router.define(Routes.users,
        handler: _users, transitionType: TransitionType.fadeIn);
    router.define(Routes.courseBuilder,
        handler: _courseBuilder, transitionType: TransitionType.cupertino);
  }
}
