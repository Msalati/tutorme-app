import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryText extends StatelessWidget {
  double size;
  Color color;
  final String text;

  PrimaryText(
      {Key? key, this.size = 30, this.color = Colors.black, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: size ),
    );
  }
}
