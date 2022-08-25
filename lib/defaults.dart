import 'package:flutter/material.dart';

class Defaults {
  //static final Color primaryColor = {};


  static final bottomNavigationText = [
    'الرئيسية',
    'الفئات',
    'الرسائل',
    'الحساب'
  ];
  static final bottomNavigationIcons = [
    Icons.home,
    Icons.category_rounded,
    Icons.message_rounded,
    Icons.person
  ];

}

int HexColor(String colorHexCode) {
  String newColor = '0xff' + colorHexCode;
  newColor = newColor.replaceAll("#", "");
  int finalColor = int.parse(newColor);
  return finalColor;
}