import 'package:flutter/material.dart';
import 'package:food_wastage_management/models/request.dart';

class OrganizationReceiverRequestWidget extends StatefulWidget {
  final Request request;
  OrganizationReceiverRequestWidget(this.request);

  @override
  _OrganizationReceiverRequestWidgetState createState() => _OrganizationReceiverRequestWidgetState();
}

class _OrganizationReceiverRequestWidgetState extends State<OrganizationReceiverRequestWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
      child: Card(
        elevation: 5.0,
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(widget.request.foodDetail.imageUrl),
          ),
          title: Text(
            widget.request.foodDetail.name,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(widget.request.timestamp),
          trailing: Icon(
            Icons.arrow_drop_down,
            size: 30.0,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Column(
                children: [
                  Divider(),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          'Request ID: ',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.request.id,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          'Receiver Name: ',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.request.receiverName,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          'Receiver Address: ',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.request.receiverAddress,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          'Receiver Contact No: ',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.request.receiverContactNo,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          'Transport: ',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: widget.request.deliveryManDetails == null
                            ? Text(
                                'Receiver didn\'t select any delivey man',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.green,
                                ),
                              )
                            : Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        child: Text(
                                          'Name: ',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            widget.request.deliveryManDetails
                                                .name,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                            ),
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Container(
                                        child: Text(
                                          'Contact No: ',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            widget.request.deliveryManDetails
                                                .contactNo,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                            ),
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          'Requested Quantity: ',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.request.requestedQuantity.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          height: 40.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color.fromRGBO(0, 179, 134, 1.0),
                          ),
                          child: FlatButton(
                            child: Text(
                              'Reject',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          height: 40.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(116, 116, 191, 1.0),
                              Color.fromRGBO(52, 138, 199, 1.0)
                            ]),
                          ),
                          child: FlatButton(
                            child: Text(
                              'Accept',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
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
