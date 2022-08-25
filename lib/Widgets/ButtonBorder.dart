import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/defaults.dart';

class ButtonBorder extends StatelessWidget {
  final VoidCallback onPress;
  String text;
  String textColor,
      borderColor; // put the colors in hexa code without # example TextColor:"ffffffff" and thats it , HexaColor function will handle the rest
  double fontSize;
double buttonRadius ;
  ButtonBorder({
    Key? key,
    this.buttonRadius = 0,
    required this.onPress,
    this.fontSize = 18,
    required this.text,
    required this.borderColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(HexColor(this.borderColor)),
          ),
          borderRadius: BorderRadius.circular(this.buttonRadius),
        ),
        child: MaterialButton(
            onPressed: () {
              onPress();
            },
            child: Text("${this.text}",
                style: TextStyle(
                    fontSize: this.fontSize,
                    color: Color(HexColor(this.textColor)),))));
  }
}
