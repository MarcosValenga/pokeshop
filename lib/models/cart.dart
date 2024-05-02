import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokeshop/models/cart_item.dart';
import 'package:pokeshop/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  // Contar quantidade de items no carrinho
  int get itemsCountCart {
    return _items.length;
  }

  void addQuantity(String productId) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (exestingItem) => CartItem(
            id: exestingItem.id,
            productId: exestingItem.productId,
            name: exestingItem.name,
            quantity: exestingItem.quantity + 1,
            price: exestingItem.price,
            imgUrl: exestingItem.imgUrl),
      );
    }
    notifyListeners();
  }

  void removQuantity(String productId, int quantity) {
    if (_items.containsKey(productId) && ((quantity) > 1)) {
      // Se item conter key product.id de um produto ja no carrnho, item update
      _items.update(
        productId,
        (exestingItem) => CartItem(
            id: exestingItem.id,
            productId: exestingItem.productId,
            name: exestingItem.name,
            quantity: exestingItem.quantity - 1,
            price: exestingItem.price,
            imgUrl: exestingItem.imgUrl),
      );
    }
    notifyListeners();
  }

  // Adicionando Item no carrinho
  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      // Se item conter key product.id de um produto ja no carrnho, item update
      _items.update(
        product.id,
        (exestingItem) => CartItem(
          id: exestingItem.id,
          productId: exestingItem.productId,
          name: exestingItem.name,
          quantity: exestingItem.quantity + 1,
          price: exestingItem.price,
          imgUrl: exestingItem.imgUrl,
        ),
      );
    } else {
      // Caso nao contenha a key do item, add item
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          name: product.name,
          quantity: 1,
          price: product.price,
          imgUrl: product.imgUrl,
        ),
      );
    }
    notifyListeners();
  }

  // Remove um item como um todo do carrinho
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  // Faz a soma total de todos os items do carrinho
  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  // Limpar carrinho apos Efetuar compra
  void clear() {
    _items = {};
    notifyListeners();
  }
}
