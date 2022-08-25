import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Widgets/AppBar.dart';

class Recover_Account_code extends StatelessWidget {
  const Recover_Account_code({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar('إسترداد الحساب'),
        body: Container(
          color: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(
                      'ادخل الكود',
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          fillColor: Colors.grey[100],
                          filled: true,
                          border: InputBorder.none,
                          hintText: 'ادخل رمز التفعيل'),
                    ),
                    SizedBox(
                      height: 50,
                    ),

//          Text Link
           /*     InkWell(onTap: (){
                    print("Hello there General Kanoby");
                  },
                    child:  Text('لم تحصل على الرمز بعد؟ إضغط هنا',)
                    ,
                  )
                   ,*/
                    Row(
                      children: [
                        Text('لم تحصل على الرمز بعد؟ ',),
                        TextButton(
                          onPressed: () {
                            //action
                          },
                          child: Text('إضغط هنا',)
                        ),
                      ],
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
                            onPressed: () {},
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
