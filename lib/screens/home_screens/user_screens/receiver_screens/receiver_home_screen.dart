import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_wastage_management/models/food.dart';
import 'package:food_wastage_management/providers/foods_provider.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/profile_screen.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/receiver_screens/food_detail_screen.dart';
import 'package:food_wastage_management/widgets/organization_widget.dart';
import 'package:food_wastage_management/widgets/rating_stars_widget.dart';
import 'package:provider/provider.dart';

class ReceiverHomeScreen extends StatefulWidget {
  static const routeName = '/receiver_home_screen';

  @override
  _ReceiverHomeScreenState createState() => _ReceiverHomeScreenState();
}

class _ReceiverHomeScreenState extends State<ReceiverHomeScreen> {
  User _currentUser = FirebaseAuth.instance.currentUser;
  var _currentIndex = 0;

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  _searchScreen(){}

  _buildFoods({foods}) {
    List<Widget> foodList = [];
    foods.forEach((Food food) {
      foodList.add(
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(FoodDetailScreen.routeName, arguments: food.id);
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
                  //Padding(
                  //  padding: const EdgeInsets.all(20.0),
                  //  child: TextField(
                  //    decoration: InputDecoration(
                  //      contentPadding: EdgeInsets.symmetric(
                  //        vertical: 15.0,
                  //      ),
                  //      fillColor: Colors.white,
                  //      filled: true,
                  //      border: OutlineInputBorder(
                  //        borderRadius: BorderRadius.circular(30.0),
                  //        borderSide: BorderSide(width: 0.8),
                  //      ),
                  //      enabledBorder: OutlineInputBorder(
                  //        borderRadius: BorderRadius.circular(30.0),
                  //        borderSide: BorderSide(
                  //          width: 0.8,
                  //          color: Theme.of(context).primaryColor,
                  //        ),
                  //      ),
                  //      hintText: 'Search Food or Restaurants',
                  //      prefixIcon: Icon(
                  //        Icons.search,
                  //        size: 30.0,
                  //      ),
                  //      suffixIcon: IconButton(
                  //        icon: Icon(Icons.clear),
                  //        onPressed: () {},
                  //      ),
                  //    ),
                  //  ),
                  //),
                  //SizedBox(
                  //  height: 100.0,
                  //),
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: const EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 20.0),
                    child: Text(
                      'Welcome',
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
              ? _searchScreen()
              : ProfileScreen(
                  user: _currentUser,
                ),
    );
  }
}
