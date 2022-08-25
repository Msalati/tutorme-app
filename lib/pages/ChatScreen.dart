import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("UserName"),
          backgroundColor: Color(0xff48A9C5),
          leading: Image.asset(
            'Images/user.png',
            width: 10,
            height: 10,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close_rounded))
          ],
        ),
        body: SafeArea(
            child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                    child: Expanded(
                        child: Container(
                  child: Text('Message'),
                ))),
                TextField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      hintText: 'ادخل النص هنا',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {},
                      )),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
