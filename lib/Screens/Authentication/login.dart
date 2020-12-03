import 'dart:ui';

import 'package:elementsadmin/Strings/routes.dart';
import 'package:flutter/material.dart';
import 'package:elementsadmin/Screens/LessonsModule/lessonsModule.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

Size size;

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.2,
            child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/final-elements.appspot.com/o/background.jpg?alt=media&token=0e4acb08-a593-46b7-9712-c0586f368db7'),
                      fit: BoxFit.cover)),
            ),
          ),
          Center(
            child: Container(
              width: size.width * .3,
              height: size.height * .62,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Elements++',
                        style: TextStyle(
                            fontFamily: 'IndieFlower',
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * .03,
                      ),
                      Text(
                        'Welcome,',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Sign in to admin!',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height * .03),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8.0),
                          labelText: 'Username',
                        ),
                        style: TextStyle(fontSize: 15.0),
                        validator: (val) =>
                            val.isEmpty ? 'Username is required' : null,
                      ),
                      SizedBox(height: size.height * .02),
                      TextFormField(
                        autocorrect: false,
                        enableSuggestions: false,
                        controller: passwordController,
                        obscureText: _isHidden,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8.0),
                          labelText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: _toggleVisibility,
                              icon: _isHidden
                                  ? Icon(Icons.visibility_off, size: 20)
                                  : Icon(Icons.visibility, size: 20)),
                        ),
                        style: TextStyle(fontSize: 15.0),
                        validator: (val) =>
                            val.isEmpty ? 'Password is required' : null,
                      ),
                      SizedBox(height: size.height * .06),
                      Center(
                        child: MaterialButton(
                          height: size.height * .075,
                          minWidth: size.width * 0.2,
                          //color: Color.fromRGBO(86, 43, 167, 1),
                          splashColor: Colors.purple,
                          highlightColor: Colors.purple[100],
                          hoverColor: Colors.purple[50],
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Colors.purple[600], width: 2)),
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, letterSpacing: 7),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              Navigator.pushReplacementNamed(
                                  context, Routes.dashboard);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
