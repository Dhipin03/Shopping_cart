import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:shoppingcart/utils/constants/discover_model_screen.dart.dart';

class ProductDetailsscreenController with ChangeNotifier {
  bool isLogined = false;
  DiscoverResmodel? product;
  getProductDetails(int id) async {
    isLogined = true;
    notifyListeners();
    final productbyidurl = Uri.parse('https://fakestoreapi.com/products/$id');
    try {
      var response = await http.get(productbyidurl);
      if (response.statusCode == 200) {
        product = DiscoverResmodel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
    isLogined = false;
    notifyListeners();
  }
}
