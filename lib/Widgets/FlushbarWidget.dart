import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Widget ErrorFlushbar(BuildContext context, String title, String message) {
  return Flushbar(
    title: title,
    message: message,
    icon: Icon(
      Icons.close,
      size: 28.0,
      color: Colors.red,
    ),
    margin: EdgeInsets.all(6.0),
    backgroundColor: Colors.black,
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    textDirection: Directionality.of(context),
    borderRadius: BorderRadius.circular(15),
    duration: Duration(milliseconds: 1900),
    leftBarIndicatorColor: Colors.red,
  )..show(context);
}

Widget SuccessFlushbar(BuildContext context, String title, String message) {
  return Flushbar(
    title: title,
    message: message,
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: Color(0xFF217D41),
    ),
    margin: EdgeInsets.all(6.0),
    backgroundColor: Colors.black,
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    textDirection: Directionality.of(context),
    borderRadius: BorderRadius.circular(15),
    duration: Duration(milliseconds: 1900),
    leftBarIndicatorColor: Color(0xFF217D41),
  )..show(context);
}
