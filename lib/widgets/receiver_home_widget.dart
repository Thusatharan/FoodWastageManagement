import 'package:flutter/material.dart';
import './donator_item_widget.dart';
import './food_item_widget.dart';
import '../dummy_data.dart';

class ReceiverHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final foodsList = DUMMY_FOODS.where((food) {
      return food.id.isNotEmpty;
    }).toList();

    final donatorList = DUMMY_DONATORS.where((donator) {
      return donator.id.isNotEmpty;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx1, donator) {
                  return DonatorItem(
                      id: donatorList[donator].id,
                      name: donatorList[donator].name,
                      location: donatorList[donator].location,
                      mobile: donatorList[donator].mobile,
                      image: donatorList[donator].url);
                },
                itemCount: donatorList.length,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                'AVAILABALE RIGHT NOW',
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return FoodItem(
                    id: foodsList[index].id,
                    name: foodsList[index].name,
                    imageUrl: foodsList[index].image,
                    available: foodsList[index].available,
                    donator: foodsList[index].donator,
                    donatorRaing: foodsList[index].donatorRating,
                  );
                },
                itemCount: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
