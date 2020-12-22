import 'package:flutter/cupertino.dart';
import 'package:food_wastage_management/models/organization.dart';

class Organizations with ChangeNotifier {
  List<Organization> _organizations = [
    Organization(
      id: 'd1',
      name: 'US Hotels',
      location: 'Jaffna',
      mobile: '0762596548',
      imageUrl:
          'https://www.uplist.lk/wp-content/uploads/2019/06/US-Hotel-Jaffna.jpg',
      rating: 5,
    ),
    Organization(
      id: 'd2',
      name: 'Green Grass Wedding Hall',
      location: 'Jaffna',
      mobile: '0762596548',
      imageUrl: 'https://pbs.twimg.com/media/Dvb7IB3XQAA0BGn.jpg',
      rating: 4,
    ),
    Organization(
      id: 'd3',
      name: 'Rolex',
      location: 'Jaffna',
      mobile: '0762596548',
      imageUrl:
          'https://www.uplist.lk/wp-content/uploads/2019/06/US-Hotel-Jaffna.jpg',
      rating: 3,
    ),
  ];

  List<Organization> get organizations {
    return [..._organizations];
  }

  addOrganization() {
    // add
    notifyListeners();
  }
}
