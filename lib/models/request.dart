import 'package:flutter/cupertino.dart';
import 'package:food_wastage_management/models/deliveryMan.dart';
import 'package:food_wastage_management/models/food.dart';

class Request {
  final String id;
  final String receiverName;
  final String receiverAddress;
  final String receiverContactNo;
  final DeliveryMan deliveryManDetails;
  final Food foodDetail;
  final int requestedQuantity;
  final String timestamp;

  Request({
    @required this.id,
    @required this.receiverName,
    @required this.receiverAddress,
    @required this.receiverContactNo,
    this.deliveryManDetails,
    @required this.foodDetail,
    this.requestedQuantity,
    @required this.timestamp,
  });
}
