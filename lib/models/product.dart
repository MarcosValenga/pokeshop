import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String tipoItem;
  final String description;
  final double price; 
  int stock;
  final String imgUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.tipoItem,
    required this.description,
    required this.price,
    required this.stock,
    required this.imgUrl,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }


}
