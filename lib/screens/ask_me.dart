// import 'dart:async';

// //import 'package:audioplayers/audio_cache.dart';
// //import 'package:audioplayers/audioplayers.dart';

// import 'package:bhaithamen/data/userData.dart';
// import 'package:bhaithamen/utilities/auto_page_navigation.dart';
// import 'package:bhaithamen/utilities/send_sms.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:bhaithamen/utilities/variables.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_duration_picker/flutter_duration_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:vibration/vibration.dart';

// class AskMe extends StatefulWidget {
//   @override
//   _AskMeState createState() => _AskMeState();
// }

// class _AskMeState extends State<AskMe> {
//   //Duration askDuration = Duration(hours: 0, minutes: 0);
//   //static AudioCache audioCache = AudioCache();
//   //AudioPlayer player; 

//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   int timer = 10;
//   dynamic theUserData;
//   dynamic homeAsk;
//   AutoHomePageAskSelect  homePageAskInstance;

  

//    @override
//   void initState() {
//     super.initState();
//     globalContext=context;
//     if (showMapPopup){mapFlushBar();print ('MAIN init state map pop');}
 
//   }

//     @override
//   void setState(fn) {
//     if(mounted) {
//       super.setState(fn);
//     }
//   }

//   void resetTimer(){
//     print ('in reset timer');
    
//     if (askTimer.isActive){  
//     askTimer.cancel();
//     print ('EM timer reset');
//     }
    
    
//     //alarm?.stop();

//     askPlayer.stop();
//     Vibration.cancel();
//     beginTimer();
    
//   }

//   void startAlertTimer(int time)async{

//     Duration timeOut = Duration(seconds:time);
//     askTimer =  Timer(timeOut, () async {
//       print (' SMS EMERGENCY SMS EMERGENCY ***************');
//       if (theUserData!=null){
//       for (var i=0; i<theUserData.phoneContact.length; i++){
//         bool done = await sendNewSms (theUserData.phoneContact[i], theUserData.userName, i);
//       print ('done $i'+done.toString());
//       }
//       } 
//       beginTimer();
//     });
// }


//   void startNotificationTimer()async{
//     print ('LOOK HERE ASK ME '+stateNotification.index.toString());

//           await askPlayer.setAsset('assets/audio/alarm.mp3');
//           askPlayer.setLoopMode(LoopMode.one);
//           askPlayer.play();
//       Vibration.vibrate(
//           pattern: [500, 1000, 500, 1000, 500, 1000, 500, 200, 500, 1000, 500, 1000, 500, 1000, 500, 200, 200, 200, 200],
//       );

//     if (stateNotification.index == 2){
//       //showNotification(resetTimer, 1);
//       startAlertTimer(30); 
//     }else{
//       //timerDialog();
//       setState(() {
//         homePageAskInstance.setHomePageAsk(true);
//         showAskPopup=true;
//             });
//       startAlertTimer(30);
//     }
//     showAskPopup=true;
  

    

//     homePageAskInstance.setHomePageAsk(true);
//     savedShouldGoAsk=true;
      
//     showAskPopup=true; 


//   }

//   timerDialog(){
  
//     showDialog(
//     context: globalContext,
//     builder: (context) => AlertDialog(
//       content: Text("Notification in active"),
//       actions: [
//          FlatButton(
//             child: Text('CANCEL'),
//             onPressed: () {
//               cancelTimer();
//               Navigator.of(context).pop();
//             },
//           ),        
//           FlatButton(
//             child: Text('Sleep'),
//             onPressed: () {
//               resetTimer();
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//     ),
//   );
//   }

//    cancelTimerBtn(){
//     print ('in cancel timerBtn');
//     if (askTimer.isActive) {
//     askTimer.cancel();
//     }
    
//     //alarm?.stop();
//     askPlayer.stop();

//     Vibration.cancel();
 
//   } 

//   cancelTimer(){
//     print ('in cancel timer');
//     if (askTimer.isActive) {
//     askTimer.cancel();
//     }
    
//     //alarm?.stop();
//     askPlayer.stop();

//     Vibration.cancel();
//     setState(() {
//       askMeRunning=false;
//     });
//   }  

//   beginTimer(){
//     //alarm?.stop();

  
//     if (askTimer!=null) {
//     askTimer.cancel();
//     }
//     askPlayer.stop();
//     Vibration.cancel();
//     Duration timeOut = Duration(seconds:10);//Duration(minutes:askDuration.inMinutes);
//     askTimer =  Timer(timeOut, () {
//       startNotificationTimer();
//     });
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     globalContext=context;
//     homePageAskInstance = Provider.of<AutoHomePageAskSelect>(context);
      

