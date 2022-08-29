import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:graduation_project/providers/userStateProvider.dart';
import 'package:intl/intl.dart' as dateBox;
import 'package:provider/provider.dart';

class CreateCourse extends StatefulWidget {
  const CreateCourse({Key? key}) : super(key: key);

  @override
  State<CreateCourse> createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  final _formKey = GlobalKey<FormState>();

  var course_name = TextEditingController();
  var course_desc = TextEditingController();
  var course_location = TextEditingController();
  var course_price = TextEditingController();
  var course_type = 'إختر فئة';
  var course_category = null;
  var __category = null;
  DateTime selectedDate = DateTime.now();
  Timestamp stamp = Timestamp(1231, 12312);

  var course = {
    "title": "",
    "body": "",
    "location": "",
    "price": "",
    "time": "",
    "tutor": "",
    "category": ""
  };
  //invalid chracters for price
  static final validChars = RegExp(r'^[0-9]+$');

  Future<Map<String, dynamic>?> getCategories() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('categories').snapshots();
  }

  Future<Map<String, dynamic>?> createCourse(user) async {
    // final snapshot = await fireStore.collection('categories').snapshots();
    var course = {
      "title": course_name.text,
      "body": course_desc.text,
      "location": course_location.text,
      "price": course_price.text,
      "time": stamp,
      "tutor": user,
      "category": {"id": __category.id, "title": __category['title']}
    };
    // course['id'] = FirebaseFirestore.instance.collection('ads').doc().id;
    await FirebaseFirestore.instance
        .collection('ads')
        .doc()
        .set(course)
        .then((value) {
      Navigator.pushNamed(context, '/home');
    }).catchError((onError) {});
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('إنشاء إعلان'),
            backgroundColor: Color(0xff48A9C5),
          ),
          body: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'إسم الإعلان',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff48A9C5)),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          controller: course_name,
                          validator: (course_name) {
                            if (course_name != null && course_name.length > 0) {
                              return null;
                            } else {
                              return 'يجب إدخال إسم الإعلان';
                            }
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'إسم يوضح الإعلان'),
                        )),
                    Text(
                      'وصف الإعلان',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff48A9C5)),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          maxLines: 3,
                          controller: course_desc,
                          validator: (course_desc) {
                            if (course_desc != null &&
                                course_desc.length > 10) {
                              return null;
                            } else {
                              return 'يجب إدخال وصف و أن يكون 10 حروف على الأقل';
                            }
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'تكلم عن الإعلان الخاص بك'),
                        )),
                    Text(
                      'عنوان المكان',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff48A9C5)),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          controller: course_location,
                          validator: (course_location) {
                            if (course_location != null &&
                                course_location.length > 0) {
                              return null;
                            } else {
                              return 'يجب إدخال العنوان';
                            }
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'الموقع الجغرافي الخاص بالمكان'),
                        )),
                    Text(
                      'السعر',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff48A9C5)),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: course_price,
                          validator: (course_price) {
                            if (course_price != null &&
                                course_price.length > 0 &&
                                validChars.hasMatch(course_price)) {
                              return null;
                            } else {
                              return 'يجب إدخال السعر بطريقة صحيحة';
                            }
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: '999 د.ل.'),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'توقيت الجلسة',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        color: Color(0xff48A9C5),
                        child: MaterialButton(
                          onPressed: () {
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2018, 3, 5),
                                maxTime: DateTime(2019, 6, 7),
                                onConfirm: (date) {
                              setState(() {
                                selectedDate = date;
                                stamp = Timestamp.fromDate(date);
                              });
                            },
                                currentTime: selectedDate,
                                locale: LocaleType.en);
                          },
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              dateBox.DateFormat()
                                  .add_yMd()
                                  .add_jm()
                                  .format(selectedDate),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'فئة الإعلان',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('categories')
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff48A9C5)),
                                borderRadius: BorderRadius.circular(5)),
                            child: DropdownButtonFormField<String>(
                              validator: (selection) {
                                if (selection != null) {
                                  return null;
                                } else {
                                  return 'يجب إدخال فئة الإعلان';
                                }
                              },
                              value: course_category,
                              isExpanded: true,
                              onChanged: (value) {
                                course_category = value;
                                // print(course_category);
                                setState(() {});
                              },
                              items: snapshot.data?.docs.map((doc) {
                                    // your widget here(use doc data)
                                    // print(doc.reference.id);
                                    // print(doc);
                                    return DropdownMenuItem<String>(
                                        value: doc.reference.id.toString(),
                                        onTap: () {
                                          __category = doc;
                                        },
                                        child: Text(doc['title']));
                                  }).toList() ??
                                  [],
                            ),
                          );
                        } else {
                          // or your loading widget here
                          return Text('Loading...');
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 30),
                          width: 250,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                              color: Color(0xff48A9C5),
                              borderRadius: BorderRadius.circular(5)),
                          child: MaterialButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate())
                                  createCourse(
                                      context.read<UserState>().userEntity);
                              },
                              child: Text("نشر الإعلان",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Cairo')))),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
