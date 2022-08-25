import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Widgets/Category_Widget.dart';
import 'package:graduation_project/providers/categoryStateProvider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool _isFavorited = true;
  int _favoriteCount = 41;
  var _toggleFavorite;

  List<String> docIDs = [];

  CategoryState categoryRef = new CategoryState();

  Future getDocIds() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then(((snapshot) {
      snapshot.docs.forEach((element) {
        categoryRef.setCategories(element.data());
        // <UserState>().setUser(auth.currentUser);
        // print(element.data()['firstname']);
      });
    }));
  }

  // ···
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('categories').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/category/courses');
                  },
                  title: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.width / 4,
                      child: CategoryWidget(
                        icon: Icons.menu_book,
                        text: document['title'],
                        startColor: 'f48A9C5',
                        endColor: '48C9D7',
                        sizedBoxHeight: 10,
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
