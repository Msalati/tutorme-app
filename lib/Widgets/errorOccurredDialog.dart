import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class errorOccurredDialog extends StatefulWidget {
  String text;
  String content;

  errorOccurredDialog(
      {Key? key, required String this.text, required String this.content})
      : super(key: key);

  @override
  State<errorOccurredDialog> createState() => _errorOccurredDialogState();
}

class _errorOccurredDialogState extends State<errorOccurredDialog> {
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
          onPressed: () => {Navigator.of(context).pop()},
          child: Text(
            'حسنًا',
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
