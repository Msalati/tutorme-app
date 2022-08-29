import 'package:flutter/material.dart';

class DoneResetPassword extends StatelessWidget {
  const DoneResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('Images/email-removebg-preview.png'),
            SizedBox(
              height: 10,
            ),
            Text(
              'لقد تم إرسال رسالة تعيين كلمة المرور بنجاح الرجاء التحقق من البريد الاكتروني الخاص بك.',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 250,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                color: Color(0xff48A9C5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text(
                  "انتهاء",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'Arial Hebrew',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
