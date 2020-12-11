import 'package:bhaithamen/data/user_news_feed.dart';
import 'package:bhaithamen/utilities/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class UserArticle extends StatefulWidget {
  final UserNewsFeed userArticle;
  UserArticle(this.userArticle);
  @override
  _UserArticleState createState() => _UserArticleState();
}

class _UserArticleState extends State<UserArticle> {
  TextEditingController myComment = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool bottomPadding = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        bottomPadding = true;
      } else {
        bottomPadding = false;
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  String getPubDate(DateTime date) {
    String returnDate;

    String year = formatDate(date, [yyyy]);
    String month = formatDate(date, [mm]);
    String fullMonth = formatDate(date, [MM]);
    String day = formatDate(date, [dd]);
    String hour = formatDate(date, [HH, ':', nn]);

    returnDate = day + ' ' + fullMonth + ' ' + year + ' at ' + hour;

    return returnDate;
  }

  postComment() async {
    if (myComment.text.replaceAll(' ', '') != '') {
      userNewsCollection.doc(widget.userArticle.docId).update({
        'comments': FieldValue.arrayUnion([myComment.text]),
      });
    }
  }

  likePost(String docId) async {
    var firebaseuser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot document =
        await userNewsCollection.doc(widget.userArticle.docId).get();

    if (document['likes'].contains(firebaseuser.uid)) {
      userNewsCollection.doc(widget.userArticle.docId).update({
        'likes': FieldValue.arrayRemove([firebaseuser.uid]),
      });
    } else {
      userNewsCollection.doc(widget.userArticle.docId).update({
        'likes': FieldValue.arrayUnion([firebaseuser.uid]),
      });
    }
  }

  sharePost(String docId, String title, String tweet) async {
    String msg = title +
        '\n\n' +
        tweet +
        '\n\n' +
        'Shared from Bhai Thamen https://bhaithamen.com';
    Share.share(msg, subject: 'Bhai Thamen');
    DocumentSnapshot document =
        await userNewsCollection.doc(widget.userArticle.docId).get();
    userNewsCollection.doc(docId).update({'shares': document['shares'] + 1});
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              child: Image.asset('assets/images/cross.png'),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 150,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(children: [
                    Card(
                        margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                        child: ListTile(
                            // leading: CircleAvatar(
                            //   backgroundColor: Colors.white,
                            //   backgroundImage: feeddoc['profilepic'] == 'default'
                            //       ? AssetImage('images/defaultAvatar.png')
                            //       : NetworkImage(feeddoc['profilepic']),
                            // ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.userArticle.userName,
                                  style:
                                      myStyle(18, Colors.blue, FontWeight.w600),
                                ),
                                Text(getPubDate(widget.userArticle.time))
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.userArticle.images.length == 0
                                        ? Container()
                                        : Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Image(
                                                height: 200,
                                                image: NetworkImage(widget
                                                    .userArticle.images[0]),
                                              ),
                                            ),
                                          ),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Linkify(
                                            onOpen: _onOpen,
                                            text: widget.userArticle.article,
                                            style: myStyle(16, Colors.black,
                                                FontWeight.w400))
                                        // Text(
                                        //   feeddoc.article,
                                        //   style: myStyle(16, Colors.black,
                                        //       FontWeight.w400),
                                        // ),
                                        ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Spacer(),
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: () => likePost(
                                                widget.userArticle.uid),
                                            child: widget.userArticle.likes
                                                    .contains(
                                                        widget.userArticle.uid)
                                                ? Icon(Icons.favorite,
                                                    size: 20, color: Colors.red)
                                                : Icon(Icons.favorite_border,
                                                    size: 20)),
                                        SizedBox(width: 10),
                                        Text(
                                            widget.userArticle.likes.length
                                                .toString(),
                                            style:
                                                myStyle(16, Colors.grey[600])),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: () => sharePost(
                                                widget.userArticle.uid,
                                                widget.userArticle.title,
                                                widget.userArticle.article),
                                            child: Icon(Icons.share, size: 20)),
                                        SizedBox(width: 10),
                                        Text(
                                            widget.userArticle.shares
                                                .toString(),
                                            style:
                                                myStyle(16, Colors.grey[600])),
                                      ],
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ],
                            ))),
                    for (var i = 0; i < widget.userArticle.comments.length; i++)
                      Text(widget.userArticle.comments[i]),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 5, 12, 5),
                      child: SizedBox(
                        height: 100,
                        child: Row(children: [
                          SizedBox(
                            width: 220,
                            child: TextField(
                              scrollPadding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              focusNode: _focusNode,
                              minLines: 1,
                              maxLines: 8,
                              autofocus: false,
                              controller: myComment,
                            ),
                          ),
                          FlatButton(
                            color: Colors.blue,
                            child: Text('post'),
                            onPressed: () {
                              postComment();
                            },
                          ),
                        ]),
                      ),
                    ),
                    bottomPadding
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height / 2)
                        : SizedBox(height: 0)
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}