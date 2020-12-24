import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_wastage_management/models/user_model.dart';
import 'package:food_wastage_management/providers/auth_provider.dart';
import 'package:food_wastage_management/screens/auth_screens/auth_screen.dart';
import 'package:food_wastage_management/screens/home_screen.dart';
import 'package:food_wastage_management/widgets/progress_widget.dart';
import 'package:food_wastage_management/widgets/receivers_widgets/receiver_profile_widget.dart';
import 'package:provider/provider.dart';

class ReceiverProfileScreen extends StatelessWidget {
  final User user;
  ReceiverProfileScreen({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.logout),
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
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: userRef.doc(user.uid).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return circularProgress();
          }
          final userData = UserModel.fromDocument(snapshot.data);
          return SingleChildScrollView(
            child: ReceiverProfileWidget(
              id: userData.id,
              name: userData.userName,
              email: userData.email,
              image: userData.profileUrl,
            ),
          );
        },
      ),
    );
  }
}
