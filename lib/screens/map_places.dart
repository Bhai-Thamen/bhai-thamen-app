import 'dart:async';

import 'package:bhaithamen/data/safe_place_data.dart';
import 'package:bhaithamen/data/user.dart';
import 'package:bhaithamen/screens/custom_list_tile.dart';
import 'package:bhaithamen/screens/home.dart';
import 'package:bhaithamen/screens/map_places_wrapper.dart';
import 'package:bhaithamen/screens/map_top_menu.dart';
import 'package:bhaithamen/screens/map_wrapper.dart';
import 'package:bhaithamen/screens/news_wrapper.dart';
import 'package:bhaithamen/screens/settings_wrapper.dart';
import 'package:bhaithamen/screens/welfare_check.dart';
import 'package:bhaithamen/utilities/auto_page_navigation.dart';
import 'package:bhaithamen/utilities/language_data.dart';
import 'package:bhaithamen/utilities/variables.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:lottie/lottie.dart' as lot;
import 'package:provider/provider.dart';

class MapPlaces extends StatefulWidget {
  final User user;
  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;
  MapPlaces(this.user, this.observer, this.analytics);
  @override
  _MapPlacesState createState() => _MapPlacesState(user, observer, analytics);
}

class _MapPlacesState extends State<MapPlaces> {
  _MapPlacesState(this.user, this.observer, this.analytics);

  Set<Marker> _markers = {};

  final _mapPlacesKey = GlobalKey<TopModalSheetState>();

  AutoHomePageWelfareSelect homePageWelfare;

  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;
  final User user;
  String uid;
  String userName = '';
  String userPhone = '';
  String userEmail = '';
  String profilePic = '';

  BitmapDescriptor toiletMarker;
  BitmapDescriptor pharmacyMarker;
  BitmapDescriptor hospitalMarker;

  Map<String, BitmapDescriptor> myMarkers = {
    'toilets': null,
    'pharmacy': null,
    'hospital': null
  };

  var _topModalData = "";

  initState() {
    super.initState();
    setToiletCustomMarker();
    setPharmacyCustomMarker();
    setHospitalCustomMarker();
    getCurrentUserInfo();
  }

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double screenHeight(BuildContext context,
      {double dividedBy = 1, double reducedBy = 0.0}) {
    return (screenSize(context).height - reducedBy) / dividedBy;
  }

  double screenHeightExcludingToolbar(BuildContext context,
      {double dividedBy = 1}) {
    return screenHeight(context,
        dividedBy: dividedBy, reducedBy: kToolbarHeight);
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

  setToiletCustomMarker() async {
    toiletMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/toilets.png');
    myMarkers['toilets'] = toiletMarker;
  }

  setHospitalCustomMarker() async {
    hospitalMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/hospital.png');
    myMarkers['hospital'] = hospitalMarker;
  }

  setPharmacyCustomMarker() async {
    pharmacyMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/pharmacy.png');
    myMarkers['pharmacy'] = pharmacyMarker;
  }

  @override
  Widget build(BuildContext context) {
    final AutoHomePageMapSelect homePageMap =
        Provider.of<AutoHomePageMapSelect>(context);
    final AutoHomePageAskSelect homePageAsk =
        Provider.of<AutoHomePageAskSelect>(context);
    homePageWelfare = Provider.of<AutoHomePageWelfareSelect>(context);
    Provider.of<AutoHomePageAskSelect>(context);

    final AutoPlaceCategorySelect autoSetCategory =
        Provider.of<AutoPlaceCategorySelect>(context);

    final SafePageIndex safePageIndex = Provider.of<SafePageIndex>(context);

    final safePlaces = Provider.of<List<SafePlace>>(context);

    if (safePlaces != null) {
      _markers.clear();
      print('GETTING ' + autoSetCategory.shouldGoCategory);
      if (safePlaces.length > 0) {
        for (var i = 0; i < safePlaces.length; i++) {
          double lat = safePlaces[i].location.latitude;
          double lng = safePlaces[i].location.longitude;
          LatLng latLng = new LatLng(lat, lng);

          _markers.add(Marker(
              markerId: MarkerId(safePlaces[i].docId),
              position: latLng,
              icon: myMarkers[safePlaces[i].category],
              infoWindow: InfoWindow(
                  title: safePlaces[i].name,
                  snippet: safePlaces[i].rating.toString() + ' out of 5')));

          //print('MARKER' + safePlaces[i].name);
        }
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
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
                  child: lot.Lottie.asset('assets/lottie/alert.json'),
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
                  child: lot.Lottie.asset('assets/lottie/alert.json'),
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
                  child: lot.Lottie.asset('assets/lottie/alert.json'),
                  onPressed: () {
                    navigateWelfare();
                  }),
            IconButton(
              icon: Icon(Icons.settings, size: 35),
              onPressed: () async {
                var value = await showTopModalSheet<String>(
                    context: context, child: MapTopMenu());

                if (value != null) {
                  autoSetCategory.setCategory(value);
                  // setState(() {
                  //   _topModalData = "$value";
                  //   print('SELECTED ' + autoSetCategory.shouldGoCategory);
                  // });
                }
              },
            ),
          ]),
      key: _mapPlacesKey,
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
        CustomListTile(languages[selectedLanguage[languageIndex]]['sideMenu2'],
            FontAwesomeIcons.hardHat, Home(user, observer, analytics), false),
        CustomListTile(
            languages[selectedLanguage[languageIndex]]['sideMenu3'],
            FontAwesomeIcons.map,
            MapPlacesWrapper(user, observer, analytics),
            true),
        CustomListTile(languages[selectedLanguage[languageIndex]]['settings'],
            FontAwesomeIcons.cog, SettingsWrapper(), false),
      ])),
      body: Container(
        height: screenHeightExcludingToolbar(context, dividedBy: 1.05),
        child: GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomGesturesEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(23.8103, 90.4125),
            zoom: 15.0,
          ),
          //circles: Set<Circle>.of(circles.values),
          markers: _markers,
          //markers: Set.of((marker != null) ? [marker] : []),
          //onMapCreated: _onMapCreated,
          // onLongPress: (LatLng pos) {
          //   setState(() {
          //     _lastLongPress = pos;
          //     _add(pos, false, '', 100);
          //   });
          // },
        ),
      ),
    );
  }
}
