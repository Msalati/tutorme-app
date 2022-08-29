import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Widgets/Post_Widget.dart';
import 'package:graduation_project/pages/CourseDetails.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({
    required this.text,
    Key? key,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff48A9C5),
          centerTitle: true,
          title: Text(
            'نتائج البحث',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('ads')
                    .where('title', isEqualTo: text)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Expanded(
                    child: ListView(
                      children: snapshot.data!.docs.map((document) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CourseDetails(
                                  adId: document.id,
                                ),
                              ),
                            );
                          },
                          title: Center(
                            child: Container(
                                child: Column(children: [
                              SizedBox(
                                height: 20,
                              ),
                              PostWidget(
                                  tags: [document['category']['title']],
                                  titleText: document['title'],
                                  timeOfCourse:
                                      DateTime.utc(1989, DateTime.november, 9),
                                  postText: document['body'],
                                  userImage: 'https://picsum.photos/400/250',
                                  userName: document['tutor']['firstname'] +
                                      " " +
                                      document['tutor']['lastname'],
                                  onPress: () {})
                            ])),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
