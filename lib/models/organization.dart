import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_wastage_management/models/food.dart';

class Organization {
  final String id;
  final String name;
  final String address;
  final String registrationNo;
  final String imageUrl;
  final String contactNo;
  final int rating;
  final List<Food> menu;

  Organization({
    this.id,
    this.name,
    this.address,
    this.registrationNo,
    this.imageUrl,
    this.contactNo,
    this.rating,
    this.menu,
  });

  factory Organization.fromDocument(DocumentSnapshot doc) {
    return Organization(
      id: doc['id'],
      name: doc['name'],
      address: doc['address'],
      rating: int.tryParse(doc['rating']) ?? 0,
      contactNo: doc['contactNo'],
      imageUrl: doc['imageUrl'],
      registrationNo: doc['registrationNo'],
    );
  }
}
