import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Widgets/errorOccurredDialog.dart';
import 'package:graduation_project/Widgets/successDialog.dart';
import 'package:graduation_project/pages/loginScreen.dart';
import 'package:graduation_project/providers/userStateProvider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var phone_number = TextEditingController();
  String userType = 'client';
  String dropdownValue = 'طرابلس';
  var user = {
    "address": "",
    "created_at": "",
    "firstname": "",
    "lastname": "",
    "id": "",
    "iaActive": "",
    "isVIP": "",
    "phone_number": "",
    "skills": "",
    "type": ""
  };
  registerUser(usersCollection) async {
    try {
      final auth = FirebaseAuth.instance;
      // Attempt to sign in the user in with Google
      var userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);
      // debugPrint('testing worked ${mailer.user.ui}');
      var userObject = {
        "id": userCredentials.user!.uid,
        "firstname": firstName.text,
        "lastname": lastName.text,
        "address": dropdownValue,
        "email": email.text,
        "created_at": DateTime.now().millisecondsSinceEpoch,
        "isActive": true,
        "isVIP": false,
        "phone_number": '+218${phone_number.text}',
        "skills": "",
        "type": userType
      };

      if (userType == 'client') {
        userObject.remove('isVIP');
        userObject.remove('skills');
      }
      //inserting into firebase FIRESTORE the user data that was inserted
      var firestoreUser = await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser?.uid)
          .set(userObject);
      await auth.currentUser
          ?.updateDisplayName("${firstName.text} ${lastName.text}");

      //update photo
      await auth.currentUser?.updatePhotoURL('https://picsum.photos/200');

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

      context.read<UserState>().setUser(auth.currentUser);

      showDialog(
          context: context,
          builder: (context) {
            return successDialog(
              text: 'تم التسجيل بنجاح',
              content: 'قم بالتأكيد للتوجه للصفحة الرئيسية ',
              navigateTo: '/home',
            );
          });

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showDialog(
            context: context,
            builder: (context) {
              return errorOccurredDialog(
                  text: 'حدث خطأ في تسجيل الحساب',
                  content:
                      'البريد الإلكتروني هذا مسجل بالفعل، يرجى إستخدام حساب آخر.');
            });
      }
      if (e.code == 'account-exists-with-different-credential') {
        // The account already exists with a different credential
        String? email = e.email;
        AuthCredential? pendingCredential = e.credential;

        showDialog(
            context: context,
            builder: (context) {
              return errorOccurredDialog(
                  text: 'حدث خطأ', content: 'خطأ : ${e.code}');
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'إنشاء حساب',
              style: TextStyle(fontFamily: 'Cairo'),
            ),
            backgroundColor: Color(0xff48A9C5),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'Images/New__User.png',
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: Color(0xff48A9C5)),
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextFormField(
                                  controller: firstName,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'الاسم'),
                                )),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: Color(0xff48A9C5)),
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextFormField(
                                  controller: lastName,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'اللقب'),
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xff48A9C5)),
                            borderRadius: BorderRadius.circular(12)),
                        child: Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: TextFormField(
                              controller: email,
                              validator: (email) {
                                if (email != null &&
                                    !EmailValidator.validate(email)) {
                                  return 'يرجى إدخال بريد إلكتروني صحيح';
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.email),
                                  border: InputBorder.none,
                                  hintText: 'البريد الإلكتروني'),
                            ))),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xff48A9C5)),
                            borderRadius: BorderRadius.circular(12)),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: TextFormField(
                                textAlign: TextAlign.right,
                                controller: phone_number,
                                validator: (phone_number) {
                                  if (phone_number != null &&
                                      phone_number.length <= 8) {
                                    return 'يجب أن يكون رقم الهاتف صحيحًا.';
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.phone_android),
                                    prefixText: '+218',
                                    border: InputBorder.none,
                                    hintText: 'رقم الهاتف'),
                              )),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xff48A9C5)),
                            borderRadius: BorderRadius.circular(12)),
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            controller: password,
                            textDirection: TextDirection.ltr,
                            validator: (value) {
                              if (value != null && value.length <= 7) {
                                return 'يجب أن لا تقل كلمة المرور عن ثمانية حروف أو أرقام';
                              } else {
                                return null;
                              }
                            },
                            obscureText: _isObscure1,
                            decoration: InputDecoration(
                                icon: Icon(Icons.password),
                                border: InputBorder.none,
                                hintText: 'كلمة المرور',
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isObscure1 = !_isObscure1;
                                      });
                                    },
                                    icon: Icon(Icons.remove_red_eye))),
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xff48A9C5)),
                            borderRadius: BorderRadius.circular(12)),
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            obscureText: _isObscure2,
                            textDirection: TextDirection.ltr,
                            controller: confirmPassword,
                            validator: (value) {
                              if (value != null && value != password.text) {
                                return 'يجب أن تكون كلمة المرور متطابقة';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                icon: Icon(Icons.password),
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
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child:
                                  Text('المدينة', textAlign: TextAlign.right)),
                          Expanded(
                            flex: 3,
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              elevation: 16,
                              isExpanded: true,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>[
                                'طرابلس',
                                'بنغازي',
                                'الزاوية',
                                'الجفرة',
                                'الكفرة',
                                'سرت',
                                'زنتان',
                                'الرحيبات',
                                'جادو',
                                'غريان',
                                'العزيزية',
                                'نالوت',
                                'البيضاء',
                                'الرجبان',
                                'سبها'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    textAlign: TextAlign.right,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Row(children: [
                        Text('نوع المستخدم', textAlign: TextAlign.right),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            Text('عميل'),
                            Radio(
                                value: 'client',
                                groupValue: userType,
                                onChanged: (val) {
                                  setState(() {
                                    userType = val.toString();
                                  });
                                })
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            Text('مرشد'),
                            Radio(
                                value: 'tutor',
                                groupValue: userType,
                                onChanged: (val) {
                                  setState(() {
                                    userType = val.toString();
                                  });
                                })
                          ],
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border:
                              Border.all(color: Color(0xff48A9C5), width: 2),
                          borderRadius: BorderRadius.circular(5)),
                      child: MaterialButton(
                        onPressed: () async {
                          await registerUser(usersCollection);
                        },
                        child: Text(
                          'إنشاء الحساب',
                          style:
                              TextStyle(color: Color(0xff48A9C5), fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
