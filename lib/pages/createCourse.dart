import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CreateCourse extends StatefulWidget {
  const CreateCourse({Key? key}) : super(key: key);

  @override
  State<CreateCourse> createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  var course_name = TextEditingController();
  var course_desc = TextEditingController();
  var course_type = 'إختر فئة';
  var fireStore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getCategories() async {
    final snapshot = await fireStore.collection('categories').snapshots();
    print(snapshot);
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate, initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'إسم الإعلان',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'إسم يوضح الإعلان'),
                      )),
                  Text(
                    'وصف الإعلان',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff48A9C5)),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        maxLines: 6,
                        controller: course_desc,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'تكلم عن الإعلان الخاص بك'),
                      )),
                  Text(
                    'عنوان المكان',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'الموقع الجغرافي الخاص بالمكان'),
                      )),
                  Text(
                    'السعر',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: '999 د.ل.'),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'فئة الإعلان',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                          child: DropdownButton<String>(
                            isExpanded: true,
                            onChanged: (value) {
                              print(value);
                            },
                            items: snapshot.data?.docs?.map((doc) {
                                  // your widget here(use doc data)
                                  // print(doc.reference.id);
                                  // print(doc);
                                  return DropdownMenuItem<String>(
                                      value: doc.reference.id,
                                      child: Text(doc['title']));
                                })?.toList() ??
                                [],
                          ),
                        );
                      } else {
                        // or your loading widget here
                        return Text('damn it');
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'توقيت الجلسة',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: <Widget>[
                      Text("${selectedDate.toLocal()}".split(' ')[0]),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        onPressed: () => _selectDate(context),
                        child: Text('Select date'),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 30),
                        width: 250,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            color: Color(0xff48A9C5),
                            borderRadius: BorderRadius.circular(5)),
                        child: MaterialButton(
                            onPressed: () {},
                            child: Text("نشر الإعلان",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: 'Cairo')))),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
