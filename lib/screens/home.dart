import 'package:bhaithamen/screens/safe.dart';
import 'package:bhaithamen/screens/settings.dart';
import 'package:bhaithamen/screens/sos.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //show tab 1 - this is the middle tab i.e. Safe
  int page = 1;

  // page = 0 means show tab SOS 
  // page = 1 means show tab Safe
  // page = 2 means show tab Settings  

  //these are the widgets (pages) to be shown in the main screen
  List pageOptions = [
    SOS(),
    Safe(),
    Settings()
  ];

  @override
  Widget build(BuildContext context) {
 return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bhai Thamen'),
      ),
      key: _scaffoldKey,
      //will show the widget (page) depending on which button was pressed
      body: pageOptions[page],
      bottomNavigationBar: BottomNavigationBar(
        type : BottomNavigationBarType.fixed,
        onTap:(index){
          setState(() {
            //set page variable = to index (0,1 or 2) depending on which button was pressed
            page = index;
          });
        },
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.black,
        currentIndex: page,
        items: [
        //3 buttons across bottom of screen  
        BottomNavigationBarItem(
        icon: Icon(Icons.warning, size: 24),
        label: 'SOS'),
        BottomNavigationBarItem(
        icon: Icon(Icons.home, size: 24),
        label: 'Safe'),
        BottomNavigationBarItem(
        icon: Icon(Icons.settings, size: 24),
        label: 'Settings'),
      ],
      ),
    );
  }
}