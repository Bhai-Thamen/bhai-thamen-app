import 'package:bhaithamen/screens/home.dart';
import 'package:bhaithamen/screens/wrapper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bhai Thamen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Start the app with the Wrapper widget - the wrapper widget will decide which pages to show
      // depending on whether or not user is logged in
      home: Wrapper(),
    );
  }
}

