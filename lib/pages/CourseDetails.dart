import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:graduation_project/Widgets/AppBar.dart';

import 'ChatScreen.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({
    required this.adId,
    Key? key,
  }) : super(key: key);

  final String adId;

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar('تفاصيل الإعلان'),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('ads')
              .doc(widget.adId)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        snapshot.data!.get('title'),
                        style: TextStyle(
                          color: Color(0xff48A9C5),
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (snapshot.data!.get('tutor')
                                        as Map)['firstname'],
                                    style: TextStyle(
                                      color: Color(0xffA0A0A0),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    'عضو مميز',
                                    style: TextStyle(
                                      color: Color(0xffFFD700),
                                      fontSize: 11,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            '${snapshot.data!.get('price')} دينار',
                            style: TextStyle(
                              color: Color(0xff48A9C5),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final userId = FirebaseAuth.instance.currentUser!.uid;
                          chatButtonEvent(
                            userAdId:
                                (snapshot.data!.get('tutor') as Map)['id'],
                            userId: userId,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 110,
                              height: 40,
                              color: Colors.grey,
                            ),
                            Row(
                              children: [
                                Text(
                                  'مراسلة',
                                  style: TextStyle(
                                    color: Color(0xff808080),
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.phone, color: Color(0xff48a9c5)),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('مهارات المرشد'),
                      Row(
                        children: ((snapshot.data!.get('tutor')
                                as Map)['skills'] as List)
                            .map(
                              (e) => Row(
                                children: [
                                  Container(
                                    height: 25,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                      color: Color(0xff48A9C5),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(e),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text('العنوان : '),
                          Text(snapshot.data!.get('location')),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(snapshot.data!.get('body')),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void chatButtonEvent({
    required String userAdId,
    required String userId,
  }) async {
    final database = FirebaseFirestore.instance.collection('messages');

    final result = await database
        .where('userId', isEqualTo: userId)
        .where('userAdId', isEqualTo: userAdId)
        .get();
    if (result.docs.isEmpty) {
      print('غير موجود');
      final doc = await database.add({
        'chat': [],
        'unseenMsgs': 0,
        'userAdId': userAdId,
        'userId': userId,
      });
      doc.update({
        'id': doc.id,
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            chatId: doc.id,
          ),
        ),
      );
    } else {
      print('موجود');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            chatId: result.docs.first.id,
          ),
        ),
      );
    }
  }
}
