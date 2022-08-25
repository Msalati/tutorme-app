import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagePageComponent extends StatelessWidget {
  final VoidCallback callback;
  String text;
  String textColor, borderColor;
  double fontSize;

  MessagePageComponent({
    Key? key,
    required this.callback,
    this.fontSize = 18,
    required this.text,
    required this.borderColor,
    required this.textColor,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: () {

        },
        child: Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              child: Expanded(
                flex: 2,
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  backgroundImage: AssetImage('Images/user.png'),
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              flex: 8,
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مستخد نظام ',
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'رسالة مستخد نظام مستخد نظام مستخد نظام مستخد نظام مستخد نظام مستخد نظام مستخد نظام مستخد نظام ',
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
