// import 'package:bhaithamen/data/news_feed.dart';
// import 'package:bhaithamen/utilities/fb_test.dart';
// import 'package:bhaithamen/utilities/language_data.dart';
// import 'package:bhaithamen/utilities/variables.dart';
// import 'package:date_format/date_format.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
// import 'package:share/share.dart';
// import 'package:flutter_linkify/flutter_linkify.dart';
// import 'package:url_launcher/url_launcher.dart';

// class NewsPage extends StatefulWidget {
//   @override
//   _NewsPageState createState() => _NewsPageState();
// }

// class _NewsPageState extends State<NewsPage> {
//   String uid;
//   List<bool> isSelected = [true, false, false];
//   int selectedIndex = 0;
//   List<NewsFeed> newsList = List<NewsFeed>();
//   List catChoice = ['news', 'info', 'warn'];

//   initState() {
//     super.initState();
//     getCurrentUserUID();
//     sendResearchReport('News_Section');
//   }

//   String getPubDate(DateTime date) {
//     //DateTime getToday =  new DateTime.now();  //DateTime(2020, 10, 13);

//     print(date);

//     String returnDate;

//     String year = formatDate(date, [yyyy]);
//     String month = formatDate(date, [mm]);
//     String fullMonth = formatDate(date, [MM]);
//     String day = formatDate(date, [dd]);
//     String hour = formatDate(date, [HH, ':', nn]);
//     //String min = formatDate(date, []);

//     //today = DateTime(year, month, day);

//     //print('today is ' + today.toString());

//     returnDate = day +
//         ' ' +
//         fullMonth +
//         ' ' +
//         year +
//         ' at ' +
//         hour; //DateTime(year, month, day).toString();

//     return returnDate;
//   }

//   getCurrentUserUID() async {
//     var firebaseuser = FirebaseAuth.instance.currentUser;

//     DocumentSnapshot userInfo =
//         await userCollection.doc(firebaseuser.uid).get();
//     setState(() {
//       uid = firebaseuser.uid;
//     });
//   }

//   likePost(String docId) async {
//     var firebaseuser = FirebaseAuth.instance.currentUser;
//     DocumentSnapshot document = await newsCollection.doc(docId).get();

//     if (document['likes'].contains(firebaseuser.uid)) {
//       newsCollection.doc(docId).update({
//         'likes': FieldValue.arrayRemove([firebaseuser.uid]),
//       });
//     } else {
//       newsCollection.doc(docId).update({
//         'likes': FieldValue.arrayUnion([firebaseuser.uid]),
//       });
//     }
//   }

//   sharePost(String docId, String title, String tweet) async {
//     String msg = title +
//         '\n\n' +
//         tweet +
//         '\n\n' +
//         'Shared from Bhai Thamen https://bhaithamen.com';
//     Share.share(msg, subject: 'Bhai Thamen');
//     DocumentSnapshot document = await newsCollection.doc(docId).get();
//     newsCollection.doc(docId).update({'shares': document['shares'] + 1});
//   }

//   Future<void> _onOpen(LinkableElement link) async {
//     if (await canLaunch(link.url)) {
//       await launch(link.url);
//     } else {
//       throw 'Could not launch $link';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final allNews = Provider.of<List<NewsFeed>>(context);

