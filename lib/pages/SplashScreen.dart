import 'package:flutter/material.dart';
import 'package:graduation_project/defaults.dart';
import 'package:graduation_project/pages/RegisterPage.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/providers/userStateProvider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: Directionality(
            textDirection: TextDirection.rtl,

            //padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Container(
              height: 900,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  //Text("تسجيل الدخول"),
                  Image.asset(
                    'Images/appLogo.png',
                    width: 350,
                    height: 300,
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Text(
                    'تواصل مع معلمك الخاص في اي وقت',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(HexColor('#48A9C5')),
                    ),
                  ),
                  SizedBox(
                    height: 15,
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
                            Navigator.pushNamed(context, '/rules');
                          },
                          child: Text("شروط الاستخدام",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,)))),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: 250,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                          child: Text("متابعة",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(HexColor('#48A9C5')),)))),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
