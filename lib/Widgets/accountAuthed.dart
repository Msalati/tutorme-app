import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:graduation_project/Widgets/Post_Widget.dart';
import 'package:graduation_project/Widgets/Primary_Text.dart';
import 'package:graduation_project/Widgets/SecondaryHeaderProfile.dart';
import 'package:graduation_project/Widgets/errorOccurredDialog.dart';
import 'package:graduation_project/Widgets/flush_bar.dart';
import 'package:graduation_project/Widgets/primaryHeaderProfile.dart';
import 'package:graduation_project/Widgets/successDialog.dart';
import 'package:graduation_project/defaults.dart';
import 'package:graduation_project/pages/CourseDetails.dart';
import 'package:graduation_project/pages/updateCourse.dart';
import 'package:graduation_project/pages/update_account.dart';
import 'package:graduation_project/providers/userStateProvider.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:provider/provider.dart';

class accountAuthed extends StatefulWidget {
  const accountAuthed({
    required this.context,
    Key? key,
  }) : super(key: key);
  final BuildContext context;

  @override
  State<accountAuthed> createState() => _accountAuthedState();
}

bool signOut() {
  try {
    FirebaseAuth.instance.signOut().then((value) {});
    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future deleteCourse(id) async {
  FirebaseFirestore.instance.collection('ads').doc(id).delete();
}

Future _signOut() async {
  return await FirebaseAuth.instance.signOut();
}

class _accountAuthedState extends State<accountAuthed> {
  ValueNotifier<int> valueListen = ValueNotifier(0);
  ValueNotifier<int> courseListen = ValueNotifier(1);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ValueListenableBuilder(
        valueListenable: valueListen,
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      context.watch<UserState>().userImage,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateAccount(
                            context: context,
                            valueListen: valueListen,
                          ),
                        ),
                      );
                    },
                    child: Text('تعديل الحساب'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    thickness: 1,
                    color: Color(HexColor('#48A9C5')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      child: Row(children: [
                        Icon(
                          Icons.person,
                          color: Color(HexColor('#48A9C5')),
                        ),
                        PrimaryHeaderProfile(title: "إسم المستخدم")
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SecondaryHeaderProfile(
                              title:
                                  '${context.watch<UserState>().userEntity['firstname']} ${context.watch<UserState>().userEntity['lastname']}'),
                        )
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      child: Row(children: [
                        Icon(
                          Icons.email,
                          color: Color(HexColor('#48A9C5')),
                        ),
                        PrimaryHeaderProfile(title: "البريد الإلكتروني")
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SecondaryHeaderProfile(
                              title: context
                                  .watch<UserState>()
                                  .userEntity['email']),
                        )
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      child: Row(children: [
                        Icon(
                          Icons.location_city,
                          color: Color(HexColor('#48A9C5')),
                        ),
                        PrimaryHeaderProfile(title: "العنوان")
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SecondaryHeaderProfile(
                              title: context
                                  .watch<UserState>()
                                  .userEntity['address']),
                        )
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      child: Row(children: [
                        Icon(
                          Icons.assignment_ind,
                          color: Color(HexColor('#48A9C5')),
                        ),
                        PrimaryHeaderProfile(title: "نوع الحساب")
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SecondaryHeaderProfile(
                              title: accountDeterminer(
                                  context.watch<UserState>().type)),
                        )
                      ]),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_signOut().toString().isNotEmpty == true) {
                        // clear the state if firebase works
                        context.read<UserState>().clearAuth();
                        Navigator.pushNamed(context, '/login');
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return errorOccurredDialog(
                                  text: 'حدث خطأ في تسجيل الخروج',
                                  content: 'يرجى المحاولة مرة أخرى...');
                            });
                      }
                    },
                    child: Text('تسجيل الخروج'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[400], // Background color
                      onPrimary: Colors.white, // Text Color (Foreground color)
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PrimaryText(text: 'إعلاناتي'),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('ads')
                            .where(
                              FieldPath.fromString('tutor.id'),
                              isEqualTo: context.watch<UserState>().userUID,
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
                            physics:
                                const NeverScrollableScrollPhysics(), //to stop the default behavior of scrolling within the widget itself
                            shrinkWrap: true,
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
                                        timeOfCourse: DateTime.utc(
                                            1989, DateTime.november, 9),
                                        postText: document['body'],
                                        userImage:
                                            'https://picsum.photos/400/250',
                                        userName: document['tutor']
                                                ['firstname'] +
                                            " " +
                                            document['tutor']['lastname'],
                                        onPress: () {}),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton.icon(
                                          icon: Icon(Icons.edit),
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xff48A9C5),
                                          ),
                                          onPressed: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateCourse(
                                                  context: context,
                                                  valueListen: courseListen,
                                                ),
                                              ),
                                            );
                                          },
                                          label: Text(
                                            'تعديل',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        ElevatedButton.icon(
                                          icon: Icon(Icons.delete),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.redAccent,
                                          ),
                                          onPressed: () async {
                                            if (await confirm(context)) {
                                              deleteCourse(document.id)
                                                  .then(((value) {
                                                buildFlushbar(context,
                                                        messageText:
                                                            'تم الحذف بنجاح',
                                                        title: 'تمت العملية',
                                                        successes: true)
                                                    .show(context);
                                              })).catchError((e) {
                                                buildFlushbar(context,
                                                        messageText: 'حدث خطأ',
                                                        title:
                                                            'حدث خلل ما و لم تتم العملية',
                                                        successes: false)
                                                    .show(context);
                                              });
                                            } else {
                                              buildFlushbar(context,
                                                      messageText: 'تم الإلغاء',
                                                      title:
                                                          'لم تتم عملية الحذف',
                                                      successes: false)
                                                  .show(context);
                                            }
                                          },
                                          label: Text(
                                            'حذف',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    )
                                  ])),
                                ),
                              );
                            }).toList(),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

String accountDeterminer(type) {
  return (type == 'tutor') ? 'مرشد' : 'طالب';
}
