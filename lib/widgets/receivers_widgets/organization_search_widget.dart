import 'package:flutter/material.dart';
import 'package:food_wastage_management/models/organization.dart';
import 'package:food_wastage_management/widgets/rating_stars_widget.dart';

class SearchOrganizationWidget extends StatelessWidget {
  final Organization organization;
  SearchOrganizationWidget(this.organization);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(organization.imageUrl),
        ),
        title: Text(
          organization.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RatingStars(organization.rating, 14.0),
            SizedBox(height: 3.0),
            Text(
              organization.address,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        trailing: Container(
          width: 35.0,
          height: 35.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_forward),
            iconSize: 20.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
