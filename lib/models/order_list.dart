import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokeshop/models/cart.dart';
import 'package:pokeshop/models/order.dart';

class OrderList with ChangeNotifier {
  final List<Order> _items = [];
  List<Order> get items {
    return [..._items];
  }

  int get itemsCountOrder {
    return _items.length;
  }

  void addOrder(Cart cart) {
    _items.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
