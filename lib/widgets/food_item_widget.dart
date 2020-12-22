import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_wastage_management/screens/food_details.dart';

class FoodItem extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;
  final String available;
  final String donator;
  final double donatorRaing;

  FoodItem({
    @required this.id,
    @required this.name,
    @required this.available,
    @required this.donator,
    @required this.imageUrl,
    @required this.donatorRaing,
  });

  void selectFood(BuildContext context) {
    Navigator.of(context).pushNamed(FoodDetailSccreen.routename, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectFood(context);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 6,
        margin: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Available : $available Parcels',
                        style: TextStyle(color: Colors.black45),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        donator,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      RatingBarIndicator(
                        rating: donatorRaing,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 10.0,
                        direction: Axis.horizontal,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
