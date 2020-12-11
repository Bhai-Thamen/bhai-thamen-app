
import 'package:bhaithamen/screens/countdown_screen.dart';
import 'package:bhaithamen/screens/welcome.dart';
import 'package:bhaithamen/utilities/auto_page_navigation.dart';
import 'package:bhaithamen/utilities/variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Safe extends StatefulWidget {

  @override
  _SafeState createState() => _SafeState();
}

class _SafeState extends State<Safe> {

SafePageIndex safePageIndex;

List<bool> isSelected = [false, false];
//int page = 0;
 @override
  void initState() {
    super.initState();
print ('safe init');
    // if (safePageIndex!=null){
    //   isSelected[safePageIndex.getSafeIndex]=true;
    //   if (safePageIndex.getSafeIndex==0)mapIsShowing=true; 
    // }
      globalContext=context;
  }
  List pageOptions = [
   //RouteScreen(),
   Welcome(),
   //CountPlug(),
   CountDown(),
   //AskMe() 
  ];



  @override
  Widget build(BuildContext context) {
    //globalContext=context;
  // final AutoHomePageMapSelect homePageMap = Provider.of<AutoHomePageMapSelect>(context);
  // final AutoHomePageAskSelect homePageAsk = Provider.of<AutoHomePageAskSelect>(context);
  // final AutoHomePageCanChange homePageCanChange = Provider.of<AutoHomePageCanChange>(context);
  safePageIndex = Provider.of<SafePageIndex>(context);
    if (safePageIndex!=null){
      isSelected = [false, false];
      isSelected[safePageIndex.getSafeIndex]=true;
      if (safePageIndex.getSafeIndex==0)mapIsShowing=true; 
      
    }
  return safePageIndex==null ? Container(child:CircularProgressIndicator()):
      new Column(
        children: <Widget>[
          SizedBox(height:5),
        // Container(
        //  // child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children:[
        //     //buttons across top of screen
        //     // ToggleButtons(
        //     //   color: Colors.white,
        //     //   selectedColor: Colors.black,
        //     //   fillColor: Colors.green[600],
        //     //   borderColor: Colors.white,
        //     //   children: <Widget>[
        //     //     Container(width: (MediaQuery.of(context).size.width - 12)/2, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.map,size: 16.0,color: Colors.black,),new SizedBox(width: 4.0,), new Text("Route",style: TextStyle(color: Colors.black),)],)),
        //     //     Container(width: (MediaQuery.of(context).size.width - 12)/2, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.alarm,size: 16.0,color: Colors.black,),new SizedBox(width: 4.0,), new Text("Ask Me",style: TextStyle(color: Colors.black))],)),
        //     //   ],
        //     //   onPressed: (int index) {
        //     //     setState(() {
        //     //       for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
        //     //         if (buttonIndex == index) {        
        //     //           isSelected[buttonIndex] = true;
        //     //           savedSafeIndex = index;
        //     //           safePageIndex.setSafePageIndex (index);
        //     //           if (safePageIndex.getSafeIndex==0){mapIsShowing=true;}else{mapIsShowing=false;}
        //     //         } else {
        //     //           isSelected[buttonIndex] = false;
        //     //         }
        //     //       }
        //     //     });
        //     //   },
        //     //   isSelected: isSelected,
        //     // ),
        //     //],
        //   //), 
        //   ),

        // homePageAsk.shouldGoAsk && homePageCanChange.shouldGoChange ?
        //   Container(child:pageOptions[1]):
        // homePageMap.shouldGoMap && homePageCanChange.shouldGoChange ?
        //   Container(child:pageOptions[0]):

          Container(child:pageOptions[safePageIndex.getSafeIndex])

           
          ],
        );
    
  }
}