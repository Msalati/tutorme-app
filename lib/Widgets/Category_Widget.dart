import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  double iconSize;
  double textSize;
  final IconData icon;
  String startColor, endColor;
  final double  sizedBoxHeight;
  final String text;

  CategoryWidget(
      {Key? key,
      this.iconSize = 30,
      this.textSize = 25,
      required this.icon,
      required this.text,
      required this.startColor,
      required this.endColor,
      this.sizedBoxHeight = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(18),
        margin: EdgeInsets.only(bottom: this.sizedBoxHeight),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end:Alignment.bottomCenter

              // Alignment(
                 // 0.8, 0.0),
              //
              // 10% of the width, so there are ten blinds.
              ,
              colors: <Color>[
                Color(int.parse('0xff${this.startColor}')),
                Color(int.parse('0xff${this.endColor}'))
              ], // red to yellow
              tileMode:
                  TileMode.mirror, // repeats the gradient over the canvas
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Icon(this.icon, size: 30, color: Colors.white),
            SizedBox(width: 40),
            Text(this.text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: this.textSize,
                    color: Colors.white)),
          ],
        ));
  }
}
/*
Container
(
padding: const EdgeInsets.all(18
)
,
decoration:BoxDecoration
(
color: Colors.red ,borderRadius: BorderRadius.circular(10
)
)
,

child: Row
(
children: [
Icon
(
Icons.account_balance_outlined,size: 30
,
color: Colors.white,)
,
SizedBox
(
width: 20
)
,
Text
("تعليم اساسي
"
,
style: TextStyle
(
fontFamily: '
Tajwal',
fontWeight: FontWeight.bold,fontSize: 25
,
color: Colors.white))
,
]
,
)
,
)
,
*/
