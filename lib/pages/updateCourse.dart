import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Widgets/flush_bar.dart';
import 'package:provider/provider.dart';

import '../providers/userStateProvider.dart';

class UpdateCourse extends StatefulWidget {
  const UpdateCourse({
    required this.context,
    required this.valueListen,
    Key? key,
  }) : super(key: key);
  final BuildContext context;
  final ValueNotifier<int> valueListen;

  @override
  State<UpdateCourse> createState() => _UpdateCourseState();
}

class _UpdateCourseState extends State<UpdateCourse> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController firstName = TextEditingController(
      text: widget.context.watch<UserState>().userEntity['firstname']);
  late TextEditingController lastName = TextEditingController(
      text: widget.context.watch<UserState>().userEntity['lastname']);
  late TextEditingController email = TextEditingController(
      text: widget.context.watch<UserState>().userEntity['email']);
  late TextEditingController phone_number = TextEditingController(
      text: widget.context.watch<UserState>().userEntity['phone_number']);
  late TextEditingController password = TextEditingController();
  late TextEditingController confirmPassword = TextEditingController();
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  bool isLoading = false;
  String? dropdownValue = 'طرابلس';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'تعديل الحساب',
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
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
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
                                horizontal: 10,
                                vertical: 0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0xff48A9C5),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                controller: firstName,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'الاسم',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0xff48A9C5),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                controller: lastName,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'اللقب',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xff48A9C5),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
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
                          hintText: 'البريد الإلكتروني',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xff48A9C5),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
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
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xff48A9C5),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
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
                            icon: Icon(Icons.remove_red_eye),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xff48A9C5),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
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
                            icon: Icon(Icons.remove_red_eye),
                          ),
                        ),
                      ),
                    ),
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
                    isLoading
                        ? CircularProgressIndicator()
                        : Container(
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    color: Color(0xff48A9C5), width: 2),
                                borderRadius: BorderRadius.circular(5)),
                            child: MaterialButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  UpdateCourse();
                                }
                              },
                              child: Text(
                                'تعديل',
                                style: TextStyle(
                                    color: Color(0xff48A9C5), fontSize: 20),
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
    );
  }

  void UpdateCourse() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.currentUser!.updateEmail(email.text);
      await FirebaseAuth.instance.currentUser!.updatePassword(password.text);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(Provider.of<UserState>(widget.context, listen: false)
              .userEntity['id'])
          .update({
        'firstname': firstName.text,
        'lastname': lastName.text,
        'email': email.text,
        'phone_number': phone_number.text,
        'address': dropdownValue,
      });

      final userdata = await FirebaseFirestore.instance
          .collection('users')
          .doc(Provider.of<UserState>(widget.context, listen: false)
              .userEntity['id'])
          .get();
      Provider.of<UserState>(widget.context, listen: false)
          .setUserInfoRegistered(userdata);
      widget.valueListen.notifyListeners();
      buildFlushbar(context,
              messageText: 'تم التعديل بنجاح',
              title: 'تمت العملية',
              successes: true)
          .show(context);
    } catch (e) {
      buildFlushbar(context, messageText: 'حدث خطأ اثناء عملية التعديل')
          .show(context);
    }
    setState(() {
      isLoading = false;
    });
  }
}
