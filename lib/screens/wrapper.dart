import 'package:bhaithamen/screens/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

// Later this widget will check if the user is logged in with an account
// if not then they will be shown the login screen
// if they are then they will be shown the home screen

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Home(),
    );
  }
}