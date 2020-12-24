import 'package:flutter/cupertino.dart';
import 'package:food_wastage_management/models/organization.dart';

class Organizations with ChangeNotifier {
  List<Organization> _organizations = [
    Organization(
      id: 'd1',
      name: 'US Hotels',
      address: 'Jaffna',
      contactNo: '0762596548',
      imageUrl:
          'https://www.uplist.lk/wp-content/uploads/2019/06/US-Hotel-Jaffna.jpg',
      rating: 5,
    ),
    Organization(
      id: 'd2',
      name: 'Green Grass Wedding Hall',
      address: 'Jaffna',
      contactNo: '0762596548',
      imageUrl: 'https://pbs.twimg.com/media/Dvb7IB3XQAA0BGn.jpg',
      rating: 4,
    ),
    Organization(
      id: 'd3',
      name: 'Rolex',
      address: 'Jaffna',
      contactNo: '0762596548',
      imageUrl:
          'https://www.uplist.lk/wp-content/uploads/2019/06/US-Hotel-Jaffna.jpg',
      rating: 3,
    ),
  ];

  List<Organization> get organizations {
    return [..._organizations];
  }

  // begin receivers search screen

  String _searchString;

  List<Organization> get searchOrganizations {
    return _organizations
        .where((org) =>
            org.name.toLowerCase().contains(_searchString) ||
            org.name.contains(_searchString))
        .toList();
  }

  void addSearchString(String searchText) {
    _searchString = searchText;
    notifyListeners();
  }

  // end receivers search screen

  // begin organization home screen

  bool isOrganizationRegistered(String id) {
    return _organizations.any((org) => org.id == id);
  }  

  // end organization home screen

  addOrganization() {
    // add
    notifyListeners();
  }
}
