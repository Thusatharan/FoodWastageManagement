import 'package:flutter/material.dart';
import 'package:food_wastage_management/models/food.dart';

class OrganizationFoodWidget extends StatelessWidget {
  final Food food;
  const OrganizationFoodWidget(this.food);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
      child: Card(
        elevation: 5.0,
        child: ListTile(
          title: Text(food.name),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(food.imageUrl),
          ),
          trailing: Container(
            width: 100.0,
            child: Row(
              children: [
                Container(
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.blue,
                    onPressed: () {},
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () {
                      //  try {
                      //    Provider.of<Products>(context, listen: false)
                      //        .deleteProduct(widget.id);
                      //  } catch (error) {
                      //    Scaffold.of(context).showSnackBar(
                      //      SnackBar(
                      //        content: Text('Deleting failed!'),
                      //      ),
                      //    );
                      //  }
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
