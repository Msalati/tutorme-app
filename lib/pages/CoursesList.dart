import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:graduation_project/Widgets/AppBar.dart';
import 'package:graduation_project/Widgets/Post_Widget.dart';
import 'package:graduation_project/pages/CourseDetails.dart';

class CourseList extends StatefulWidget {
  const CourseList({
    required this.categoryId,
    Key? key,
  }) : super(key: key);
  final String categoryId;

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar('الدورات'),
        body: Container(
          margin: const EdgeInsets.only(top: 10),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('ads')
                  .where(
                    FieldPath.fromString('category.id'),
                    isEqualTo: widget.categoryId,
                  )
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
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
                );
              }),
        ),
      ),
    );
  }
}
