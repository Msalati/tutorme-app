import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/defaults.dart';

class ButtonFill extends StatelessWidget {
  final VoidCallback callback;
  String text;
  String textColor, fillColor;
  double fontSize;

  ButtonFill({
    Key? key,
    required this.callback,
    this.fontSize = 18,
    required this.text,
    required this.fillColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            color: Color(HexColor(this.fillColor)),
            borderRadius: BorderRadius.circular(5)),
        child: MaterialButton(
            onPressed: () {
              callback();
            },
            child: Text("${this.text}",
                style: TextStyle(
                    fontSize: this.fontSize,
                    color: Color(HexColor(this.textColor)),))));
  }
}
