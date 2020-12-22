import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_wastage_management/models/user_model.dart';
import 'package:food_wastage_management/providers/auth_provider.dart';
import 'package:food_wastage_management/screens/auth_screens/auth_screen.dart';
import 'package:food_wastage_management/screens/home_screen.dart';
import 'package:food_wastage_management/widgets/clipper_widgets/profile_clipper.dart';
import 'package:food_wastage_management/widgets/progress_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final User user;
  ProfileScreen({this.user});

  @override
  Widget build(BuildContext context) {
    final _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: FutureBuilder(
        future: userRef.doc(user.uid).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return circularProgress();
          }
          final userData = UserModel.fromDocument(snapshot.data);
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipPath(
                      clipper: ProfileClipper(),
                      child: Container(
                        height: _isPortrait ? 300.0 : 200.0,
                        width: double.infinity,
                        color: Colors.green,
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                          border: Border.all(
                            width: 5.0,
                            color: Colors.blue,
                          ),
                        ),
                        child: ClipOval(
                          child: Image(
                            height: 120.0,
                            width: 120.0,
                            image: NetworkImage(userData.profileUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
                  child: Text(
                    userData.userName,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    userData.roleName,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('Logout'),
                    onPressed: () {
                      Provider.of<Authentication>(context, listen: false)
                          .signOut()
                          .then((_) {
                        Navigator.of(context)
                            .pushReplacementNamed(AuthScreen.routeName);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
