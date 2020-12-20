import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_wastage_management/providers/auth_provider.dart';
import 'package:food_wastage_management/screens/auth_screens/auth_screen.dart';
import 'package:food_wastage_management/screens/home_screen.dart';
import 'package:food_wastage_management/widgets/clipper_widgets/auth_clip_widget.dart';
import 'package:food_wastage_management/widgets/progress_widget.dart';
import 'package:provider/provider.dart';

class GoogleAuthRoleScreen extends StatefulWidget {
  static const routeName = '/google_auth_role_screen';

  @override
  _GoogleAuthRoleScreenState createState() => _GoogleAuthRoleScreenState();
}

class _GoogleAuthRoleScreenState extends State<GoogleAuthRoleScreen> {
  String _dropdownValue = 'Select Role';
  var _isLoading = false;

  _submitForm({
    String roleName,
    BuildContext context,
  }) {
    try {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Authentication>(context, listen: false)
          .googleSignIn(roleName: roleName)
          .then((user) {
        if (user != null) {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        } else {
          Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
        }
      });
    } on FirebaseAuthException catch (e) {
      var message = 'An error occured, Please check your credentials.';

      if (e.message != null) {
        message = e.message;
      }

      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _isportrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                AuthClipWidget(_isportrait),
                Positioned(
                  top: _isportrait ? 70.0 : 50.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: _isportrait ? 120.0 : 100.0),
                  child: Text(
                    'USER ROLE',
                    style: TextStyle(
                      fontSize: _isportrait ? 32.0 : 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: DropdownButtonFormField(
                value: _dropdownValue,
                icon: Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: Icon(Icons.expand_more),
                ),
                iconSize: 30.0,
                elevation: 16,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16.0,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.account_box),
                ),
                onChanged: (String newValue) {
                  setState(() {
                    _dropdownValue = newValue;
                  });
                },
                items: <String>[
                  'Select Role',
                  'Donator',
                  'Reciever',
                  'Delivery man',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Please Select your role name for this app',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blueGrey.shade400,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: _isportrait ? 180.0 : 50.0),
            _isLoading
                ? circularProgress()
                : Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                        horizontal: _isportrait ? 30.0 : 80.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        'GOOGLE SIGN IN',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        _submitForm(
                          roleName: _dropdownValue,
                          context: context,
                        );
                      },
                    ),
                  ),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
