import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_wastage_management/providers/organization_provider.dart';
import 'package:food_wastage_management/screens/home_screen.dart';
import 'package:food_wastage_management/widgets/clipper_widgets/profile_clipper.dart';
import 'package:food_wastage_management/widgets/progress_widget.dart';
import 'package:food_wastage_management/widgets/show_dialog_alert_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OrganizationRegisterScreen extends StatefulWidget {
  static const routeName = '/organization_register_screen';

  @override
  _OrganizationRegisterScreenState createState() =>
      _OrganizationRegisterScreenState();
}

class _OrganizationRegisterScreenState
    extends State<OrganizationRegisterScreen> {
  final _currentUser = FirebaseAuth.instance.currentUser;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _registerNoController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  File _image;
  bool _isUploading = false;

  /* ********************************************************* */

  _compressImage() async {
    final _tempDir = await getTemporaryDirectory();
    final _path = _tempDir.path;
    Im.Image imageFile = Im.decodeImage(_image.readAsBytesSync());
    final _compressedImageFile = File('$_path/img_${_currentUser.uid}.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));

    setState(() {
      _image = _compressedImageFile;
    });
  }

  Future<String> _uploadImage(image) async {
    UploadTask _uploadTask =
        storageRef.child('organizations/post_${_currentUser.uid}.jpg').putFile(_image);
    TaskSnapshot _storageSnap = await _uploadTask;
    String _downloadUrl = await _storageSnap.ref.getDownloadURL();
    return _downloadUrl;
  }

  _submitForm() async {
    final _isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_image == null) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'validation Error',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            content: Text('You must upload organization image'),
            actions: [
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    if (_isValid && _image != null) {
      setState(() {
        _isUploading = true;
      });

      await _compressImage();

      String _imageUrl = await _uploadImage(_image);

      Provider.of<Organizations>(context, listen: false)
          .addOrganization(
        id: _currentUser.uid,
        name: _nameController.text.trim(),
        address: _addressController.text.trim(),
        registrationNo: _registerNoController.text.trim(),
        imageUrl: _imageUrl,
        contactNo: _numberController.text.trim(),
      )
          .then((_) {
        setState(() {
          _image = null;
          _isUploading = false;
          _nameController.clear();
          _addressController.clear();
          _registerNoController.clear();
          _numberController.clear();
        });

        Navigator.pop(context);
      }).catchError((error) {
        setState(() {
          _image = null;
          _isUploading = false;
          _nameController.clear();
          _addressController.clear();
          _registerNoController.clear();
          _numberController.clear();
        });

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error Occured!'),
              content: Text(error.toString()),
              actions: [
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      });
    }
  }

  /* ********************************************************* */

  Future _getImage(ImageSource source) async {
    await _picker.getImage(source: source).then((pickedFile) {
      setState(() {
        _image = File(pickedFile.path);
      });
      Navigator.pop(context);
    }).catchError((error){
      showDialogAlertWidget(
        context: context,
        error: error,
        title: 'Error Message!',
      );
    });
  }

  _pickImage(BuildContext context) {
    var alertStyle = AlertStyle(
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descTextAlign: TextAlign.center,
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      titleStyle: TextStyle(
        color: Colors.indigo,
        fontWeight: FontWeight.bold,
      ),
    );

    return Alert(
      context: context,
      style: alertStyle,
      title: "Select Organization Image",
      content: Column(
        children: <Widget>[
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.camera_alt,
                color: Colors.black54,
              ),
              FlatButton(
                child: Text(
                  'Capture with camera',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                onPressed: () => _getImage(ImageSource.camera),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.folder,
                color: Colors.black54,
              ),
              FlatButton(
                child: Text(
                  'Select From Gallery',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                onPressed: () => _getImage(ImageSource.gallery),
              ),
            ],
          ),
          Divider(),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
    
    
    //showDialog(
    //  context: context,
    //  builder: (context) {
    //    return SimpleDialog(
    //      title: Text(
    //        'Organization Image',
    //        style: TextStyle(
    //          color: Theme.of(context).primaryColor,
    //          fontWeight: FontWeight.bold,
    //        ),
    //      ),
    //      children: [
    //        SimpleDialogOption(
    //          child: Text(
    //            'Capture with camera',
    //            style: TextStyle(
    //              color: Colors.black,
    //            ),
    //          ),
    //          onPressed: () => _getImage(ImageSource.camera),
    //        ),
    //        SimpleDialogOption(
    //          child: Text(
    //            'Select From Gallery',
    //            style: TextStyle(
    //              color: Colors.black,
    //            ),
    //          ),
    //          onPressed: () => _getImage(ImageSource.gallery),
    //        ),
    //        Divider(),
    //        SimpleDialogOption(
    //          child: Text(
    //            'Cancel',
    //            style: TextStyle(
    //              color: Colors.black,
    //            ),
    //          ),
    //          onPressed: () => Navigator.pop(context),
    //        ),
    //      ],
    //    );
    //  },
    //);
  }

  /* ********************************************************* */

  @override
  Widget build(BuildContext context) {
    final _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
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
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: _image == null
                                ? AssetImage(
                                    'assets/images/default_profile.png')
                                : FileImage(File(_image.path)),
                            radius: 65.0,
                          ),
                          Positioned(
                            bottom: 5.0,
                            right: 0.0,
                            child: GestureDetector(
                              onTap: () => _pickImage(context),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                                size: 40.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 70.0,
                    left: 5.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
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
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
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
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
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
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
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
                            } else if (value.trim().length != 10) {
                              return 'Contact number must be 10 numbers long';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 60.0),
                      _isUploading
                          ? circularProgress()
                          : Container(
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
                                onPressed: _submitForm,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