//     if (allNews != null) {
//       //allNews.sort((a, b) => b.likes.length.compareTo(a.likes.length));
//       allNews.sort((a, b) => b.time.compareTo(a.time));
//       newsList =
//           allNews.where((i) => i.category == catChoice[selectedIndex]).toList();
//     }
//     return newsList == null
//         ? Center(child: CircularProgressIndicator())
//         : Column(
//             children: [
//               Container(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     //buttons across top of screen
//                     ToggleButtons(
//                       color: Colors.white,
//                       selectedColor: Colors.black,
//                       fillColor: Colors.red[600],
//                       borderColor: Colors.white,
//                       children: <Widget>[
//                         isSelected[0]
//                             ? Container(
//                                 width:
//                                     (MediaQuery.of(context).size.width - 12) /
//                                         3,
//                                 child: new Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     new Icon(
//                                       Icons.new_releases,
//                                       size: 16.0,
//                                       color: Colors.white,
//                                     ),
//                                     new SizedBox(
//                                       width: 4.0,
//                                     ),
//                                     new Text(
//                                       languages[selectedLanguage[languageIndex]]
//                                           ['proximity'],
//                                       style: TextStyle(color: Colors.white),
//                                     )
//                                   ],
//                                 ))
//                             : Container(
//                                 width:
//                                     (MediaQuery.of(context).size.width - 12) /
//                                         3,
//                                 child: new Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     new Icon(
//                                       Icons.new_releases,
//                                       size: 16.0,
//                                       color: Colors.black,
//                                     ),
//                                     new SizedBox(
//                                       width: 4.0,
//                                     ),
//                                     new Text(
//                                       languages[selectedLanguage[languageIndex]]
//                                           ['popular'],
//                                       style: TextStyle(color: Colors.black),
//                                     )
//                                   ],
//                                 )),
//                         isSelected[1]
//                             ? Container(
//                                 width:
//                                     (MediaQuery.of(context).size.width - 12) /
//                                         3,
//                                 child: new Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     new Icon(
//                                       Icons.info,
//                                       size: 16.0,
//                                       color: Colors.white,
//                                     ),
//                                     new SizedBox(
//                                       width: 4.0,
//                                     ),
//                                     new Text(
//                                         languages[
//                                                 selectedLanguage[languageIndex]]
//                                             ['recent'],
//                                         style: TextStyle(color: Colors.white))
//                                   ],
//                                 ))
//                             : Container(
//                                 width:
//                                     (MediaQuery.of(context).size.width - 12) /
//                                         3,
//                                 child: new Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     new Icon(
//                                       Icons.info,
//                                       size: 16.0,
//                                       color: Colors.black,
//                                     ),
//                                     new SizedBox(
//                                       width: 4.0,
//                                     ),
//                                     new Text(
//                                         languages[
//                                                 selectedLanguage[languageIndex]]
//                                             ['info'],
//                                         style: TextStyle(color: Colors.black))
//                                   ],
//                                 )),
//                         isSelected[2]
//                             ? Container(
//                                 width:
//                                     (MediaQuery.of(context).size.width - 12) /
//                                         3,
//                                 child: new Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     new Icon(
//                                       Icons.warning,
//                                       size: 16.0,
//                                       color: Colors.white,
//                                     ),
//                                     new SizedBox(
//                                       width: 4.0,
//                                     ),
//                                     new Text(
//                                         languages[
//                                                 selectedLanguage[languageIndex]]
//                                             ['alert'],
//                                         style: TextStyle(color: Colors.white))
//                                   ],
//                                 ))
//                             : Container(
//                                 width:
//                                     (MediaQuery.of(context).size.width - 12) /
//                                         3,
//                                 child: new Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     new Icon(
//                                       Icons.warning,
//                                       size: 16.0,
//                                       color: Colors.black,
//                                     ),
//                                     new SizedBox(
//                                       width: 4.0,
//                                     ),
//                                     new Text(
//                                         languages[
//                                                 selectedLanguage[languageIndex]]
//                                             ['alert'],
//                                         style: TextStyle(color: Colors.black))
//                                   ],
//                                 )),
//                       ],
//                       onPressed: (int index) {
//                         setState(() {
//                           selectedIndex = index;
//                           mapIsShowing = false;
//                           for (int buttonIndex = 0;
//                               buttonIndex < isSelected.length;
//                               buttonIndex++) {
//                             if (buttonIndex == index) {
//                               isSelected[buttonIndex] = true;
//                             } else {
//                               isSelected[buttonIndex] = false;
//                             }
//                           }
//                           if (selectedIndex == 0) {
//                             sendResearchReport('News_Section');
//                           }
//                           if (selectedIndex == 1) {
//                             sendResearchReport('Info_Section');
//                           }
//                           if (selectedIndex == 2) {
//                             sendResearchReport('Alert_Section');
//                           }
//                         });
//                       },
//                       isSelected: isSelected,
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height -
//                     kBottomNavigationBarHeight -
//                     150,
//                 child: ListView.builder(
//                     itemCount: newsList.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       //DocumentSnapshot feeddoc = allNews[index];
//                       NewsFeed feeddoc = newsList[index];
//                       return
//                           // feeddoc.show != true
//                           //     ? Container()
//                           //:
//                           Card(
//                               margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
//                               child: ListTile(
//                                   // leading: CircleAvatar(
//                                   //   backgroundColor: Colors.white,
//                                   //   backgroundImage: feeddoc['profilepic'] == 'default'
//                                   //       ? AssetImage('images/defaultAvatar.png')
//                                   //       : NetworkImage(feeddoc['profilepic']),
//                                   // ),
//                                   title: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         feeddoc.title,
//                                         style: myStyle(
//                                             18, Colors.blue, FontWeight.w600),
//                                       ),
//                                       Text(getPubDate(feeddoc.time))
//                                     ],
//                                   ),
//                                   subtitle: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       SizedBox(height: 10),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           feeddoc.image == ''
//                                               ? Container()
//                                               : Padding(
//                                                   padding: const EdgeInsets.all(
//                                                       12.0),
//                                                   child: Image(
//                                                     image: NetworkImage(
//                                                         feeddoc.image),
//                                                   ),
//                                                 ),
//                                           Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: Linkify(
//                                                   onOpen: _onOpen,
//                                                   text: feeddoc.article,
//                                                   style: myStyle(
//                                                       16,
//                                                       Colors.black,
//                                                       FontWeight.w400))
//                                               // Text(
//                                               //   feeddoc.article,
//                                               //   style: myStyle(16, Colors.black,
//                                               //       FontWeight.w400),
//                                               // ),
//                                               ),
//                                           SizedBox(height: 10),
//                                         ],
//                                       ),
//                                       SizedBox(height: 10),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Spacer(),
//                                           Row(
//                                             children: [
//                                               InkWell(
//                                                   onTap: () =>
//                                                       likePost(feeddoc.uid),
//                                                   child: feeddoc.likes
//                                                           .contains(uid)
//                                                       ? Icon(Icons.favorite,
//                                                           size: 20,
//                                                           color: Colors.red)
//                                                       : Icon(
//                                                           Icons.favorite_border,
//                                                           size: 20)),
//                                               SizedBox(width: 10),
//                                               Text(
//                                                   feeddoc.likes.length
//                                                       .toString(),
//                                                   style: myStyle(
//                                                       16, Colors.grey[600])),
//                                             ],
//                                           ),
//                                           Spacer(),
//                                           Row(
//                                             children: [
//                                               InkWell(
//                                                   onTap: () => sharePost(
//                                                       feeddoc.uid,
//                                                       feeddoc.title,
//                                                       feeddoc.article),
//                                                   child: Icon(Icons.share,
//                                                       size: 20)),
//                                               SizedBox(width: 10),
//                                               Text(feeddoc.shares.toString(),
//                                                   style: myStyle(
//                                                       16, Colors.grey[600])),
//                                             ],
//                                           ),
//                                           Spacer(),
//                                         ],
//                                       ),
//                                     ],
//                                   )));
//                     }),
//               ),
//             ],
//           );
//   }
// }
