import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_wastage_management/models/user_model.dart';
import 'package:food_wastage_management/screens/home_screens/admin_screens/admin_home_screen.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/delivery_man_screens/delivery_man_home_screen.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/organization_screens/organization_home_screen.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/receiver_screens/receiver_home_screen.dart';
import 'package:food_wastage_management/widgets/progress_widget.dart';

final userRef = FirebaseFirestore.instance.collection('users');

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User _currentUser = FirebaseAuth.instance.currentUser;

  checkRole(DocumentSnapshot doc) {
    final userData = UserModel.fromDocument(doc);
    if (userData.roleName == 'Admin') {
      return AdminHomeScreen();
    } else if (userData.roleName == 'Organization') {
      return OrganizationHomeScreen();
    } else if (userData.roleName == 'Receiver') {
      return ReceiverHomeScreen();
    } else if (userData.roleName == 'Delivery man') {
      return DeliveryManHomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userRef.doc(_currentUser.uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: circularProgress(),
          );
        }
        return checkRole(snapshot.data);
      },
    );
  }
}
