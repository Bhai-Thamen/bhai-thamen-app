import 'package:cloud_firestore/cloud_firestore.dart';

class SafePlace {
  final String details;
  final String docId;
  final String price;
  final String name;
  final String category;
  final List<dynamic> images;
  final GeoPoint location;
  final int rating;
  final DateTime time;

  SafePlace(
      {this.details,
      this.location,
      this.category,
      this.time,
      this.rating,
      this.price,
      this.images,
      this.name,
      this.docId});

  Map<String, dynamic> toMap() {
    return {
      'details': details,
      'time': time,
      'name': name,
      'category': category,
      'images': images,
      'price': price,
      'location': location,
      'rating': rating,
      'docId': docId
    };
  }

  static SafePlace fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SafePlace(
        location: map['location'],
        time: map['time'],
        name: map['name'],
        category: map['category'],
        images: map['images'],
        details: map['details'],
        rating: map['rating'],
        price: map['price'],
        docId: map['docId']);
  }
}
