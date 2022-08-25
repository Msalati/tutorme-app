import 'package:flutter/material.dart';

AppBar buildAppBar(String title) {
  return AppBar(
      backgroundColor: Color(0xff48A9C5),
      centerTitle: true,
      title: Text(
        '${title}',
        style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
      ));
}
