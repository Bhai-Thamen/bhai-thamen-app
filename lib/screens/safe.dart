import 'package:flutter/material.dart';

class Safe extends StatefulWidget {
  @override
  _SafeState createState() => _SafeState();
}

class _SafeState extends State<Safe> {

List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
  return 
      new Column(
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
                Container(width: (MediaQuery.of(context).size.width - 12)/2, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.map,size: 16.0,color: Colors.black,),new SizedBox(width: 4.0,), new Text("Route",style: TextStyle(color: Colors.black),)],)),
                Container(width: (MediaQuery.of(context).size.width - 12)/2, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.alarm,size: 16.0,color: Colors.black,),new SizedBox(width: 4.0,), new Text("Ask Me",style: TextStyle(color: Colors.black))],)),
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