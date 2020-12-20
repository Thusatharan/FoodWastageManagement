import 'package:flutter/material.dart';
import 'package:food_wastage_management/widgets/clipper_widgets/auth_clip_widget.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth_screen';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reTypePasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _isLogIn = true;
  var _isLoading = false;
  String dropdownValue = 'Select Role';

  @override
  Widget build(BuildContext context) {
    final _isportrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  AuthClipWidget(_isportrait),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 100.0),
                    child: Text(
                      _isLogIn ? 'SIGN IN' : 'SIGN UP',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: _isportrait ? 260.0 : 200.0),
                    padding: EdgeInsets.symmetric(
                        horizontal: _isportrait ? 30.0 : 80.0),
                    child: Form(
                      child: Column(
                        children: [
                          if (!_isLogIn)
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
                                controller: _nameController,
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
                          if (!_isLogIn)
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
                              child: DropdownButtonFormField(
                                value: dropdownValue,
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
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10.0),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.account_box),
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
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
                          SizedBox(height: _isLogIn ? 50.0 : 20.0),
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
                              controller: _emailController,
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
                              controller: _passwordController,
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
                          SizedBox(height: _isLogIn ? 5.0 : 20.0),
                          if (!_isLogIn)
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
                                controller: _reTypePasswordController,
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
                          if (!_isLogIn) SizedBox(height: 10.0),
                          if (_isLogIn)
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
                          SizedBox(
                              height: _isLogIn
                                  ? (_isportrait ? 100.0 : 40.0)
                                  : 30.0),
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
                                _isLogIn ? 'SIGN IN' : 'SIGN UP',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(height: 50.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              _isLogIn ? 'Don\'t have an account?' : 'Already have an account?',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            FlatButton(
              child: Text(
                _isLogIn ? 'SIGN UP' : 'SIGN IN',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                setState(() {
                  _isLogIn = !_isLogIn;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
