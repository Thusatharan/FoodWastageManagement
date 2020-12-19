import 'package:flutter/material.dart';
import 'package:food_wastage_management/widgets/clipper_widgets/auth_clip_widget.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth_screen';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  AuthClipWidget(),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 150.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 5.0,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 330.0),
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Form(
                      child: Column(
                        children: [
                          Container(
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
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 15.0),
                                border: InputBorder.none,
                                hintText: 'Username',
                                prefixIcon: Icon(
                                  Icons.person,
                                  size: 30.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
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
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 15.0),
                                border: InputBorder.none,
                                hintText: 'Email',
                                prefixIcon: Icon(
                                  Icons.mail,
                                  size: 30.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
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
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 15.0),
                                border: InputBorder.none,
                                hintText: 'Password',
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  size: 30.0,
                                ),
                              ),
                              obscureText: true,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
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
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 15.0),
                                border: InputBorder.none,
                                hintText: 'Re-type Password',
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  size: 30.0,
                                ),
                              ),
                              obscureText: true,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: FlatButton(
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            width: double.infinity,
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
                                'SIGN IN',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
