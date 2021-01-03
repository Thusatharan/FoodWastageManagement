import 'package:flutter/material.dart';
import 'package:food_wastage_management/models/receiver.dart';

class OrganizationSearchWidget extends StatelessWidget {
  final Receiver receiver;
  OrganizationSearchWidget(this.receiver);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        elevation: 5.0,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(receiver.receiverImageUrl),
          ),
          title: Text(
            receiver.receiverName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            receiver.receiverAddress,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Container(
            width: 35.0,
            height: 35.0,
            decoration: BoxDecoration(
              color: Colors.indigo,
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
      ),
    );
  }
}
