import 'dart:async';

import 'package:bhaithamen/data/user.dart';
import 'package:bhaithamen/data/userData.dart';
import 'package:bhaithamen/screens/countdown_screen.dart';
import 'package:bhaithamen/screens/custom_list_tile.dart';
import 'package:bhaithamen/screens/map_wrapper.dart';
import 'package:bhaithamen/screens/news.dart';
import 'package:bhaithamen/screens/news_wrapper.dart';
import 'package:bhaithamen/screens/safe.dart';
import 'package:bhaithamen/screens/settings_wrapper.dart';
import 'package:bhaithamen/screens/sos.dart';
import 'package:bhaithamen/screens/welfare_check.dart';
import 'package:bhaithamen/utilities/analytics_service.dart';
import 'package:bhaithamen/utilities/auth.dart';
import 'package:bhaithamen/utilities/auto_page_navigation.dart';
import 'package:bhaithamen/utilities/language_data.dart';
import 'package:bhaithamen/utilities/push_notification.dart';
import 'package:bhaithamen/utilities/report_event.dart';
import 'package:bhaithamen/utilities/variables.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

class Home extends StatefulWidget {
  final User user;
  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;
  Home(this.user, this.observer, this.analytics);

  @override
  _HomeState createState() => _HomeState(observer, analytics);
}

class _HomeState extends State<Home> {
  _HomeState(this.observer, this.analytics);

  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;
  final AuthService _auth = AuthService();

  final analyticsHelper = AnalyticsService();

  final GlobalKey<ScaffoldState> _scaffoldKeyHome = GlobalKey<ScaffoldState>();

  AutoHomePageWelfareSelect homePageWelfare;

  User theUser;

  String userName = '';
  String profilePic = '';

  Future<void> _testSetAnalyticsCollectionEnabled() async {
    await analytics.setAnalyticsCollectionEnabled(false);
    await analytics.setAnalyticsCollectionEnabled(true);
    print('setAnalyticsCollectionEnabled succeeded');
  }

  Future<bool> awaitStarted() async {
    return new Future.delayed(const Duration(seconds: 30), () => true);
  }

  @override
  void initState() {
    super.initState();
    theUser = widget.user;
    checkPerm();
    getCurrentUserInfo();
    _testSetAnalyticsCollectionEnabled();

    analyticsHelper.sendAnalyticsEvent('Home View');
  }

  getCurrentUserInfo() async {
    var firebaseuser = fbAuth.FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDoc = await userCollection.doc(firebaseuser.uid).get();
    setState(() {
      userName = userDoc['username'];
      profilePic = userDoc['profilepic'];
    });
  }

