import 'package:cloud_firestore/cloud_firestore.dart';

class UserNewsFeed {
  final String docId;
  final String userName;
  final String userPhone;
  final String article;
  final String title;
  final String uid;
  final DateTime time;
  final int unixTime;
  final int shares;
  final GeoPoint location;
  final List<dynamic> likes;
  final List<dynamic> images;
  final List<dynamic> reports;
  final List<dynamic> comments;
  final bool show;
  final String profilePic;

  UserNewsFeed(
      {this.docId,
      this.uid,
      this.userName,
      this.userPhone,
      this.article,
      this.time,
      this.unixTime,
      this.title,
      this.location,
      this.likes,
      this.shares,
      this.comments,
      this.images,
      this.show,
      this.profilePic,
      this.reports});

  Map<String, dynamic> toMap() {
    return {
      'docId': docId,
      'uid': uid,
      'userName': userName,
      'userPhone': userPhone,
      'article': article,
      'time': time,
      'unixTime': unixTime,
      'likes': likes,
      'comments': comments,
      'location': location,
      'reports': reports,
      'title': title,
      'shares': shares,
      'images': images,
      'show': show,
      'category': profilePic,
    };
  }

  static UserNewsFeed fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserNewsFeed(
        userName: map['userName'],
        userPhone: map['userPhone'],
        uid: map['uid'],
        docId: map['docId'],
        article: map['article'],
        time: map['time'],
        unixTime: map['unixTime'],
        likes: map['likes'],
        shares: map['shares'],
        images: map['images'],
        comments: map['comments'],
        location: map['location'],
        title: map['title'],
        reports: map['reports'],
        profilePic: map['profilePic'],
        show: map['show']);
  }
}
