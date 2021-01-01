import 'package:flutter/cupertino.dart';
import 'package:food_wastage_management/models/organization.dart';
import 'package:food_wastage_management/screens/home_screen.dart';
import 'package:intl/intl.dart';

class Organizations with ChangeNotifier {
  final _timestamp = DateTime.now();

  List<Organization> _organizations = [
    //Organization(
    //  id: 'd1',
    //  name: 'US Hotels',
    //  address: 'Jaffna',
    //  contactNo: '0762596548',
    //  imageUrl:
    //      'https://www.uplist.lk/wp-content/uploads/2019/06/US-Hotel-Jaffna.jpg',
    //  rating: 5,
    //),
    //Organization(
    //  id: 'd2',
    //  name: 'Green Grass Wedding Hall',
    //  address: 'Jaffna',
    //  contactNo: '0762596548',
    //  imageUrl: 'https://pbs.twimg.com/media/Dvb7IB3XQAA0BGn.jpg',
    //  rating: 4,
    //),
    //Organization(
    //  id: 'd3',
    //  name: 'Rolex',
    //  address: 'Jaffna',
    //  contactNo: '0762596548',
    //  imageUrl:
    //      'https://www.uplist.lk/wp-content/uploads/2019/06/US-Hotel-Jaffna.jpg',
    //  rating: 3,
    //),
  ];

  List<Organization> get organizations {
    return [..._organizations];
  }

  // begin fetch organization data from firestore

  Future<void> fetchAndSetOrganizations() async {
    try {
      final docsCollection = await organizationRef.get();
      final List<Organization> loadedOrganizations = [];
      docsCollection.docs.forEach((org) {
        loadedOrganizations.add(
          Organization(
            id: org['id'],
            name: org['name'],
            address: org['address'],
            registrationNo: org['registrationNo'],
            imageUrl: org['imageUrl'],
            contactNo: org['contactNo'],
          ),
        );
      });

      _organizations = loadedOrganizations;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  // end fetch organization data from firestore


  Organization findById(String id) {
    return _organizations.firstWhere((org) => org.id == id);
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

  Future<void> addOrganization({
    String id,
    String name,
    String address,
    String registrationNo,
    String imageUrl,
    String contactNo,
  }) {
    return organizationRef.doc(id).set({
      'id': id,
      'name': name,
      'address': address,
      'registrationNo': registrationNo,
      'imageUrl': imageUrl,
      'contactNo': contactNo,
      'rating': '',
      'createdAt': DateFormat('dd/MM/yyyy hh:mm a').format(_timestamp),
    }).then((_) {
      final newOrganization = Organization(
        id: id,
        name: name,
        address: address,
        registrationNo: registrationNo,
        imageUrl: imageUrl,
        contactNo: contactNo,
      );

      _organizations.add(newOrganization);
      notifyListeners();
    }).catchError((error) {
      throw error;
    });
  }
}
