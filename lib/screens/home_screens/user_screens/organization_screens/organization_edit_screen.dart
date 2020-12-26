import 'package:flutter/material.dart';
import 'package:food_wastage_management/models/food.dart';
import 'package:food_wastage_management/providers/foods_provider.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/organization_screens/organization_home_screen.dart';
import 'package:food_wastage_management/widgets/progress_widget.dart';
import 'package:food_wastage_management/widgets/show_dialog_alert_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrganizationEditScreen extends StatefulWidget {
  static const routeName = '/organization_edit_screen';

  final Food food;
  OrganizationEditScreen({this.food});

  @override
  _OrganizationEditScreenState createState() => _OrganizationEditScreenState();
}

class _OrganizationEditScreenState extends State<OrganizationEditScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _foodCountController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final _editFormKey = GlobalKey<FormState>();
  //final _timestamp = DateTime.now();
  //DateTime _selectedDateTime;
  var _isUploading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.food.name;
    _foodCountController.text = widget.food.available;
    _timeController.text = widget.food.expireTime;
  }

  _submitEditedFoodPost(Food food) {
    final _isValid = _editFormKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_isValid) {
      setState(() {
        _isUploading = true;
      });

      Provider.of<Foods>(context, listen: false)
          .updateFood(
        foodId: food.id,
        organizationId: food.organizationId,
        newName: _nameController.text.trim(),
        newCount: _foodCountController.text.trim(),
        newExpireTime: _timeController.text.trim(),
      )
          .then((_) {
        setState(() {
          _isUploading = false;
        });

        _nameController.clear();
        _foodCountController.clear();
        _timeController.clear();

        Navigator.of(context).pushReplacementNamed(OrganizationHomeScreen.routeName);
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

  @override
  Widget build(BuildContext context) {
    final _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                          image: NetworkImage(widget.food.imageUrl),
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
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: _isPortrait ? 20.0 : 80.0, vertical: 50.0),
              child: Form(
                key: _editFormKey,
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
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
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
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
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
                              initialTime:
                                  TimeOfDay(hour: now.hour, minute: now.minute),
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
                                'UPDATE',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () =>
                                  _submitEditedFoodPost(widget.food),
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
