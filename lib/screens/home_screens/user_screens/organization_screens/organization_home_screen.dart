import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/organization_screens/organization_profile_screen.dart';

class OrganizationHomeScreen extends StatefulWidget {
  static const routeName = '/organization_home_screen';

  @override
  _OrganizationHomeScreenState createState() => _OrganizationHomeScreenState();
}

class _OrganizationHomeScreenState extends State<OrganizationHomeScreen> {
  User _currentUser = FirebaseAuth.instance.currentUser;
  var _currentIndex = 0;

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  homeScreen(_isPotrait){}
 
  requestScreen(){}

  /* ***************************************************************** */

  @override
  Widget build(BuildContext context) {
    final _isPotrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: true,
        fabLocation: BubbleBottomBarFabLocation.end,
        opacity: 0.2,
        currentIndex: _currentIndex,
        onTap: _changePage,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
        elevation: 10.0,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.dashboard,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.dashboard,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Home'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.deepPurple,
            icon: Icon(
              Icons.access_time,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.access_time,
              color: Colors.deepPurple,
            ),
            title: Text('Requests'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.person,
              color: Colors.blue,
            ),
            title: Text('Profile'),
          ),
        ],
      ),
      body: (_currentIndex == 0)
          ? homeScreen(_isPotrait)
          : (_currentIndex == 1)
              ? requestScreen()
              : OrganizationProfileScreen(
                  user: _currentUser,
                ),
    );
  }
}