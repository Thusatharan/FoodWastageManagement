import 'package:flutter/material.dart';
import 'package:food_wastage_management/providers/auth_provider.dart';
import 'package:food_wastage_management/widgets/clipper_widgets/auth_clip_widget.dart';
import 'package:food_wastage_management/widgets/progress_widget.dart';
import 'package:food_wastage_management/widgets/show_dialog_alert_widget.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot_password_screen';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _isLoading = false;

  _submitForm({
    String email,
    BuildContext context,
  }) {
    final _isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_isValid) {
      try {
        setState(() {
          _isLoading = true;
        });

        Provider.of<Authentication>(context, listen: false)
            .forgotPassword(email: email)
            .then((_) {
          _emailController.clear();

          SnackBar snackBar = SnackBar(
            content: Text(
              'A password reset link has been sent to ' + email,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.green,
          );

          _scaffoldKey.currentState.showSnackBar(snackBar);
        }).catchError((error) {
          setState(() {
            _isLoading = false;
          });

          _emailController.clear();

          showDialogAlertWidget(
            context: context,
            error: error,
            title: 'Error Occured!',
          );
        });
      } catch (error) {
        setState(() {
          _isLoading = false;
        });

        showDialogAlertWidget(
          context: context,
          error: error,
          title: 'Error Occured!',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _isportrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
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
                      'FORGOT PASSWORD',
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
                alignment: Alignment.center,
                padding:
                    EdgeInsets.symmetric(horizontal: _isportrait ? 30.0 : 80.0),
                child: Form(
                  key: _formKey,
                  child: Container(
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
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                        border: InputBorder.none,
                        hintText: 'Email',
                        prefixIcon: Icon(
                          Icons.mail,
                          size: 30.0,
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your email address';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Enter an email to recieve informations about your reset password.',
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
                          'SUBMIT',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          _submitForm(
                            email: _emailController.text.trim(),
                            context: context,
                          );
                        },
                      ),
                    ),
              SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
