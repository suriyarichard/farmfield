import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  // list of items on sale
  final List _shopItems = const [
    // [ itemName, itemPrice, imagePath, color ]
    ["JD Fresh", "2.50", "assets/p-1.jpg", Colors.yellow],
    ["Herbicide", "12.80", "assets/p-3.jpg", Colors.brown],
    ["Sumari", "1.00", "assets/p-4.jpg", Colors.blue],
    ["Fungi", "1.00", "assets/p-5.jpg", Colors.green],
    ["Super Pest Guard", "1.00", "assets/p-6.jpg", Colors.blue],
    ["Pest Fix", "1.00", "assets/p-7.jpg", Colors.blue],
    ["Dr.Earth", "1.00", "assets/p-8.jpg", Colors.blue],
    ["Plant Protector", "1.00", "assets/p-9.jpg", Colors.blue],
    ["Bloom Buddy", "1000.00", "assets/p-10.jpg", Colors.blue],
  ];

  // list of cart items
  List _cartItems = [];

  get cartItems => _cartItems;

  get shopItems => _shopItems;

  // add item to cart
  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  // calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }
}