//     final userData = Provider.of<UserData>(context); 
//         if (userData!=null){
//           theUserData = userData;
//         }  
// return Stack(
//   children: <Widget>[
//     Container(
//       width: MediaQuery.of(context).size.width,            
//         child: DurationPicker(
//               duration: askDuration,
//               onChange: (val) {
//                 this.setState(() => askDuration = val);
//               },
//               snapToMins: 1.0,
//             ),      
//     ),
//         Container(
//         width: 120,
//         margin: EdgeInsets.only(left:MediaQuery.of(context).size.width/2-64, top: 280),
//           child: FloatingActionButton(
//               backgroundColor: askMeRunning ? Colors.red: Colors.green,
//               onPressed: () async {
//                 setState(() {
//                   if (askMeRunning) {cancelTimerBtn();}else{beginTimer();}
//                   askMeRunning= ! askMeRunning;
//                 });
                
//               },
                
//               child: askMeRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow),
//             ),
//         ),


//     Visibility(
//     visible: showAskPopup,
//     child:
//     Container(
//       width: 280,
//       height: 200,
//       margin: EdgeInsets.only(left:50, top:100),
      
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.blueAccent),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//       BoxShadow(
//         color: Colors.grey.withOpacity(0.5),
//         spreadRadius: 5,
//         blurRadius: 7,
//         offset: Offset(0, 3), // changes position of shadow
//       ),
//     ],
//         color: Colors.white,
//         shape: BoxShape.rectangle,
//       ),
//       child: Center(
//         child:Column(
//           children:[
//             SizedBox(height:15),
//             Text('Welfare Check', style: myStyle(20, Colors.black, FontWeight.w600)),
//             SizedBox(height:25),
//             Text('Reset Time?', style: myStyle(20)),
//             SizedBox(height:25),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children:[
//               FlatButton(
//           shape: RoundedRectangleBorder(side: BorderSide(
//             color: Colors.red,
//             width: 2,
//             style: BorderStyle.solid,    
//           ), borderRadius: BorderRadius.circular(20)
//           ),                
//                 onPressed: (){
//                   setState(() {
//                     showAskPopup=false;
//                     askMeRunning=false;
//                     homePageAskInstance.setHomePageAsk(false);
//                     savedShouldGoAsk=false;
//                   });
//                   cancelTimerBtn();
//                 } ,
//                 child: Text('No', style:myStyle(20))),            
                      
//               FlatButton(
//           shape: RoundedRectangleBorder(side: BorderSide(
//             color: Colors.green,
//             width: 2,
//             style: BorderStyle.solid,    
//           ), borderRadius: BorderRadius.circular(20)
//           ),
//                 onPressed: (){
//                     setState(() {
//                     showAskPopup=false;
//                     homePageAskInstance.setHomePageAsk(false);
//                     savedShouldGoAsk=false;
//                   });
//                   beginTimer();
//                 },
//                 child: Text('YES', style: myStyle(20))
//                 ),
//             ],
        
//         )           

//       ],
//       ),
//       ),
//     ),

//     ),    
//   ],

// );
    
    
//       //   Container(
//       //   width: 120,
//       //   margin: EdgeInsets.only(left:MediaQuery.of(context).size.width/2-64, top: 280),
//       //   child:  FloatingActionButton(
//       //               onPressed: () async {
//       //                 Duration resultingDuration = await showDurationPicker(
//       //                   context: context,
//       //                   initialTime: new Duration(minutes: 30),
//       //                 );
//       //                 Scaffold.of(context).showSnackBar(new SnackBar(
//       //                     content: new Text("Chose duration: $resultingDuration")));
//       //               },
//       //               tooltip: 'Popup Duration Picker',
//       //               child: new Icon(Icons.add),
//       //             )  
      
//       // ),    
//       // return Container(
//       //   height: MediaQuery.of(context).size.height-200,
//       //   child:
//       //   Stack(
//       //       children:[ 
//       //   SingleChildScrollView(
//       //   child: 
//       //       Column(
//       //       mainAxisSize: MainAxisSize.min,
//       //       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       //       children: <Widget>[
//       //           Container(
//       //            // alignment: Alignment.center,        
//       //             margin: EdgeInsets.only(top:100, left: 50),
//       //             width: 200,
//       //             height: 150,
//       //             decoration: new BoxDecoration(
//       //               color: Colors.lightBlue,
//       //             ),
//       //             child: 
//       //             Center(
//       //               child:
//       //               Column(children: [

//       //               ],
//       //               ),
//       //             )
//       //           ) ,              
//       //       // Container(
//       //       //   child: DurationPicker(
//       //       //       duration: _duration,
//       //       //       onChange: (val) {
//       //       //         this.setState(() => _duration = val);
//       //       //       },
//       //       //       snapToMins: 1.0,
//       //       //     ),
//       //       // ),
          
//               // Container(
//               //   margin: EdgeInsets.only(top:100, left: 50),
//               //   child: FloatingActionButton(
//               //       backgroundColor: askMeRunning ? Colors.red: Colors.green,
//               //       onPressed: () async {
//               //         setState(() {
//               //           if (askMeRunning) {cancelTimer();}else{beginTimer();}
//               //           askMeRunning= ! askMeRunning;
//               //         });
                     
//               //       },
                      
//               //       child: askMeRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow),
//               //     ),
//               // ), 
       
        

//       //       ],
//       //     ),
//       //     //],
//       //     //),
//       //   ),
//       //       ],
//       //   ),
          
//       // );
//   }
// }