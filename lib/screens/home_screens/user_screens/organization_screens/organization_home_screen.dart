import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_wastage_management/models/food.dart';
import 'package:food_wastage_management/providers/foods_provider.dart';
import 'package:food_wastage_management/providers/organization_provider.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/organization_screens/organization_profile_screen.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/organization_screens/organization_register_screen.dart';
import 'package:food_wastage_management/widgets/organization_widgets/organization_food_widget.dart';
import 'package:provider/provider.dart';

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
requestScreen() {}

  /* ***************************************************************** */

  _emptyFoodScreen(isPotrait) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: isPotrait ? 120.0 : 50.0),
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              Container(
                child: SvgPicture.asset(
                  'assets/images/no_posts.svg',
                  height: isPotrait ? 170.0 : 160.0,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                child: Text(
                  'No Posts',
                  style: TextStyle(
                    fontSize: isPotrait ? 30.0 : 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildOrganizationFoodScreen(foods) {
    List<Widget> _organizationFoodList = [];
    foods.forEach((Food food) {
      _organizationFoodList.add(
        OrganizationFoodWidget(food),
      );
    });
    return Column(
      children: _organizationFoodList,
    );
  }

  homeScreen(_isPotrait) {
    final foods = Provider.of<Foods>(
      context,
      listen: false,
    ).organizationFood('d1');
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            margin:
                EdgeInsets.fromLTRB(20.0, _isPotrait ? 80.0 : 50.0, 20.0, 20.0),
            child: Text(
              'Welcome back',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                child: Text(
                  'My Posts',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Container(
                child: Consumer<Foods>(
                  builder: (context, data, child) =>
                      data.isOrganizationRegistered('d1')
                          ? _buildOrganizationFoodScreen(foods)
                          : _emptyFoodScreen(_isPotrait),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /* ***************************************************************** */

  _buildCreatePostScreen(){}

  _buildAddFoodScreen(bool isOrganizationExist, BuildContext context) {
    if (isOrganizationExist) {
      return _buildCreatePostScreen();
    } else {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Alert!'),
            content: Text('Please register your organization to create Post'),
            actions: [
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(OrganizationRegisterScreen.routeName);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _isPotrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
        final _isOrganizationExist =
        Provider.of<Organizations>(context, listen: false)
            .isOrganizationRegistered('d4');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _buildAddFoodScreen(_isOrganizationExist, context),
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
