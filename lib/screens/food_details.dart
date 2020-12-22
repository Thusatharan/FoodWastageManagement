import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../dummy_data.dart';

class FoodDetailSccreen extends StatelessWidget {
  static const routename = '/food_detail';
  @override
  Widget build(BuildContext context) {
    final foodId = ModalRoute.of(context).settings.arguments as String;
    final selectedFood =
        DUMMY_FOODS.firstWhere((element) => element.id == foodId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedFood.name),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.37,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              child: Image.network(
                selectedFood.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      selectedFood.name,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Available ${selectedFood.available} Parcels',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${selectedFood.donator}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    RatingBarIndicator(
                      rating: selectedFood.donatorRating,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 10.0,
                      direction: Axis.horizontal,
                    ),
                    Text(
                      selectedFood.location,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(
            color: Colors.black,
            indent: 15,
            endIndent: 15,
            thickness: 1,
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Text(
              'Some Text Goes here Some Text Goes here Some Text Goes here Some Text Goes here Some Text Goes here',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  color: Colors.blue.shade400,
                  textColor: Colors.white,
                  autofocus: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  clipBehavior: Clip.hardEdge,
                  child: Row(
                    children: [
                      Icon(Icons.food_bank_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Get it Now',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  color: Colors.blue.shade400,
                  textColor: Colors.white,
                  autofocus: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  clipBehavior: Clip.hardEdge,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.call),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Contact Donator',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
