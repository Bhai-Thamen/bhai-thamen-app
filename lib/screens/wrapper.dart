import 'dart:async';

import 'package:bhaithamen/data/user.dart';
import 'package:bhaithamen/screens/expired.dart';
import 'package:bhaithamen/screens/flutter_unlock.dart';
import 'package:bhaithamen/screens/home.dart';
import 'package:bhaithamen/screens/login.dart';
import 'package:bhaithamen/screens/news_wrapper.dart';
import 'package:bhaithamen/utilities/auto_page_navigation.dart';
import 'package:bhaithamen/utilities/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart' as _auth;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:key_guardmanager/key_guardmanager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  Wrapper({this.analytics, this.observer});

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  @override
  _WrapperState createState() => _WrapperState(analytics, observer);
}

class _WrapperState extends State<Wrapper> with WidgetsBindingObserver {
  _WrapperState(this.analytics, this.observer);

  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;

  bool needUnlock = true;

//final deviceUnlock = DeviceUnlock();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool _isMoving;
  bool _enabled;
  String _motionActivity;
  String _odometer;
  String _content;

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   //myVars.stateNotification = state;

  //   switch (state) {
  //     case AppLifecycleState.paused:
  //       // myVars.needThePin=false;
  //       // Duration timeOut = Duration(seconds:5);//Duration(minutes:askDuration.inMinutes);
  //       //   if (pinTimer!=null){if (pinTimer.isActive){pinTimer.cancel();}}
  //       //   pinTimer =  Timer(timeOut, ()async {
  //       //     checkAuth = 'false';
  //       //     appHasStarted=false;
  //       //   //if (appHasStarted==true)myVars.needThePin=true;
  //       // });

  //       // print ('MAIN state notifi '+myVars.stateNotification.toString() +'  '+ myVars.needThePin.toString());
  //       //   if (myVars.needThePin){
  //       //       pinProvider.setPinRequired(true);
  //       //   }
  //       //  if (needUnlock)
  //       //  setState(() {
  //       //   needUnlock=false;
  //       // });

  //       break;
  //     case AppLifecycleState.resumed:
  //       // if (appHasStarted==false) initPlatformState();

  //       // print ('MAIN state notifi '+myVars.stateNotification.toString());
  //       //     if (myVars.needThePin && myVars.appHasStarted==true){
  //       //         pinProvider.setPinRequired(true);
  //       //     }

  //       break;
  //     case AppLifecycleState.inactive:
  //       //print ('MAIN state notifi '+myVars.stateNotification.toString());

  //       break;
  //     case AppLifecycleState.detached:
  //       //print ('state notifi '+myVars.stateNotification.toString());

  //       break;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final PinRequired isPinNeeded = Provider.of<PinRequired>(context);

    if (user == null) {
      return Login();
    } else {
      return NewsWrapper(user, observer, analytics);
    }
  }
}
