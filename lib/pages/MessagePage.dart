import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/pages/ChatScreen.dart';
import 'package:graduation_project/pages/report_chat_page.dart';
import 'package:provider/provider.dart';

import '../providers/userStateProvider.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

String usernameSetter(firstname, lastname) {
  return '${firstname} ${lastname}';
}

//this is a helper function which check
// the type of user to get the correct name for the person who sent the message
String determiner(doc, type) {
  return doc[type];
}

Future getUsername(id) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(id)
      .get()
      .then(((snapshot) {
    return usernameSetter(
        snapshot.data()!['firstname'], snapshot.data()!['lastname']);
  }));
}

class _MessagesPageState extends State<MessagesPage> {
  // String username = 'Loading';

  String usernameSetter(firstname, lastname) {
    return '${firstname} ${lastname}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff48A9C5),
        centerTitle: true,
        title: Text(
          'الرسائل',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              sendReport();
            },
            icon: Icon(Icons.report),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('messages')
                .where(
                    context.watch<UserState>().type != 'tutor'
                        ? 'userId'
                        : 'userAdId',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  children: snapshot.data!.docs
                      .map((e) => Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                                chatId: e.id,
                                                username: 'جار التحميل...',
                                              )),

                                              /**
                                               * improvised solution:
                                               * getUsername(determiner(
                                                    e,
                                                    context
                                                                .watch<
                                                                    UserState>()
                                                                .type ==
                                                            'tutor'
                                                        ? 'userId'
                                                        : 'userAdId'))
                                                        
                                                        
                                               */
                                    );
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
                                            backgroundImage:
                                                AssetImage('Images/user.png'),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        flex: 8,
                                        child: Container(
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // e.id
                                              StreamBuilder<
                                                  DocumentSnapshot<
                                                      Map<String, dynamic>>>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('users')
                                                    .doc(determiner(
                                                        e,
                                                        context
                                                                    .watch<
                                                                        UserState>()
                                                                    .type ==
                                                                'tutor'
                                                            ? 'userId'
                                                            : 'userAdId'))
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  if (!snapshot.hasData) {
                                                    return LinearProgressIndicator();
                                                  }
                                                  var user = snapshot.data;
                                                  return Text(
                                                    usernameSetter(
                                                        user!['firstname'],
                                                        user['lastname']),
                                                    textAlign: TextAlign.right,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: false,
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                (e.get('chat') as List)
                                                        .isNotEmpty
                                                    ? (e.get('chat') as List)
                                                        .last['message']
                                                    : '',
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
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ))
                      .toList(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void sendReport() async {
    final database = FirebaseFirestore.instance.collection('reports');
    final result = await database
        .where(
          'userId',
          isEqualTo: FirebaseAuth.instance.currentUser!.uid,
        )
        .get();
    if (result.docs.isEmpty) {
      final doc = await database.add({
        'chat': [],
        'unseenMsgs': 0,
        'userId': FirebaseAuth.instance.currentUser!.uid,
      });
      doc.update({
        'id': doc.id,
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReportChatPage(
            chatId: doc.id,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReportChatPage(
            chatId: result.docs.first.id,
          ),
        ),
      );
    }
  }
}