  checkPerm() async {
    // SMS PERM
    try {
      var status = await Permission.sms.status;
      if (status.isUndetermined || status.isDenied) {
        // We didn't ask for permission yet.
        if (await Permission.sms.request().isGranted) {
          print('sms granted');
          // Either the permission was already granted before or the user just granted it.
        }
      }
    } on Exception catch (exception) {
      print(exception.toString());
      // only executed if error is of type Exception
    } catch (error) {
      // executed for errors of all types other than Exception
    }

    ///
    /// CAM PERM
    try {
      var camStatus = await Permission.camera.status;
      if (camStatus.isUndetermined || camStatus.isDenied) {
        // We didn't ask for permission yet.
        if (await Permission.camera.request().isGranted) {
          print('cam granted');
          // Either the permission was already granted before or the user just granted it.
        }
      }
    } on Exception catch (exception) {
      // only executed if error is of type Exception
    } catch (error) {
      // executed for errors of all types other than Exception
    }
    ////
    ///
    ///phone perm
    try {
      var callStatus = await Permission.phone.status;
      if (callStatus.isUndetermined || callStatus.isDenied) {
        // We didn't ask for permission yet.
        if (await Permission.phone.request().isGranted) {
          print('phone granted');
          // Either the permission was already granted before or the user just granted it.
        }
      }
    } on Exception catch (exception) {
      // only executed if error is of type Exception
    } catch (error) {
      // executed for errors of all types other than Exception
    }

    //mic perm
    try {
      var audStatus = await Permission.microphone.status;
      if (audStatus.isUndetermined || audStatus.isDenied) {
        // We didn't ask for permission yet.
        if (await Permission.microphone.request().isGranted) {
          print('mic granted');
          // Either the permission was already granted before or the user just granted it.
        }
      }
    } on Exception catch (exception) {
      // only executed if error is of type Exception
    } catch (error) {
      // executed for errors of all types other than Exception
    }

    //store perm
    try {
      var storeStatus = await Permission.storage.status;
      if (storeStatus.isUndetermined || storeStatus.isDenied) {
        // We didn't ask for permission yet.
        if (await Permission.storage.request().isGranted) {
          print('store granted');
          // Either the permission was already granted before or the user just granted it.
        }
      }
    } on Exception catch (exception) {
      // only executed if error is of type Exception
    } catch (error) {
      // executed for errors of all types other than Exception
    }

    //location perm
    try {
      var locstatus = await Permission.location.status;
      if (locstatus.isUndetermined || locstatus.isDenied) {
        // We didn't ask for permission yet.
        if (await Permission.location.request().isGranted) {
          print('location granted');
          // Either the permission was already granted before or the user just granted it.
        }
      }
    } on Exception catch (exception) {
      // only executed if error is of type Exception
    } catch (error) {
      // executed for errors of all types other than Exception
    }

    appHasStarted = await awaitStarted();
  }
  //show tab 1 - this is the middle tab i.e. Safe

  // page = 0 means show tab SOS
  // page = 1 means show tab Safe
  // page = 2 means show tab Settings

  //these are the widgets (pages) to be shown in the main screen
  List pageOptions = [
    SOS(),
    Safe(),
    //CountPlug(),
    //AskMe()
    CountDown(),
  ];

  AnimationController _animationController;
  bool iconPlaying = false;

  FutureOr onGoBack(dynamic value) {
    getCurrentUserInfo();
    setState(() {});
  }

  void navigateSettings() {
    Route route = MaterialPageRoute(builder: (context) => SettingsWrapper());
    Navigator.push(context, route).then(onGoBack);
  }

  void navigateWelfare() {
    Route route = MaterialPageRoute(builder: (context) => WelfareCheck());
    Navigator.push(context, route).then(onGoBack);
  }

  afterBuild(context) {
    if (showWelfare) {
      if (!homePageWelfare.shouldGoWelfare) {
        homePageWelfare.setHomePageWelfare(true);
        print('SHHHHHHH ' + showWelfare.toString());
      }
    } else {
      if (homePageWelfare.shouldGoWelfare) {
        homePageWelfare.setHomePageWelfare(false);
        print('SHHHHHHH ' + showWelfare.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild(context));
    final AutoHomePageMapSelect homePageMap =
        Provider.of<AutoHomePageMapSelect>(context);
    final AutoHomePageAskSelect homePageAsk =
        Provider.of<AutoHomePageAskSelect>(context);
    homePageWelfare = Provider.of<AutoHomePageWelfareSelect>(context);
    final SafePageIndex safePageIndex = Provider.of<SafePageIndex>(context);

    print('home user ' + widget.user.uid);

    globalContext = context;

    return MultiProvider(
      providers: [
        StreamProvider<UserData>.value(
            value: AuthService(uid: widget.user.uid).userData),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            // leading: Padding(
            //   padding: const EdgeInsets.all(6.0),
            //   child: InkWell(
            //     onTap: () {
            //       //showWelfareNotification();
            //       // Navigator.push(
            //       //   context,
            //       //   MaterialPageRoute(
            //       //     builder: (context) => NewsWrapper(),
            //       //   ),
            //       // );
            //     },
            //     child: Container(
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         image: DecorationImage(
            //             image: AssetImage('assets/images/handStop.png'),
            //             fit: BoxFit.fitHeight),
            //       ),
            //     ),
            //   ),
            // ),
            centerTitle: true,
            title: testModeToggle
                ? Text(languages[selectedLanguage[languageIndex]]['testOn'],
                    style: myStyle(18, Colors.white))
                : Text(languages[selectedLanguage[languageIndex]]['title'],
                    style: myStyle(18, Colors.white)),
            backgroundColor: testModeToggle ? Colors.red : Colors.blue,
            actions: <Widget>[
              if (homePageMap.shouldGoMap)
                FlatButton(
                    child: Lottie.asset('assets/lottie/alert.json'),
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapWrapper(),
                          ),
                        );
                        //homePageIndex = 1; safePageIndex.setSafePageIndex(0);savedSafeIndex=0;homePageMap.setHomePageMap(false);
                      });
                    }),
              if (homePageAsk.shouldGoAsk)
                FlatButton(
                    child: Lottie.asset('assets/lottie/alert.json'),
                    onPressed: () {
                      setState(() {
                        homePageIndex = 2;
                        safePageIndex.setSafePageIndex(0);
                        savedSafeIndex = 0;
                        homePageAsk.setHomePageAsk(false);
                      });
                    }),
              if (homePageWelfare.shouldGoWelfare)
                FlatButton(
                    child: Lottie.asset('assets/lottie/alert.json'),
                    onPressed: () {
                      navigateWelfare();
                    }),
              // IconButton(
              //     icon: Icon(Icons.settings, size: 35),
              //     onPressed: () {
              //       navigateSettings();
              //     }),
            ]),
        key: _scaffoldKeyHome,
        //will show the widget (page) depending on which button was pressed

