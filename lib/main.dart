import 'package:elementsadmin/Provider/learningProvider.dart';
import 'package:elementsadmin/Screens/Dashboard/dashboard.dart';
import 'package:elementsadmin/Screens/LessonsModule/lessonsModule.dart';
import 'package:elementsadmin/Screens/Authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:elementsadmin/Services/routing.dart';
import 'package:provider/provider.dart';
import 'Strings/routes.dart';

void main() {
  FluroRouter.setupRouter();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LearningProvider>(
            create: (_) => LearningProvider()),
      ],
      child: MaterialApp(
          onGenerateRoute: FluroRouter.router.generator,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          title: 'Elements++ Admin',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Roboto',
          ),
          home: Dashboard()),
    );
  }
}
