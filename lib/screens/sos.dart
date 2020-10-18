import 'package:flutter/material.dart';

class SOS extends StatefulWidget {
  @override
  _SOSState createState() => _SOSState();
}

class _SOSState extends State<SOS> {

List<bool> isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
      return  new Column(
        children: <Widget>[
          SizedBox(height:5),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              //buttons across top of screen
            ToggleButtons(
              color: Colors.white,
              selectedColor: Colors.black,
              fillColor: Colors.green[600],
              borderColor: Colors.white,
              children: <Widget>[
                Container(width: (MediaQuery.of(context).size.width - 12)/3, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.clean_hands,size: 16.0,color: Colors.black,),new SizedBox(width: 4.0,), new Text("Confront",style: TextStyle(color: Colors.black),)],)),
                Container(width: (MediaQuery.of(context).size.width - 12)/3, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.note, size: 16.0,color: Colors.black,),new SizedBox(width: 4.0,), new Text("Report",style: TextStyle(color: Colors.black))],)),
                Container(width: (MediaQuery.of(context).size.width - 12)/3, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.privacy_tip,size: 16.0,color: Colors.black,),new SizedBox(width: 4.0,), new Text("Secrecy",style: TextStyle(color: Colors.black))],)),
              ],
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                    if (buttonIndex == index) {        
                      isSelected[buttonIndex] = true;

                    } else {
                      isSelected[buttonIndex] = false;
                    }
                  }
                });
              },
              isSelected: isSelected,
            ),
            ],
          ), 
          ),
          ],
        );
  }
}