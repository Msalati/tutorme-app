import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Widgets/AppBar.dart';
import 'package:graduation_project/main.dart';

import 'Recover_Account_Code.dart';

class PassChangeScreen extends StatefulWidget {
  @override
  State<PassChangeScreen> createState() => _PassChangeScreenState();
}

class _PassChangeScreenState extends State<PassChangeScreen> {
  bool _isObscure2 = false;
  bool _isObscure = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar('إسترداد الحساب'),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      'تغيير كلمة المرور',
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      obscureText: _isObscure,
                      decoration: InputDecoration(filled: true,
                          fillColor: Colors.grey[100],
                          border: InputBorder.none,
                          hintText: ' كلمة المرور الجديدة',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                              icon: Icon(Icons.remove_red_eye))),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      obscureText: _isObscure2,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: InputBorder.none,
                          hintText: 'تأكيد كلمة المرور',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObscure2 = !_isObscure2;
                                });
                              },
                              icon: Icon(Icons.remove_red_eye))),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                        width: 250,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            color: Color(0xff48A9C5),
                            borderRadius: BorderRadius.circular(5)),
                        child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage()));
                            },
                            child: Text("التالي",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: 'Arial Hebrew')))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
