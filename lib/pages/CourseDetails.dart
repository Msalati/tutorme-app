import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import 'package:graduation_project/Widgets/AppBar.dart';
import 'package:graduation_project/Widgets/flush_bar.dart';

import 'ChatScreen.dart';
import 'package:provider/provider.dart';

import '../providers/userStateProvider.dart';
import 'package:rating_dialog/rating_dialog.dart';

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
  String username = 'Loading';
  double value = 0;
  var reviews = [];

  late final _dialog = RatingDialog(
    initialRating: 1.0,
    // your app's name?
    title: Text(
      'تقييم الإعلان',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
    // encourage your user to leave a high rating?
    message: Text(
      'قم بالضغط على النجوم لوضع تقييمك الشخصي لهذا الإعلان',
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 15),
    ),
    // your app's logo?
    submitButtonText: 'تأكيد التقييم',
    enableComment: false,
    onCancelled: () => print('cancelled'),
    onSubmitted: (response) {
      postReview(
          widget.adId, FirebaseAuth.instance.currentUser!.uid, response.rating);

      // TODO: add your own logic
      if (response.rating < 3.0) {
        // send their comments to your email or anywhere you wish
        // ask the user to contact you instead of leaving a bad review

        // buildFlushbar(context,
        //         messageText: 'حدث خطأ',
        //         title: 'الرجاء المحاولة من جديد',
        //         successes: false)
        //     .show(context);
      }
    },
  );

  String usernameSetter(firstname, lastname) {
    username = '${firstname} ${lastname}';
    return '${firstname} ${lastname}';
  }

  double getAvgReviews(reviews) {
    // settings reviews array to use it in the update method
    this.reviews = reviews;
    // reviews array
    /**
     * Summation of review values / NUMBER OF REVIEWS (LENGTH )
    **/
    num sum = 0;
    if (reviews.isEmpty) return 0;
    for (var i = 0; i < reviews.length; i++) {
      sum += reviews[i]['rating'];
    }
    return (sum / reviews.length)
        .roundToDouble(); //to make sure not to break the rating widget
  }

  Future postReview(adId, userId, rating) async {
    //will update the firebase instance of that particulr COURSE ID with the new review posted with the USER ID
    try {
      int indexOfMatch =
          this.reviews.indexWhere((element) => element['userId'] == userId);

      if (indexOfMatch == -1) {
        this.reviews.add({'userId': userId, 'rating': rating});
        buildFlushbar(context,
                messageText: 'تم التقييم بنجاح',
                title: 'تمت العملية',
                successes: true)
            .show(context);
      } else {
        this.reviews[indexOfMatch]['rating'] = rating;
        buildFlushbar(context,
                messageText: 'تم تعديل تقييمك بنجاح',
                title: 'تمت العملية',
                successes: true)
            .show(context);
      }

      await FirebaseFirestore.instance
          .collection('ads')
          .doc(adId)
          .update({'reviews': this.reviews});
    } catch (e) {
      buildFlushbar(context, messageText: 'حدث خطأ أثناء عملية التقييم')
          .show(context);
    }
  }

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
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
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
                              Image.asset(
                                'Images/user.png',
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    usernameSetter(
                                        snapshot.data!.get('tutor.firstname'),
                                        snapshot.data!.get('tutor.lastname')),
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
                      if (context.watch<UserState>().type == 'client')
                        GestureDetector(
                          onTap: () async {
                            final userId =
                                FirebaseAuth.instance.currentUser!.uid;
                            chatButtonEvent(
                              userAdId:
                                  (snapshot.data!.get('tutor') as Map)['id'],
                              userId: userId,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
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
                              Icon(Icons.message, color: Color(0xff48a9c5))
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(children: [
                        Text(
                          'التقييمات:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          '(${snapshot.data!.get('reviews').length})',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ]),
                      Row(
                        children: [
                          RatingStars(
                            value: getAvgReviews(snapshot.data!.get('reviews')),
                            onValueChanged: (v) {
                              //
                              setState(() {
                                value = v;
                              });
                            },
                            starBuilder: (index, color) => Icon(
                              Icons.star_purple500_outlined,
                              color: color,
                            ),
                            starCount: 5,
                            starSize: 30,
                            valueLabelColor: const Color(0xff48A9C5),
                            valueLabelTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            valueLabelRadius: 10,
                            maxValue: 5,
                            starSpacing: 2,
                            maxValueVisibility: true,
                            valueLabelVisibility: true,
                            animationDuration: Duration(milliseconds: 1000),
                            valueLabelPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 8),
                            valueLabelMargin: const EdgeInsets.only(right: 8),
                            starOffColor: const Color(0xffe7e8ea),
                            starColor: Colors.yellow.shade600,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible:
                                    true, // set to false if you want to force a rating
                                builder: (context) => _dialog,
                              );
                            },
                            icon: Icon(Icons.star),
                            label: Text(
                              "تقييم",
                              style: TextStyle(
                                fontFamily: 'Cairo',
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.yellow.shade700,
                              textStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (snapshot.data!
                          .get('tutor.skills')
                          .toString()
                          .isNotEmpty)
                        Text(
                          'مهارات المرشد:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      if (snapshot.data!
                          .get('tutor.skills')
                          .toString()
                          .isNotEmpty)
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
                                      child: Text(
                                        e,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
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
                      Text(
                        'العنوان:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(snapshot.data!.get('location')),
                      SizedBox(
                        height: 20,
                      ),
                      Text('الوصف:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
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
            username: username,
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
            username: username,
          ),
        ),
      );
    }
  }
}
