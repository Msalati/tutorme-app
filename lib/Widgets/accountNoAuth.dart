import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:graduation_project/defaults.dart';
import 'package:graduation_project/pages/SplashScreen.dart';
import 'package:graduation_project/pages/loginScreen.dart';

class accountNoAuth extends StatefulWidget {
  const accountNoAuth({Key? key}) : super(key: key);

  @override
  State<accountNoAuth> createState() => _accountNoAuthState();
}

class _accountNoAuthState extends State<accountNoAuth> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    //Text("تسجيل الدخول"),
                    Image.asset(
                      'Images/appLogo.png',
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    Container(
                        width: 250,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(HexColor('#48A9C5'))),
                            borderRadius: BorderRadius.circular(5)),
                        child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text("تسجيل الدخول",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(HexColor('#48A9C5')),)))),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: 250,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            color: Color(HexColor('#48A9C5')),
                            borderRadius: BorderRadius.circular(5)),
                        child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SplashScreen()));
                            },
                            child: Text("إنشاء الحساب",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,)))),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
