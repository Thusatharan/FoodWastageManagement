import 'package:food_wastage_management/models/food.dart';
import 'package:food_wastage_management/models/organization.dart';

class Order {
  final Organization restaurant;
  final Food food;
  final String date;
  final int quantity;

  Order({
    this.date,
    this.restaurant,
    this.food,
    this.quantity,
  });
}
