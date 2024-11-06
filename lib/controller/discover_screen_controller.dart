import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingcart/utils/constants/discover_model_screen.dart.dart';

class DiscoverScreenController with ChangeNotifier {
  bool isClicked = false;
  int selectedCategoryindex = 0;
  bool isLogined = false;
  bool isProductLogined = false;
  List<DiscoverResmodel> productlist = [];
  List categorylist = [];
  final categoryurl = Uri.parse('https://fakestoreapi.com/products/categories');

  Future getAllproducts() async {
    final producturl = Uri.parse('https://fakestoreapi.com/products');
    final productcategoryurl = Uri.parse(
        'https://fakestoreapi.com/products/category/${categorylist[selectedCategoryindex]}'); //for Selecting item Based on Catergory
    isProductLogined = true;
    notifyListeners();
    var response = await http
        .get(selectedCategoryindex == 0 ? producturl : productcategoryurl);
    try {
      if (response.statusCode == 200) {
        productlist = discoverResmodelFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
    isProductLogined = false;
    notifyListeners();
  }

  Future getcategory() async {
    isLogined = true;
    notifyListeners();
    var response = await http.get(categoryurl);
    try {
      if (response.statusCode == 200) {
        categorylist = jsonDecode(response.body);
        categorylist.insert(0, "All");
      }
    } catch (e) {
      print(e);
    }

    isLogined = false;
    notifyListeners();
  }

  onCategorySelection(int index) {
    selectedCategoryindex = index;
    getAllproducts();
    notifyListeners();
  }
}
