import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:graduation_project/Widgets/SecondaryHeaderProfile.dart';
import 'package:graduation_project/Widgets/errorOccurredDialog.dart';
import 'package:graduation_project/Widgets/primaryHeaderProfile.dart';
import 'package:graduation_project/Widgets/successDialog.dart';
import 'package:graduation_project/defaults.dart';
import 'package:graduation_project/providers/userStateProvider.dart';
import 'package:provider/provider.dart';

class accountAuthed extends StatefulWidget {
  const accountAuthed({Key? key}) : super(key: key);

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

Future _signOut() async {
  return await FirebaseAuth.instance.signOut();
}

class _accountAuthedState extends State<accountAuthed> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
              color: Color(HexColor('#48A9C5')),
            ),
            SizedBox(
              height: 20,
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
                        title: context.watch<UserState>().userFullName),
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
                        title: context.watch<UserState>().userEntity['email']),
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
                        title: context.watch<UserState>().userEntity['address']),
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
                        title:
                            accountDeterminer(context.watch<UserState>().type)),
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
          ],
        )),
      ),
    );
  }
}

String accountDeterminer(type) {
  return (type == 'tutor') ? 'مرشد' : 'طالب';
}
