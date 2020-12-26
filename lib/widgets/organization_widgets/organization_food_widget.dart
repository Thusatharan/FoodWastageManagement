import 'package:flutter/material.dart';
import 'package:food_wastage_management/models/food.dart';
import 'package:food_wastage_management/providers/foods_provider.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/organization_screens/organization_edit_screen.dart';
import 'package:food_wastage_management/widgets/progress_widget.dart';
import 'package:food_wastage_management/widgets/show_dialog_alert_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OrganizationFoodWidget extends StatefulWidget {
  final Food food;
  final String organizationId;
  final BuildContext context;
  const OrganizationFoodWidget({this.food, this.organizationId, this.context});

  @override
  _OrganizationFoodWidgetState createState() => _OrganizationFoodWidgetState();
}

class _OrganizationFoodWidgetState extends State<OrganizationFoodWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _foodCountController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final _editFormKey = GlobalKey<FormState>();
  final _timestamp = DateTime.now();
  DateTime _selectedDateTime;
  var _isUploading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.food.name;
    _foodCountController.text = widget.food.available;
    _timeController.text = widget.food.expireTime;
  }

  _submitEditedFoodPost(BuildContext context) {
    final _isValid = _editFormKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_isValid) {
      setState(() {
        _isUploading = true;
      });

      Provider.of<Foods>(context, listen: false)
          .updateFood(
        foodId: widget.food.id,
        organizationId: widget.food.organizationId,
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

        Navigator.pop(context);
      }).catchError((error) {
        setState(() {
          _isUploading = false;
        });

        // showDialogAlertWidget(
        //   context: context,
        //   error: error,
        //   title: 'Error Occured!',
        // );
      });
    }
  }

  var alertStyle = AlertStyle(
    isOverlayTapDismiss: false,
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    titleStyle: TextStyle(
      color: Colors.green,
      fontWeight: FontWeight.bold,
    ),
  );

  editFood(BuildContext context) {
    return Alert(
      context: context,
      style: alertStyle,
      title: 'Edit Food',
      image: Container(
        padding: EdgeInsets.only(top: 10.0),
        height: 150.0,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage(widget.food.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      content: Form(
        key: _editFormKey,
        child: Column(
          children: [
            SizedBox(height: 10.0),
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
                    size: 25.0,
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
                  hintText: 'parcel count',
                  prefixIcon: Icon(
                    Icons.format_list_numbered,
                    size: 25.0,
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
                  hintText: 'Expire date and time',
                  prefixIcon: Icon(
                    Icons.access_time,
                    size: 25.0,
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
                          DateFormat('dd/MM/yyyy hh:mm a').format(DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      ));
                    });
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please select the expire date and time';
                  } else if (_timestamp.isBefore(_selectedDateTime)) {
                    return 'Please enter valid expire date and time';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
      buttons: [
        _isUploading
            ? circularProgress()
            : DialogButton(
                onPressed: () => _submitEditedFoodPost(context),
                child: Text(
                  "UPDATE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Colors.green,
              )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
      child: Card(
        elevation: 5.0,
        child: ListTile(
          title: Text(widget.food.name),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.food.imageUrl),
          ),
          trailing: Container(
            width: 100.0,
            child: Row(
              children: [
                Container(
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => OrganizationEditScreen(food: widget.food)),
                      );
                    },
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () {
                      Provider.of<Foods>(context, listen: false)
                          .deleteFood(
                        organizationId: widget.organizationId,
                        foodId: widget.food.id,
                      )
                          .catchError((error) {
                        showDialogAlertWidget(
                          context: context,
                          error: error,
                          title: 'Error Occured!',
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
