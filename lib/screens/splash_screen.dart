import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_wastage_management/screens/home_screen.dart';
import 'package:food_wastage_management/screens/intro_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      if (_user != null) {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(IntroScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              'animations/splash_screen.json',
              height: 150.0,
              width: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10.0),
          RichText(
            text: TextSpan(
              text: 'Food',
              style: GoogleFonts.berkshireSwash(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                letterSpacing: 1.5,
              ),
              children: [
                TextSpan(
                  text: 'Cycle',
                  style: GoogleFonts.berkshireSwash(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
