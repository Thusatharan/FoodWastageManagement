import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_wastage_management/models/food.dart';
import 'package:food_wastage_management/models/organization.dart';
import 'package:food_wastage_management/providers/foods_provider.dart';
import 'package:food_wastage_management/providers/organization_provider.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/receiver_screens/receiver_food_detail_screen.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/receiver_screens/receiver_profile_screen.dart';
import 'package:food_wastage_management/widgets/rating_stars_widget.dart';
import 'package:food_wastage_management/widgets/receivers_widgets/organization_search_widget.dart';
import 'package:food_wastage_management/widgets/receivers_widgets/organization_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReceiverHomeScreen extends StatefulWidget {
  static const routeName = '/receiver_home_screen';

  @override
  _ReceiverHomeScreenState createState() => _ReceiverHomeScreenState();
}

class _ReceiverHomeScreenState extends State<ReceiverHomeScreen> {
  TextEditingController _searchOrganizationController = TextEditingController();
  User _currentUser = FirebaseAuth.instance.currentUser;
  var _currentIndex = 0;

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _searchOrganizationController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchOrganizationController.removeListener(_onSearchChanged);
    super.dispose();
  }

  _onSearchChanged() {
    Provider.of<Organizations>(
      context,
      listen: false,
    ).addSearchString(_searchOrganizationController.text.trim());
  }

  /* *************************************************************** */

  _emptySearchScreen(isPotrait) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: isPotrait ? 150.0 : 30.0),
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              Container(
                child: SvgPicture.asset(
                  'assets/images/search.svg',
                  height: isPotrait ? 200.0 : 180.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Text(
                  'Search Organization',
                  style: TextStyle(
                    fontSize: isPotrait ? 30.0 : 25.0,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }

  _buildOrganization({organizations}) {
    List<Widget> organizationList = [];
    organizations.forEach((Organization organization) {
      organizationList.add(
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 5.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: SearchOrganizationWidget(organization),
          ),
        ),
      );
    });
    return Column(
      children: organizationList,
    );
  }

  _searchScreen(_isPotrait) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding:
                EdgeInsets.fromLTRB(20.0, _isPotrait ? 80.0 : 50.0, 20.0, 20.0),
            child: TextField(
              controller: _searchOrganizationController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(width: 0.8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    width: 0.8,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                hintText: 'Search Organizations',
                prefixIcon: Icon(
                  Icons.search,
                  size: 30.0,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchOrganizationController.clear();
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<Organizations>(
                  builder: (context, data, child) =>
                      _searchOrganizationController.text.isEmpty
                          ? _emptySearchScreen(_isPotrait)
                          : Container(
                              child: _buildOrganization(
                                organizations: data.searchOrganizations,
                              ),
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /* *************************************************************** */

  _buildFoods({foods}) {
    List<Widget> foodList = [];
    foods.forEach((Food food) {
      foodList.add(
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ReceiverFoodDetailScreen.routeName,
              arguments: food.id,
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Hero(
                    tag: food.id,
                    child: Image(
                      height: 150.0,
                      width: 150.0,
                      image: NetworkImage(food.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.name,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          food.organizationName,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.0),
                        RatingStars(food.organizationRating, 18.0),
                        SizedBox(height: 4.0),
                        Text(
                          food.organizationLocation,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
    return Column(
      children: foodList,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _isPotrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final List<Food> foods = Provider.of<Foods>(
      context,
      listen: false,
    ).foods;
    return Scaffold(
      bottomNavigationBar: BubbleBottomBar(
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
              Icons.search,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.search,
              color: Colors.deepPurple,
            ),
            title: Text('Search'),
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
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.fromLTRB(
                        20.0, _isPotrait ? 80.0 : 50.0, 20.0, 20.0),
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
                  OrganizationsWidget(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                        child: Text(
                          'Recent Posts',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      _buildFoods(foods: foods),
                    ],
                  ),
                ],
              ),
            )
          : (_currentIndex == 1)
              ? _searchScreen(_isPotrait)
              : ReceiverProfileScreen(
                  user: _currentUser,
                ),
    );
  }
}
