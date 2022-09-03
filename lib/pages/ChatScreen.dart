import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    required this.chatId,
    required this.username,
    Key? key,
  }) : super(key: key);

  final String chatId;
  final String username;

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
          title: Text(widget.username),
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
                Expanded(
                  child: SingleChildScrollView(
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('messages')
                          .doc(widget.chatId)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Column(
                            children: (snapshot.data!.get('chat') as List)
                                .map(
                                  (e) => ChatBubble(
                                    isUser: e['senderId'] ==
                                        FirebaseAuth.instance.currentUser!.uid,
                                    message: e['message'],
                                  ),
                                )
                                .toList(),
                          );
                        }
                      },
                    ),
                  ),
                ),
                TextField(
                  controller: messageController,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      hintText: 'ادخل النص هنا',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () async {
                          sendMessage();
                        },
                      )),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(widget.chatId)
          .update({
        'chat': FieldValue.arrayUnion([
          {
            'message': messageController.text,
            'senderId': FirebaseAuth.instance.currentUser!.uid,
            'time': DateTime.now(),
          }
        ])
      });
      messageController.text = '';
    }
  }
}
