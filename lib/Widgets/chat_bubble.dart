import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    required this.isUser,
    required this.message,
  });
  final bool isUser;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: isUser ? Radius.circular(15) : Radius.circular(0),
                bottomRight: !isUser ? Radius.circular(15) : Radius.circular(0),
              ),
              color: isUser ? Color(0xff26AFDA) : Color(0xffa49d9d),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
