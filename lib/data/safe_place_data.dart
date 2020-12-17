import 'package:cloud_firestore/cloud_firestore.dart';

class SafePlace {
  final String detailsEN;
  final String detailsBN;
  final String docId;
  final String price;
  final String phone;
  final String name;
  final String category;
  final List<dynamic> images;
  final GeoPoint location;
  final int rating;
  final int raters;
  final DateTime time;

  SafePlace(
      {this.detailsEN,
      this.detailsBN,
      this.location,
      this.category,
      this.time,
      this.phone,
      this.rating,
      this.raters,
      this.price,
      this.images,
      this.name,
      this.docId});

  Map<String, dynamic> toMap() {
    return {
      'detailsEN': detailsEN,
      'detailsBN': detailsBN,
      'time': time,
      'name': name,
      'phone': phone,
      'category': category,
      'images': images,
      'price': price,
      'location': location,
      'rating': rating,
      'raters': raters,
      'docId': docId
    };
  }

  static SafePlace fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SafePlace(
        location: map['location'],
        time: map['time'],
        name: map['name'],
        phone: map['phone'],
        category: map['category'],
        images: map['images'],
        detailsEN: map['detailsEN'],
        detailsBN: map['detailsBN'],
        rating: map['rating'],
        raters: map['raters'],
        price: map['price'],
        docId: map['docId']);
  }
}
