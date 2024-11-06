import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shoppingcart/utils/constants/discover_model_screen.dart.dart';
import 'package:sqflite/sqflite.dart';

class AddtocartScreenController with ChangeNotifier {
  late Database mydatabase;
  final _razorpay = Razorpay();
  List<Map<String, dynamic>> addeditem = [];
  double totalamount = 0.00;
  Future initdb() async {
    mydatabase = await openDatabase('database123.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Cart (id INTEGER PRIMARY KEY, name TEXT, quantity INTEGER,image TEXT,description TEXT,productid INTEGER,amount REAL)');
    });
  }

  Future addProducttocart(DiscoverResmodel product) async {
    bool flag = addeditem.any((element) =>
        product.id ==
        element['productid']); //check the product alreday added or not

    if (flag) {
      log('already added');
    } else {
      await mydatabase.rawInsert(
          'INSERT INTO Cart(name, quantity, image ,description,productid,amount) VALUES(?,?,?,?,?,?)',
          [
            product.title,
            1,
            product.image,
            product.description,
            product.id,
            product.price
          ]);
    }
  }

  Future getproduct() async {
    addeditem = await mydatabase.rawQuery('SELECT * FROM Cart');
    //log(addeditem.toString());
    calculatetotalamount();
    notifyListeners();
  }

  Future incrementquantity({required int currentqty, required int id}) async {
    await mydatabase.rawUpdate('UPDATE Cart SET quantity = ? WHERE id = ?', [
      ++currentqty,
      id,
    ]);
    getproduct();
    notifyListeners();
  }

  decerementquantity({required int currentqty, required int id}) async {
    if (currentqty > 1) {
      await mydatabase.rawUpdate('UPDATE Cart SET quantity = ? WHERE id = ?', [
        --currentqty,
        id,
      ]);
    }
    getproduct();
    notifyListeners();
  }

  Future removeitem(int id) async {
    await mydatabase.rawDelete('DELETE FROM Cart WHERE id = ?', [id]);
    notifyListeners();
    getproduct();
  }

  calculatetotalamount() {
    totalamount = 0.00;
    for (var e in addeditem) {
      totalamount += e['quantity'] * e['amount'];
    }
    notifyListeners();
  }

  paymentmethod() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    var options = {
      'key': 'rzp_test_1ibUrJgD7bPXSg',
      'amount': totalamount,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };
    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
}
