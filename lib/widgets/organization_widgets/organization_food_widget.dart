import 'package:flutter/material.dart';
import 'package:food_wastage_management/models/food.dart';
import 'package:food_wastage_management/providers/foods_provider.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/organization_screens/organization_edit_screen.dart';
import 'package:food_wastage_management/widgets/show_dialog_alert_widget.dart';
import 'package:provider/provider.dart';

class OrganizationFoodWidget extends StatefulWidget {
  final Food food;
  const OrganizationFoodWidget({this.food});

  @override
  _OrganizationFoodWidgetState createState() => _OrganizationFoodWidgetState();
}

class _OrganizationFoodWidgetState extends State<OrganizationFoodWidget> {
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
                        MaterialPageRoute(
                            builder: (_) =>
                                OrganizationEditScreen(food: widget.food)),
                      );
                    },
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'Alert',
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                          content: Text('Are you sure?'),
                          actions: [
                            FlatButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            FlatButton(
                              child: Text('Yes'),
                              onPressed: () {
                                Provider.of<Foods>(context, listen: false)
                                    .deleteFood(
                                  organizationId: widget.food.organizationId,
                                  foodId: widget.food.id,
                                ).then((_){
                                  Navigator.pop(context);
                                })
                                    .catchError((error) {
                                  showDialogAlertWidget(
                                    context: context,
                                    error: error,
                                    title: 'Error Occured!',
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      );
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
