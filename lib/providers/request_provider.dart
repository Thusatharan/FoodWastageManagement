import 'package:flutter/cupertino.dart';
import 'package:food_wastage_management/models/deliveryMan.dart';
import 'package:food_wastage_management/models/food.dart';
import 'package:food_wastage_management/models/request.dart';

class Requests with ChangeNotifier {
  List<Request> _requests = [
    Request(
      id: 'r1',
      receiverName: 'Thusanth',
      receiverAddress: 'Urumpurai west, Kondavil',
      receiverContactNo: '0764834136',
      deliveryManDetails: DeliveryMan(
        id: 'd1',
        name: 'vimal',
        contactNo: '0213423434',
      ),
      foodDetail: Food(
          id: 'f1',
          name: 'Pasta',
          imageUrl:
              'https://www.budgetbytes.com/wp-content/uploads/2013/07/Creamy-Spinach-Tomato-Pasta-bowl-500x375.jpg'),
      requestedQuantity: 5,
      timestamp: DateTime.now().toIso8601String(),
    ),
    Request(
      id: 'r2',
      receiverName: 'Ajikaran',
      receiverAddress: 'Kokuvil west, Kokuvil',
      receiverContactNo: '0756828044',
      //deliveryManDetails: ,
      foodDetail: Food(
          id: 'f2',
          name: 'Noodles',
          imageUrl:
              'https://www.cookwithmanali.com/wp-content/uploads/2014/11/Hakka-Noodles-1-500x500.jpg'),
      requestedQuantity: 3,
      timestamp: DateTime.now().toIso8601String(),
    ),
  ];

  List<Request> get requests {
    return [..._requests];
  }

  void addRequest() {
    //
    notifyListeners();
  }
}
