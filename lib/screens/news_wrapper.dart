import 'dart:async';
import 'dart:io';

import 'package:bhaithamen/data/alerts_feed.dart';
import 'package:bhaithamen/data/news_feed.dart';
import 'package:bhaithamen/data/user.dart';
import 'package:bhaithamen/data/userData.dart';
import 'package:bhaithamen/data/user_news_feed.dart';
import 'package:bhaithamen/screens/alerts_news.dart';
import 'package:bhaithamen/screens/custom_list_tile.dart';
import 'package:bhaithamen/screens/home.dart';
import 'package:bhaithamen/screens/map_places.dart';
import 'package:bhaithamen/screens/map_places_wrapper.dart';
import 'package:bhaithamen/screens/map_wrapper.dart';
import 'package:bhaithamen/screens/multi_picker.dart';
import 'package:bhaithamen/screens/news_news.dart';
import 'package:bhaithamen/screens/settings_wrapper.dart';
import 'package:bhaithamen/screens/user_news.dart';
import 'package:bhaithamen/screens/welfare_check.dart';
import 'package:bhaithamen/utilities/auth.dart';
import 'package:bhaithamen/utilities/auto_page_navigation.dart';
import 'package:bhaithamen/utilities/language_data.dart';
import 'package:bhaithamen/utilities/report_event.dart';
import 'package:bhaithamen/utilities/variables.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:location/location.dart' as flutLoc;

flutLoc.Location location = new flutLoc.Location();
flutLoc.LocationData myLocationData;

class NewsWrapper extends StatefulWidget {
  final User user;
  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;

  NewsWrapper(this.user, this.observer, this.analytics);
  @override
  _NewsWrapperState createState() =>
      _NewsWrapperState(user, observer, analytics);
}

class _NewsWrapperState extends State<NewsWrapper> {
  _NewsWrapperState(this.user, this.observer, this.analytics);

  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;
  final User user;

  AutoHomePageWelfareSelect homePageWelfare;

  String uid;
  TextEditingController myNews = TextEditingController();
  File _imageFile;
  String pickedImagePath;
  BuildContext thisContext;
  List<Asset> images = List<Asset>();
  List<String> firebaseUrls = List<String>();
  String userName = '';
  String userPhone = '';
  String userEmail = '';
  String profilePic = '';
  bool isUploading = false;
  bool shareLocation = false;
  var uuid = Uuid();

  initState() {
    super.initState();
    getCurrentUserInfo();
    canCompose = true;
    checkPerm();
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

    //appHasStarted = await awaitStarted();
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

  Future saveImage(Asset asset) async {
    var imgUid = uuid.v1();
    String savePath = uid + '/' + imgUid + '.jpg';

    ByteData byteData = await asset.getByteData(
        quality: 10); // requestOriginal is being deprecated
    List<int> imageData = byteData.buffer.asUint8List();
    StorageReference ref = userNews.child(savePath);
    // To be aligned with the latest firebase API(4.0)
    StorageUploadTask uploadTask = ref.putData(imageData);

    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  _postComment() async {
    print('post ');
    if (myNews.text.replaceAll(' ', '') != '') {
      List<String> imageUrls = List<String>();
      GeoPoint reportLocation;

      for (var i = 0; i < multiPickedImages.length; i++) {
        dynamic url = await saveImage(multiPickedImages[i]);
        imageUrls.add(url);
      }

      if (shareLocation == true) {
        reportLocation = await getUserLocation();
      } else {
        reportLocation = null;
      }

      int unixDate = getDate().toUtc().millisecondsSinceEpoch;

      final userNewsFeedDoc = UserNewsFeed(
              time: DateTime.now(),
              unixTime: unixDate,
              userName: userName,
              uid: uid,
              userPhone: userPhone,
              location: reportLocation,
              article: myNews.text,
              likes: [],
              reports: [],
              comments: [],
              shares: 0,
              images: imageUrls,
              show: true,
              profilePic: profilePic)
          .toMap();

      userNewsCollection.doc().set(userNewsFeedDoc).then((doc) {
        print('POST DONE');
        setState(() {
          isUploading = false;
          imageUrls = [];
          multiPickedImages = [];
          myNews.text = '';
          Navigator.pop(context);
        });
      });
    }
  }

  int newsPageIndex = 0;

  List newsPageOptions = [
    UserNewsPage(false),
    NewsPage(),
    AlertsNewsPage(),
    UserNewsPage(true)
  ];

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(multiPickedImages.length, (index) {
        Asset asset = multiPickedImages[index];
        return GestureDetector(
          onLongPress: () {
            multiPickedImages.removeAt(index);
          },
          child: AssetThumb(
            asset: asset,
            width: 100,
            height: 100,
          ),
        );
      }),
    );
  }

  _switchLocationSharing(bool share) {
    setState(() {
      shareLocation = !shareLocation;
    });
  }

