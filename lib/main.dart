import 'package:flutter/material.dart';
import 'package:food_wastage_management/screens/auth_screens/auth_screen.dart';
import 'package:food_wastage_management/screens/home_screen.dart';
import 'package:food_wastage_management/screens/intro_screen.dart';
import 'package:food_wastage_management/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Wastage Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[50],
        primaryColor: Colors.green,
      ),
      home: SplashScreen(),
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        IntroScreen.routeName: (ctx) => IntroScreen(),
        AuthScreen.routeName: (ctx) => AuthScreen(),
      },
    );
  }
}
