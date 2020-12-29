import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

showDialogAlertWidget({BuildContext context, String title, error}) {
  var alertStyle = AlertStyle(
    isCloseButton: false,
    isOverlayTapDismiss: false,
    descTextAlign: TextAlign.center,
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    titleStyle: TextStyle(
      color: Colors.blue,
    ),
  );

  return Alert(
    context: context,
    style: alertStyle,
    type: AlertType.info,
    title: title,
    desc: error.toString(),
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0)
        ]),
      )
    ],
  ).show();

}
