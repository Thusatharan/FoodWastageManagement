import 'package:flutter/cupertino.dart';
import 'package:food_wastage_management/models/receiver.dart';

class Receivers with ChangeNotifier {
  List<Receiver> _receivers = [
    Receiver(
      id: 'r1',
      receiverName: 'Bala',
      receiverAddress: 'Jaffna',
      receiverImageUrl: 'https://ui-avatars.com/api/?name=Bala&background=FF5500&color=fff&length=1%27',
    ),
    Receiver(
      id: 'r2',
      receiverName: 'Som',
      receiverAddress: 'Kilinochchi',
      receiverImageUrl: 'https://ui-avatars.com/api/?name=Som&background=FF5500&color=fff&length=1%27',
    ),
    Receiver(
      id: 'r3',
      receiverName: 'Gaby',
      receiverAddress: 'Vavuniya',
      receiverImageUrl: 'https://ui-avatars.com/api/?name=Gaby&background=FF5500&color=fff&length=1%27',
    ),
  ];

  List<Receiver> get receivers {
    return [..._receivers];
  }

  // begin receivers search screen

  String _searchString;

  List<Receiver> get searchReceivers {
    return _receivers
        .where((rc) =>
            rc.receiverName.toLowerCase().contains(_searchString) ||
            rc.receiverName.contains(_searchString))
        .toList();
  }

  void addSearchString(String searchText) {
    _searchString = searchText;
    notifyListeners();
  }

  // end receivers search screen

  void addReceiver() {
    //
    notifyListeners();
  }
}
