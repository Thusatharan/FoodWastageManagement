import 'package:food_wastage_management/models/food.dart';

class Organization {
  final String id;
  final String name;
  final String location;
  final String registrationNo;
  final String imageUrl;
  final String mobile;
  final int rating;
  final List<Food> menu;

  Organization({
    this.id,
    this.name,
    this.location,
    this.registrationNo,
    this.imageUrl,
    this.mobile,
    this.rating,
    this.menu,
  });
}
