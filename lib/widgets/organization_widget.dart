import 'package:flutter/material.dart';
import 'package:food_wastage_management/models/organization.dart';
import 'package:food_wastage_management/providers/organization_provider.dart';
import 'package:food_wastage_management/widgets/rating_stars_widget.dart';
import 'package:provider/provider.dart';

class OrganizationsWidget extends StatelessWidget {
  _buildRecentOrder(BuildContext context, Organization organization) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        margin: EdgeInsets.all(10.0),
        width: 260.0,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image(
                      height: 100.0,
                      width: 100.0,
                      image: NetworkImage(organization.imageUrl),
                      fit: BoxFit.cover,
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
                            organization.name,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.0),
                          RatingStars(organization.rating, 14.0),
                          SizedBox(height: 4.0),
                          Text(
                            organization.location,
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
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Organization> _organizations = Provider.of<Organizations>(
      context,
      listen: false,
    ).organizations;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Organizations',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          height: 120.0,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: 10.0),
            scrollDirection: Axis.horizontal,
            itemCount: _organizations.length,
            itemBuilder: (BuildContext context, int index) {
              Organization _organization = _organizations[index];
              return _buildRecentOrder(context, _organization);
            },
          ),
        ),
      ],
    );
  }
}
