import 'package:flutter/material.dart';
import 'package:food_wastage_management/widgets/clipper_widgets/profile_clipper.dart';

class OrganizationRegisterScreen extends StatefulWidget {
  static const routeName = '/organization_register_screen';

  @override
  _OrganizationRegisterScreenState createState() =>
      _OrganizationRegisterScreenState();
}

class _OrganizationRegisterScreenState
    extends State<OrganizationRegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _registerNoController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _uploadImage() {}

  @override
  Widget build(BuildContext context) {
    final _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: SingleChildScrollView(
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
                    child: GestureDetector(
                      onTap: _uploadImage,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 65.0,
                        child: Center(
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.black54,
                            size: 55.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: _isPortrait ? 30.0 : 80.0, vertical: 30.0),
              child: Form(
                key: _formKey,
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
                        controller: _nameController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                          errorStyle: TextStyle(height: 0.1),
                          border: InputBorder.none,
                          hintText: 'Organization name',
                          prefixIcon: Icon(
                            Icons.location_city,
                            size: 30.0,
                          ),
                        ),
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
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
                        controller: _addressController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                          errorStyle: TextStyle(height: 0.1),
                          border: InputBorder.none,
                          hintText: 'Organization address',
                          prefixIcon: Icon(
                            Icons.map,
                            size: 30.0,
                          ),
                        ),
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your address';
                          } else if (value.trim().length < 4) {
                            return 'Address must be atleast 4 letters long';
                          }
                          return null;
                        },
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
                        controller: _registerNoController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                          errorStyle: TextStyle(height: 0.1),
                          border: InputBorder.none,
                          hintText: 'Organization register number',
                          prefixIcon: Icon(
                            Icons.confirmation_number,
                            size: 30.0,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your register number';
                          }
                          return null;
                        },
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
                        controller: _numberController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                          errorStyle: TextStyle(height: 0.1),
                          border: InputBorder.none,
                          hintText: 'Contact number',
                          prefixIcon: Icon(
                            Icons.phone,
                            size: 30.0,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your contact number';
                          } else if (value.trim().length < 11) {
                            return 'Contact number must be atleast 10 numbers long';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 40.0),
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
                          'SUBMIT',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          //  _submitForm(
                          //    userName: _nameController.text.trim(),
                          //    email: _emailController.text.trim(),
                          //    password:
                          //        _passwordController.text.trim(),
                          //    roleName: _dropdownValue,
                          //    context: context,
                          //  );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
