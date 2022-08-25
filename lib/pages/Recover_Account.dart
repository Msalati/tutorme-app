import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Widgets/AppBar.dart';

import 'Recover_Account_Code.dart';

class RecoverAccount extends StatelessWidget {
  const RecoverAccount({Key? key}) : super(key: key);

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
                    Text('استرداد الحساب',style: TextStyle(fontSize: 25),),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'رقم الهاتف'),
                    ),        SizedBox(
                      height: 50,
                    ),      Container(
                        width: 250,
                        padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            color: Color(0xff48A9C5),
                            borderRadius: BorderRadius.circular(5)),
                        child: MaterialButton(
                            onPressed: () {
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>
                              Recover_Account_code()));
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
