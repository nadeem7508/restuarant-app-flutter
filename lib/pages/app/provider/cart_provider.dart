import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvider with ChangeNotifier {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  CartProvider() {
    _loadCart(); // Load cart when the app starts
  }

  void addToCart(Map<String, dynamic> product) {
    if (product.containsKey('id') && product['id'] != null) {
      _items.add(product);
      _saveCart();
      notifyListeners();
    } else {
      print('Error: Product ID is missing!');
    }
  }

  void removeFromCart(String productId) {
    _items.removeWhere((item) => item['id'] == productId);
    _saveCart();
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    _saveCart();
    notifyListeners();
  }

  /// **Save cart items to SharedPreferences**
  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = jsonEncode(_items);
    await prefs.setString('cart', cartJson);
  }

  /// **Load cart items from SharedPreferences**
  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString('cart');

    if (cartJson != null) {
      _items = List<Map<String, dynamic>>.from(jsonDecode(cartJson));
    }
    notifyListeners();
  }
}
