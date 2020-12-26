import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_wastage_management/providers/foods_provider.dart';
import 'package:food_wastage_management/screens/home_screen.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/organization_screens/organization_home_screen.dart';
import 'package:food_wastage_management/widgets/progress_widget.dart';
import 'package:food_wastage_management/widgets/show_dialog_alert_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;

class OrganizationFoodUploadScreen extends StatefulWidget {
  static const routeName = '/organization_food_upload_screen';

  @override
  _OrganizationFoodUploadScreenState createState() =>
      _OrganizationFoodUploadScreenState();
}

class _OrganizationFoodUploadScreenState
    extends State<OrganizationFoodUploadScreen> {
  final _currentUser = FirebaseAuth.instance.currentUser;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _foodCountController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //final _timestamp = DateTime.now();
  //DateTime _selectedDateTime;
  String _postId = Uuid().v4();
  File _image;
  var _isUploading = false;

  /* ******************************************************************* */

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(_image.readAsBytesSync());
    final compressedImageFile = File('$path/img_$_postId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    setState(() {
      _image = compressedImageFile;
    });
  }

  Future<String> uploadImage(image) async {
    UploadTask uploadTask =
        storageRef.child('foods/post_$_postId.jpg').putFile(image);
    TaskSnapshot storageSnap = await uploadTask;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  _submitFoodPost() async {
    final _isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_isValid) {
      setState(() {
        _isUploading = true;
      });

      await compressImage();

      String _imageUrl = await uploadImage(_image);

      Provider.of<Foods>(context, listen: false)
          .addFood(
        id: _postId,
        name: _nameController.text.trim(),
        available: _foodCountController.text.trim(),
        expireTime: _timeController.text.trim(),
        imageUrl: _imageUrl,
        organizationId: _currentUser.uid,
      )
          .then((_) {
        _nameController.clear();
        _foodCountController.clear();
        _timeController.clear();

        setState(() {
          _image = null;
          _isUploading = false;
          _postId = Uuid().v4();
        });

        Navigator.of(context)
            .pushReplacementNamed(OrganizationHomeScreen.routeName);
      }).catchError((error) {
        setState(() {
          _isUploading = false;
        });

        showDialogAlertWidget(
          context: context,
          error: error,
          title: 'Error Occured!',
        );
      });
    }
  }

  /* ******************************************************************* */

  @override
  Widget build(BuildContext context) {
    final _pickedFile = ModalRoute.of(context).settings.arguments as PickedFile;
    setState(() {
      _image = File(_pickedFile.path);
    });
    final _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 0.0),
                    height: 250.0,
                    width: double.infinity,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(_image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 5.0,
                    top: 60.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _image = null;
                        });

                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: _isPortrait ? 20.0 : 80.0, vertical: 50.0),
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
                            hintText: 'Food name',
                            prefixIcon: Icon(
                              Icons.food_bank,
                              size: 30.0,
                            ),
                          ),
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter the food name';
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
                          controller: _foodCountController,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            errorStyle: TextStyle(height: 0.1),
                            border: InputBorder.none,
                            hintText: 'Available food parcel count',
                            prefixIcon: Icon(
                              Icons.format_list_numbered,
                              size: 30.0,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter food parcel count';
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
                          controller: _timeController,
                          showCursor: true,
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            errorStyle: TextStyle(height: 0.1),
                            border: InputBorder.none,
                            hintText: 'Food expire date and time',
                            prefixIcon: Icon(
                              Icons.access_time,
                              size: 30.0,
                            ),
                          ),
                          onTap: () async {
                            final now = DateTime.now();

                            showDatePicker(
                              context: context,
                              initialDate: now.add(
                                Duration(seconds: 1),
                              ),
                              firstDate: now,
                              lastDate: DateTime(2100),
                            ).then((selectedDate) {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                    hour: now.hour, minute: now.minute),
                              ).then((selectedTime) {
                                _timeController.text =
                                    DateFormat('dd/MM/yyyy hh:mm a')
                                        .format(DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  selectedTime.hour,
                                  selectedTime.minute,
                                ));

                                //setState(() {
                                //  _selectedDateTime = DateTime(
                                //    selectedDate.year,
                                //    selectedDate.month,
                                //    selectedDate.day,
                                //    selectedTime.hour,
                                //    selectedTime.minute,
                                //  );
                                //});
                              });
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please select the expire date and time';
                            } 
                            //else if (_timestamp.isBefore(_selectedDateTime)) {
                            //  return 'Please enter valid expire date and time';
                            //}
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 100.0),
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
                                  'POST',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: _submitFoodPost,
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
