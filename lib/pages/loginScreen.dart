import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Widgets/flush_bar.dart';
import 'package:graduation_project/providers/userStateProvider.dart';
import 'package:graduation_project/services/auth.dart';
import 'package:provider/provider.dart';

import 'Recover_Account.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure2 = true;
  bool isLoading = false;
  var email = TextEditingController();
  var password = TextEditingController();
  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  Future initAuthentication(AuthService authService) async {
    setState(() {
      isLoading = true;
    });
    try {
      var user = await authService.signInUser(email.text, password.text);

      context.read<UserState>().setUser(auth.currentUser);
      var firestoreUserData = await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser?.uid)
          .get()
          .then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          context.read<UserState>().setUserInfoRegistered(data);
        },
        onError: (e) => print("Error getting document: $e"),
      );

      Navigator.pushNamed(context, '/home');
    } catch (e) {
      buildFlushbar(context, messageText: 'يوجد خطأ في الايميل او كلمة المرور')
          .show(context);
    }
    setState(() {
      isLoading = false;
    });
  }

  Future reloadFirebaseUser() async {
    //login with firebase!!!
    await auth.currentUser?.reload();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff48A9C5),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushNamed(context, '/home'),
          ),
          title: Text("تسجيل الدخول"),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: SingleChildScrollView(
            child: Container(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xff48A9C5)),
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                      child: TextFormField(
                        controller: email,
                        validator: (email) {
                          if (email != null &&
                              !EmailValidator.validate(email) &&
                              email.length > 0) {
                            return 'يرجى إدخال بريد إلكتروني صحيح';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          border: InputBorder.none,
                          hintText: 'البريد الإلكتروني',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xff48A9C5)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
                        obscureText: _isObscure2,
                        controller: password,
                        validator: (value) {
                          if (value != null &&
                              value.length <= 7 &&
                              value.length > 0) {
                            return 'يجب أن لا تقل كلمة المرور عن ثمانية حروف أو أرقام';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: ' كلمة المرور',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure2 = !_isObscure2;
                              });
                            },
                            icon: Icon(Icons.remove_red_eye),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    isLoading
                        ? CircularProgressIndicator()
                        : Column(
                            children: [
                              Container(
                                width: 250,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Color(0xff48A9C5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      initAuthentication(authService);
                                    }
                                  },
                                  child: Text(
                                    "تسجيل الدخول",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
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
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RecoverAccount(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "استرجاع الحساب",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
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