        drawer: Drawer(
            child: ListView(children: [
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Colors.blue[700], Colors.blue[200]])),
            child: Container(
                child: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(120.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: profilePic == 'default'
                        ? Image.asset('assets/images/defaultAvatar.png',
                            height: 100, width: 100)
                        : CachedNetworkImage(
                            height: 70,
                            width: 70,
                            imageUrl: profilePic,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => SizedBox(
                              height: 100,
                              child: Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 8, 2, 2),
                  child: Text(userName,
                      style: myStyle(20, Colors.white, FontWeight.w300)),
                ),
              ],
            )),
          ),
          CustomListTile(
              languages[selectedLanguage[languageIndex]]['sideMenu1'],
              FontAwesomeIcons.newspaper,
              NewsWrapper(widget.user, observer, analytics),
              false),
          CustomListTile(
              languages[selectedLanguage[languageIndex]]['sideMenu2'],
              FontAwesomeIcons.hardHat,
              Home(widget.user, observer, analytics),
              true),
          CustomListTile(languages[selectedLanguage[languageIndex]]['settings'],
              FontAwesomeIcons.cog, SettingsWrapper(), false),
        ])),

        body: pageOptions[homePageIndex],

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              //set page variable = to index (0,1 or 2) depending on which button was pressed
              homePageIndex = index;
              mapIsShowing = false;
            });
          },
          fixedColor: Colors.blue[700],
          backgroundColor: Colors.white70,
          elevation: 12.0,
          selectedFontSize: 17,
          //selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.grey[600],
          currentIndex: homePageIndex,
          items: [
            //3 buttons across bottom of screen
            BottomNavigationBarItem(
                icon: homePageIndex == 0
                    ? Icon(Icons.warning, size: 24)
                    : Icon(Icons.warning_amber_outlined, size: 22),
                label: languages[selectedLanguage[languageIndex]]['sos']),
            BottomNavigationBarItem(
                icon: homePageIndex == 1
                    ? Icon(Icons.home, size: 24)
                    : Icon(Icons.home_outlined, size: 22),
                label: languages[selectedLanguage[languageIndex]]['home']),
            BottomNavigationBarItem(
                icon: homePageIndex == 2
                    ? Icon(Icons.timer_rounded, size: 26)
                    : Icon(Icons.timer_outlined, size: 22),
                label: languages[selectedLanguage[languageIndex]]['reminder']),
          ],
        ),
      ),
    );
  }
}
