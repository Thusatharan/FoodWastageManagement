import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_wastage_management/providers/food_provider.dart';
import 'package:food_wastage_management/widgets/rating_stars_widget.dart';
import 'package:provider/provider.dart';

class ReceiverFoodDetailScreen extends StatefulWidget {
  static const routeName = '/receiver_food_detail_screen';

  @override
  _ReceiverFoodDetailScreenState createState() =>
      _ReceiverFoodDetailScreenState();
}

class _ReceiverFoodDetailScreenState extends State<ReceiverFoodDetailScreen> {
  //_buildMenuItem(Food menuItem) {
  //  return Center(
  //    child: Stack(
  //      alignment: Alignment.center,
  //      children: [
  //        Container(
  //          height: 175.0,
  //          width: 175.0,
  //          decoration: BoxDecoration(
  //            image: DecorationImage(
  //              image: AssetImage(menuItem.imageUrl),
  //              fit: BoxFit.cover,
  //            ),
  //            borderRadius: BorderRadius.circular(15.0),
  //          ),
  //        ),
  //        Container(
  //          height: 175.0,
  //          width: 175.0,
  //          decoration: BoxDecoration(
  //            borderRadius: BorderRadius.circular(15.0),
  //            gradient: LinearGradient(
  //              begin: Alignment.topRight,
  //              end: Alignment.bottomLeft,
  //              colors: [
  //                Colors.black.withOpacity(0.3),
  //                Colors.black87.withOpacity(0.3),
  //                Colors.black54.withOpacity(0.3),
  //                Colors.black38.withOpacity(0.3),
  //              ],
  //              stops: [0.1, 0.4, 0.6, 0.9],
  //            ),
  //          ),
  //        ),
  //        Column(
  //          mainAxisAlignment: MainAxisAlignment.center,
  //          children: [
  //            Text(
  //              'menuItem.name',
  //              style: TextStyle(
  //                color: Colors.white,
  //                fontSize: 24.0,
  //                fontWeight: FontWeight.bold,
  //                letterSpacing: 1.2,
  //              ),
  //            ),
  //            Text(
  //              'menuItem.price',
  //              style: TextStyle(
  //                color: Colors.white,
  //                fontSize: 18.0,
  //                fontWeight: FontWeight.bold,
  //                letterSpacing: 1.2,
  //              ),
  //            ),
  //          ],
  //        ),
  //        Positioned(
  //          bottom: 15.0,
  //          right: 10.0,
  //          child: Container(
  //            width: 48.0,
  //            decoration: BoxDecoration(
  //              color: Theme.of(context).primaryColor,
  //              borderRadius: BorderRadius.circular(30.0),
  //            ),
  //            child: IconButton(
  //              icon: Icon(Icons.add),
  //              iconSize: 30.0,
  //              color: Colors.white,
  //              onPressed: () {},
  //            ),
  //          ),
  //        ),
  //      ],
  //    ),
  //  );
  //}

  @override
  Widget build(BuildContext context) {
    final _foodId = ModalRoute.of(context).settings.arguments as String;
    final _food = Provider.of<Foods>(
      context,
      listen: false,
    ).findById(_foodId);
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: _food.id,
                child: Image(
                  height: 220.0,
                  width: MediaQuery.of(context).size.width,
                  image: NetworkImage(_food.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 60.0),
                child: IconButton(
                  icon: Icon(FontAwesomeIcons.arrowCircleLeft),
                  color: Theme.of(context).primaryColor,
                  iconSize: 30.0,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _food.name,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Available parcels: ' + _food.available,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.0),
                RatingStars(_food.organizationRating, 18.0),
                SizedBox(height: 6.0),
                Text(
                  _food.expireTime,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Reviews',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {},
              ),
              FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Request',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Center(
            child: Text(
              'Food Details',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          
        ],
      ),
    );
  }
}
