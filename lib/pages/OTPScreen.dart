import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  final String phone;

  const OTPScreen({Key? key, required this.phone}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

var verificationCode = '';

_authNumber(phone_number) async {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'ItsMsalati@gmail.com', password: 'o20rzbih')
      .then((value) async {
        debugPrint('user created');
      });

  /* FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+218${phone_number}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) async {
          if (value.user != null) {
            debugPrint('value user: ${value.user}');
            debugPrint('value: ${value}');
            debugPrint('user has been logged in successfully!');
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        debugPrint(e.message);
      },
      codeSent: (verificationId, forceResendingToken) {
        verificationCode = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        verificationCode = verificationId;
      },
      timeout: Duration(seconds: 60)); **/
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    _authNumber(widget.phone);
    return Scaffold(
      appBar: AppBar(
        title: Text('تحقق من رقم الهاتف'),
      ),
      body: Column(
        children: [
          Container(
            child: Center(child: Text('verify ${widget.phone}')),
          )
        ],
      ),
    );
  }
}
