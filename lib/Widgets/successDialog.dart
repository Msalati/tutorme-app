import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class successDialog extends StatefulWidget {
  String text;
  String content;
  String navigateTo;

  successDialog(
      {Key? key,
      required String this.text,
      required String this.content,
      required String this.navigateTo})
      : super(key: key);

  @override
  State<successDialog> createState() => _successDialogState();
}

class _successDialogState extends State<successDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.text,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
      ),
      content: Text(
        widget.content,
        textAlign: TextAlign.right,
      ),
      actions: [
        new MaterialButton(
          color: Colors.green[300],
          textColor: Colors.white,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, widget.navigateTo, (r) => false);
          },
          child: Text(
            'حسنًا',
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
