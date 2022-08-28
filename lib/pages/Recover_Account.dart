import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Widgets/AppBar.dart';
import 'package:graduation_project/Widgets/flush_bar.dart';
import 'package:graduation_project/pages/done_reset_password.dart';

import 'Recover_Account_Code.dart';

class RecoverAccount extends StatefulWidget {
  const RecoverAccount({Key? key}) : super(key: key);

  @override
  State<RecoverAccount> createState() => _RecoverAccountState();
}

class _RecoverAccountState extends State<RecoverAccount> {
  final TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar('إسترداد الحساب'),
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 25,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 80,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'استرداد الحساب',
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'البريد الالكتروني',
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      isLoading
                          ? CircularProgressIndicator()
                          : Container(
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
                                  if (_formKey.currentState!.validate()) {
                                    resetPassword();
                                  }
                                },
                                child: Text(
                                  "البحث",
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetPassword() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DoneResetPassword(),
        ),
      );
    } catch (e) {
      buildFlushbar(context, messageText: 'البريد الاكتروني غير موجود')
          .show(context);
    }
    setState(() {
      isLoading = false;
    });
  }
}
