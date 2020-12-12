import 'dart:async';
import 'dart:io';

import 'package:bhaithamen/data/news_feed.dart';
import 'package:bhaithamen/data/user_news_feed.dart';
import 'package:bhaithamen/screens/multi_picker.dart';
import 'package:bhaithamen/screens/news_news.dart';
import 'package:bhaithamen/screens/user_news.dart';
import 'package:bhaithamen/utilities/auth.dart';
import 'package:bhaithamen/utilities/language_data.dart';
import 'package:bhaithamen/utilities/report_event.dart';
import 'package:bhaithamen/utilities/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:location/location.dart' as flutLoc;

flutLoc.Location location = new flutLoc.Location();
flutLoc.LocationData myLocationData;

class NewsWrapper extends StatefulWidget {
  @override
  _NewsWrapperState createState() => _NewsWrapperState();
}

class _NewsWrapperState extends State<NewsWrapper> {
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
  var uuid = Uuid();

  initState() {
    super.initState();
    getCurrentUserInfo();
    print('MPI ' + multiPickedImages.length.toString());
  }

  getCurrentUserInfo() async {
    var firebaseuser = FirebaseAuth.instance.currentUser;
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
        quality: 20); // requestOriginal is being deprecated
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
      reportLocation = await getUserLocation();
      //print(imageUrls);
      //print(reportLocation);

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

  List newsPageOptions = [UserNewsPage(), NewsPage(), NewsPage()];

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
    print(value);
    setState(() {
      doShow();
    });
  }

  void navigateSettings() {
    Route route =
        MaterialPageRoute(builder: (context) => MultiImagePickerScreen());
    Navigator.push(context, route).then(onGoBack);
  }

  @override
  Widget build(BuildContext context) {
    thisContext = context;

    return MultiProvider(
      providers: [
        StreamProvider<List<NewsFeed>>.value(
            value: AuthService(uid: uid).getNews),
        StreamProvider<List<UserNewsFeed>>.value(
            value: AuthService(uid: uid).getUserNews),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                  child: Image.asset('assets/images/cross.png'),
                  onPressed: () => doShow()),
            ),
          ],
        ),
        body: Column(
          children: [
            newsPageOptions[newsPageIndex],
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              //set page variable = to index (0,1 or 2) depending on which button was pressed
              newsPageIndex = index;
              mapIsShowing = false;
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
          ],
        ),
      ),
    );
  }
}
