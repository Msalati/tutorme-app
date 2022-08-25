import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:graduation_project/defaults.dart';

class SecondaryHeaderProfile extends StatefulWidget {
  String title;
  SecondaryHeaderProfile({Key? key, required String this.title})
      : super(key: key);

  @override
  State<SecondaryHeaderProfile> createState() => _SecondaryHeaderProfileState();
}

class _SecondaryHeaderProfileState extends State<SecondaryHeaderProfile> {
  @override
  Widget build(BuildContext contitle) {
    return Text(
      widget.title,
      style: TextStyle(color: Colors.black87,
       fontSize: 16),
    );
  }
}
