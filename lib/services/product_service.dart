import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/models/coffee.dart';
import 'package:flutter/material.dart';

class ProductService extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addProduct(coffeeName, coffeePrice, coffeeImage) async {
    try {
      await _firestore.collection('Products').doc(coffeeName).set(
          {'name': coffeeName, 'price': coffeePrice, 'image': coffeeImage});
      notifyListeners();
    } catch (e) {
      print('===================================');
      print(e);
    }
  }

  Future<void> deleteProduct(String coffeeName) async {
    try {
      await _firestore.collection('Products').doc(coffeeName).delete();
      notifyListeners();
    } catch (e) {
      print('===================================');
      print(e);
    }
  }

  Stream<List<Coffee>> getProducts() {
    return _firestore.collection('Products').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Coffee.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

}
