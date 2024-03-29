import 'package:flutter/material.dart';
import 'package:food_wastage_management/providers/auth_provider.dart';
import 'package:food_wastage_management/screens/auth_screens/auth_screen.dart';
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatelessWidget {
  static const routeName = '/admin_home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text('Admin Screen'),
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
//Test
