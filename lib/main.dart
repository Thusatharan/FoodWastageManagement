import 'package:flutter/material.dart';
import 'package:food_wastage_management/providers/auth_provider.dart';
import 'package:food_wastage_management/screens/auth_screens/auth_screen.dart';
import 'package:food_wastage_management/screens/auth_screens/forgot_password_screen.dart';
import 'package:food_wastage_management/screens/auth_screens/google_auth_role_screen.dart';
import 'package:food_wastage_management/screens/home_screen.dart';
import 'package:food_wastage_management/screens/intro_screen.dart';
import 'package:food_wastage_management/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Authentication(),
        ),
      ],
      child: MaterialApp(
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
          ForgotPasswordScreen.routeName: (ctx) => ForgotPasswordScreen(),
          GoogleAuthRoleScreen.routeName: (ctx) => GoogleAuthRoleScreen(),
        },
      ),
    );
  }
}
