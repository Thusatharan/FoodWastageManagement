import 'package:flutter/material.dart';
import 'package:food_wastage_management/providers/auth_provider.dart';
import 'package:food_wastage_management/providers/food_provider.dart';
import 'package:food_wastage_management/providers/organization_provider.dart';
import 'package:food_wastage_management/providers/receiver_provider.dart';
import 'package:food_wastage_management/providers/request_provider.dart';
import 'package:food_wastage_management/screens/auth_screens/auth_screen.dart';
import 'package:food_wastage_management/screens/auth_screens/forgot_password_screen.dart';
import 'package:food_wastage_management/screens/auth_screens/google_auth_role_screen.dart';
import 'package:food_wastage_management/screens/home_screen.dart';
import 'package:food_wastage_management/screens/home_screens/admin_screens/admin_home_screen.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/organization_screens/organization_edit_screen.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/organization_screens/organization_food_upload_screen.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/organization_screens/organization_home_screen.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/organization_screens/organization_register_screen.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/receiver_screens/receiver_food_detail_screen.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/receiver_screens/receiver_home_screen.dart';
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
        ChangeNotifierProvider.value(
          value: Organizations(),
        ),
        ChangeNotifierProvider.value(
          value: Foods(),
        ),
        ChangeNotifierProvider.value(
          value: Requests(),
        ),
        ChangeNotifierProvider.value(
          value: Receivers(),
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
          AdminHomeScreen.routeName: (ctx) => AdminHomeScreen(),
          OrganizationHomeScreen.routeName: (ctx) => OrganizationHomeScreen(),
          ReceiverHomeScreen.routeName: (ctx) => ReceiverHomeScreen(),
          ReceiverFoodDetailScreen.routeName: (ctx) => ReceiverFoodDetailScreen(),
          OrganizationRegisterScreen.routeName: (ctx) => OrganizationRegisterScreen(),
          OrganizationFoodUploadScreen.routeName: (ctx) => OrganizationFoodUploadScreen(),
          OrganizationEditScreen.routeName: (ctx) => OrganizationEditScreen(),
        },
      ),
    );
  }
}
