import 'package:flutter/material.dart';

class CategoryState with ChangeNotifier {
  var _categories;
  get categories => _categories;

  void setCategories(categories){
    _categories = categories;
    notifyListeners();
  }
}