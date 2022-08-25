import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "حول",
        ),
      ),
      body: Directionality(
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
                    Text('تطبيق ارشدني لدعم الطلبة و اصحاب الدخل المحدود'),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('1.0'),Text("V")],
                    ),
                    Text("للتواصل مع الدعم الفني و فريق التطوير"),
                    SizedBox(height: 15,),
                    Text("arshidney.itSupport@Arshideny.com.ly"),
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
