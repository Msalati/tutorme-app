import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

Flushbar buildFlushbar(
  BuildContext context, {
  required String messageText,
  String title = 'حدث خطأ ما',
  bool successes = false,
}) {
  final primaryColor = Theme.of(context).primaryColor;
  final textStyle = Theme.of(context).textTheme.bodyText2;
  return Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    titleText: Text(
      title,
      textDirection: TextDirection.rtl,
      style: textStyle!.copyWith(color: primaryColor),
    ),
    messageText: Text(
      messageText,
      textDirection: TextDirection.rtl,
      style: textStyle.copyWith(color: primaryColor),
    ),
    icon: successes
        ? Icon(Icons.check_circle, color: Colors.white)
        : Icon(Icons.info, color: Colors.white),
    duration: Duration(seconds: 2),
    backgroundColor: successes ? Color(0xff00ff02) : Color(0xff242037),
  );
}
