import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/models/coffee.dart';
import 'package:coffee_app/services/product_service.dart';
import 'package:flutter/material.dart';

class CoffeeShop extends ChangeNotifier {
  final ProductService productService = new ProductService();
//  static final List<Coffee> _shop = [
//     Coffee(name: 'Long Black', price: 4.1, imagePath: 'lib/images/black.png'),
//     Coffee(name: 'Latte', price: 13.5, imagePath: 'lib/images/latte.png'),
//     Coffee(name: 'Espresso', price: 7, imagePath: 'lib/images/espresso.png'),
//     Coffee(name: 'Iced Coffee', price: 5.0, imagePath: 'lib/images/iced_coffee.png'),
//   ];


  // Future<void> addCoffeeToFirebase() async{
  //   for(var coffee in _shop){
  //     await FirebaseFirestore.instance.collection('Products').add(coffee.toMap());
  //   }
  // }

  Stream<List<Coffee>> get coffeeShop => productService.getProducts();

  List<Coffee> _userCart = [];

  List<Coffee> get userCart => _userCart;

  void addItemToCart(Coffee coffee, int quantity){
    _userCart.add(coffee);
    coffee.quantity = quantity;
    notifyListeners();
  }
  void removeItemFromCart(Coffee coffee, int quantity){
    _userCart.remove(coffee);
    notifyListeners();
  }
  void clearCart(){
    _userCart.clear();
    notifyListeners();
  }
}
