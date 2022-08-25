// import 'dart:js';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Widgets/Post_Widget.dart';
import 'package:graduation_project/Widgets/Primary_Text.dart';
import 'package:graduation_project/pages/rulesPage.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/providers/userStateProvider.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String appLogo = 'appLogo.png';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: _getFAB(context, context.read<UserState>().type),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.grey[200],
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image(image: AssetImage('Images/${appLogo}'), width: 120)
              ]),
              SizedBox(
                height: 20,
              ),
              CarouselSlider(
                options: CarouselOptions(
                    height: size.height * 0.3,
                    autoPlay: true,
                    pauseAutoPlayOnTouch: true),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  Image.network('https://picsum.photos/400/250')
                                      .image),
                        ),
                        child: Center(
                            child: Container(
                                margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
                                child: Text(
                                  'Just a course',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      background: Paint(),
                                      fontWeight: FontWeight.bold),
                                ))),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 20,
              ),
              PrimaryText(text: 'الاعلانات'),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('ads')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Column(
                        // scrollDirection: Axis.vertical,
                        // shrinkWrap: true,
                        children: snapshot.data!.docs.map((document) {
                          return ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, '/course');
                            },
                            title: Center(
                              child: Container(
                                  child: Column(children: [
                                SizedBox(
                                  height: 20,
                                ),
                                PostWidget(
                                    tags: [document['category']['title']],
                                    titleText: document['title'],
                                    timeOfCourse: DateTime.utc(
                                        1989, DateTime.november, 9),
                                    postText: document['body'],
                                    userImage: 'https://picsum.photos/400/250',
                                    userName: document['tutor']['firstname'] +
                                        " " +
                                        document['tutor']['lastname'],
                                    onPress: () {})
                              ])),
                            ),
                          );
                        }).toList(),
                      );
                    }),
              )
            ]),
          ),
        ),
      ),
    );

    //             child: Column(
    //               children: [
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 PostWidget(
    //                     tags: [
    //                       'تعليم جامعي',
    //                       'رياضة 1',
    //                       'الدرس الرابع',
    //                     ],
    //                     titleText: 'كورس تعلم اللغة الإنجليزية',
    //                     timeOfCourse: DateTime.utc(1989, DateTime.november, 9),
    //                     postText:
    //                         'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رس'
    //                         'د و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی',
    //                     userImage: 'Images/user.png',
    //                     userName: 'محمد عادل عبد الواحد يوسف',
    //                     onPress: () {})]),
  }
}

Widget _getFAB(var context, String type) {
  if (type != 'tutor') {
    return Container();
  } else {
    return FloatingActionButton.small(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.pushNamed(context, '/course/create');
      },
      backgroundColor: Color(0xff48A9C5),
    );
  }
}
