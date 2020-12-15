import 'package:bhaithamen/data/user.dart';
import 'package:bhaithamen/screens/custom_list_tile.dart';
import 'package:bhaithamen/screens/home.dart';
import 'package:bhaithamen/screens/map_places_wrapper.dart';
import 'package:bhaithamen/screens/news_wrapper.dart';
import 'package:bhaithamen/screens/settings_wrapper.dart';
import 'package:bhaithamen/utilities/language_data.dart';
import 'package:bhaithamen/utilities/variables.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

class MapPlacesOLD extends StatefulWidget {
  final User user;
  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;
  MapPlacesOLD(this.user, this.observer, this.analytics);
  @override
  _MapPlacesOLDState createState() =>
      _MapPlacesOLDState(user, observer, analytics);
}

class _MapPlacesOLDState extends State<MapPlacesOLD> {
  _MapPlacesOLDState(this.user, this.observer, this.analytics);

  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;
  final User user;
  String uid;
  String userName = '';
  String userPhone = '';
  String userEmail = '';
  String profilePic = '';

  initState() {
    super.initState();
    getCurrentUserInfo();
  }

  getCurrentUserInfo() async {
    var firebaseuser = fbAuth.FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDoc = await userCollection.doc(firebaseuser.uid).get();
    setState(() {
      uid = firebaseuser.uid;
      userName = userDoc['username'];
      userPhone = userDoc['userPhone'];
      userEmail = userDoc['email'];
      profilePic = userDoc['profilepic'];
    });
  }

  Future getUserLocation() async {
    myLocationData = await location.getLocation();

    GeoPoint loc;

    if (myLocationData != null) {
      loc = GeoPoint(myLocationData.latitude, myLocationData.longitude);
    } else {
      loc = GeoPoint(90.0000, 135.0000);
    }

    if (loc == null) {
      loc = GeoPoint(90.0000, 135.0000);
    }

    return loc;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Backdrop Demo',
      home: BackdropScaffold(
        appBar: BackdropAppBar(
          title: Text("Backdrop Example"),
          actions: <Widget>[
            BackdropToggleButton(
              icon: AnimatedIcons.list_view,
            )
          ],
        ),
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
              NewsWrapper(user, observer, analytics),
              false),
          CustomListTile(
              languages[selectedLanguage[languageIndex]]['sideMenu2'],
              FontAwesomeIcons.hardHat,
              Home(user, observer, analytics),
              false),
          CustomListTile(
              languages[selectedLanguage[languageIndex]]['sideMenu3'],
              FontAwesomeIcons.map,
              MapPlacesWrapper(user, observer, analytics),
              true),
          CustomListTile(languages[selectedLanguage[languageIndex]]['settings'],
              FontAwesomeIcons.cog, SettingsWrapper(), false),
        ])),
        backLayer: Center(
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text("Back Layer")),
        ),
        subHeader: BackdropSubHeader(
          title: Text("Sub Header"),
        ),
        frontLayer: Center(
          child: Text("Front Layer"),
        ),
      ),
    );
  }
}
