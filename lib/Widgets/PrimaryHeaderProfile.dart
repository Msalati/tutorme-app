import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:graduation_project/defaults.dart';

class PrimaryHeaderProfile extends StatefulWidget {
  String title;
  PrimaryHeaderProfile({Key? key, required String this.title})
      : super(key: key);

  @override
  State<PrimaryHeaderProfile> createState() => _PrimaryHeaderProfileState();
}

class _PrimaryHeaderProfileState extends State<PrimaryHeaderProfile> {
  @override
  Widget build(BuildContext contitle) {
    return Text(
      widget.title,
      style: TextStyle(color: Color(HexColor('#48A9C5')),
       fontSize: 20),
    );
  }
}
