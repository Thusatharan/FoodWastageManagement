import 'package:flutter/material.dart';
import 'package:food_wastage_management/providers/auth_provider.dart';
import 'package:food_wastage_management/screens/auth_screens/auth_screen.dart';
import 'package:provider/provider.dart';

class DonatorHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: RaisedButton(
          color: Colors.blue,
          child: Text('Logout'),
          onPressed: () {
            Provider.of<Authentication>(context, listen: false)
                .signOut()
                .then((_) {
              Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
            });
          },
        ),
      ),
    );
  }
}