  doShow() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setModalState /*You can rename this!*/) {
            return !isUploading
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 12.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Share something...',
                                      style: myStyle(21)),
                                  Spacer(),
                                  FlatButton(
                                    color: Colors.blue,
                                    child: Text('img'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      navigateSettings();
                                    },
                                  ),
                                ])),
                        SizedBox(
                          height: 4.0,
                        ),
                        multiPickedImages.length > 0
                            ? SizedBox(
                                height: 150,
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: GridView.count(
                                      crossAxisCount: 3,
                                      children: List.generate(
                                          multiPickedImages.length, (index) {
                                        Asset asset = multiPickedImages[index];
                                        return GestureDetector(
                                          onLongPress: () {
                                            setModalState(() {
                                              multiPickedImages.removeAt(index);
                                            });
                                          },
                                          child: AssetThumb(
                                            asset: asset,
                                            width: 100,
                                            height: 100,
                                          ),
                                        );
                                      }),
                                    )),
                                  ],
                                ),
                              )
                            : Container(),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            shareLocation
                                ? Text(
                                    languages[selectedLanguage[languageIndex]]
                                        ['locationSharingStatusOn'],
                                    style: myStyle(18))
                                : Text(
                                    languages[selectedLanguage[languageIndex]]
                                        ['locationSharingStatusOff'],
                                    style: myStyle(18)),
                            Switch(
                                activeColor: Colors.red[500],
                                inactiveThumbColor: Colors.black54,
                                value: shareLocation,
                                onChanged: (bool val) {
                                  setModalState(() {
                                    shareLocation = !shareLocation;
                                  });
                                }),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                              left: 5.0,
                              right: 5.0,
                            ),
                            child: Row(children: [
                              SizedBox(
                                width: 220,
                                child: TextField(
                                  minLines: 1,
                                  maxLines: 8,
                                  autofocus: false,
                                  controller: myNews,
                                ),
                              ),
                              FlatButton(
                                color: Colors.blue,
                                child: Text('post'),
                                onPressed: () {
                                  setModalState(() {
                                    isUploading = true;
                                  });
                                  _postComment();
                                },
                              ),
                            ])),
                        SizedBox(height: 50),
                      ],
                    ),
                  )
                : SizedBox(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 60,
                          ),
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            'Posting...',
                            style: myStyle(21),
                          )
                        ],
                      ),
                    ),
                    height: 250,
                  );
          });
        });
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {
      doShow();
    });
  }

  void navigateSettings() {
    Route route =
        MaterialPageRoute(builder: (context) => MultiImagePickerScreen());
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

  void navigateWelfare() {
    Route route = MaterialPageRoute(builder: (context) => WelfareCheck());
    Navigator.push(context, route);
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

    thisContext = context;

    return MultiProvider(
      providers: [
        StreamProvider<UserData>.value(value: AuthService(uid: uid).userData),
        StreamProvider<List<NewsFeed>>.value(
            value: AuthService(uid: uid).getNews),
        StreamProvider<List<UserNewsFeed>>.value(
            value: AuthService(uid: uid).getUserNews),
        StreamProvider<List<AlertsFeed>>.value(
            value: AuthService(uid: uid).getAlerts),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Home(user, observer, analytics)),
                      );
                    });
                  }),
            if (homePageWelfare.shouldGoWelfare)
              FlatButton(
                  child: Lottie.asset('assets/lottie/alert.json'),
                  onPressed: () {
                    navigateWelfare();
                  }),
            !canCompose
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      onPressed: () {
                        shareLocation = false;
                        doShow();
                      },
                      color: Colors.white,
                      textColor: Colors.blue,
                      child: Icon(
                        Icons.edit,
                        size: 24,
                      ),
                      //padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ),
                  ),
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

                    //Image.network(profilePic, height: 70, width: 70),
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
              true),
          CustomListTile(
              languages[selectedLanguage[languageIndex]]['sideMenu2'],
              FontAwesomeIcons.hardHat,
              Home(user, observer, analytics),
              false),
          CustomListTile(
              languages[selectedLanguage[languageIndex]]['sideMenu3'],
              FontAwesomeIcons.map,
              MapPlacesWrapper(user, observer, analytics),
              false),
          CustomListTile(languages[selectedLanguage[languageIndex]]['settings'],
              FontAwesomeIcons.cog, SettingsWrapper(), false),
        ])),
        body: Column(
          children: [
            newsPageOptions[newsPageIndex],
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,

          onTap: (index) {
            //userNews.scrollToTop();
            setState(() {
              //set page variable = to index (0,1 or 2) depending on which button was pressed
              newsPageIndex = index;
              mapIsShowing = false;
              if (newsPageIndex == 0 || newsPageIndex == 3) {
                canCompose = true;
              } else {
                canCompose = false;
              }
            });
          },
          fixedColor: Colors.blue[700],
          backgroundColor: Colors.white70,
          elevation: 12.0,
          selectedFontSize: 17,
          //selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.grey[600],
          currentIndex: newsPageIndex,
          items: [
            //3 buttons across bottom of screen
            BottomNavigationBarItem(
                icon: newsPageIndex == 0
                    ? Icon(Icons.people_alt_outlined, size: 24)
                    : Icon(Icons.people_alt_outlined, size: 22),
                label: languages[selectedLanguage[languageIndex]]['community']),
            BottomNavigationBarItem(
                icon: newsPageIndex == 1
                    ? Icon(Icons.chrome_reader_mode, size: 24)
                    : Icon(Icons.chrome_reader_mode, size: 22),
                label: languages[selectedLanguage[languageIndex]]['news']),
            BottomNavigationBarItem(
                icon: newsPageIndex == 2
                    ? Icon(Icons.warning_amber_outlined, size: 26)
                    : Icon(Icons.warning_amber_outlined, size: 22),
                label: languages[selectedLanguage[languageIndex]]['warn']),
            BottomNavigationBarItem(
                icon: newsPageIndex == 3
                    ? Icon(Icons.person, size: 26)
                    : Icon(Icons.person, size: 22),
                label: languages[selectedLanguage[languageIndex]]['myposts'])
          ],
        ),
      ),
    );
  }
}
