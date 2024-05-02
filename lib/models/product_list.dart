import 'package:flutter/material.dart';
import 'package:pokeshop/data/dummy_data.dart';
import 'package:pokeshop/models/product.dart';

// Classe com ChangeNotifier para o notificar os interessados pela mudança de tal informaçao
class ProductList with ChangeNotifier {
  final List<Product> _items =
      dummyProducts; // Atribuindo os produtos para uma var privada chamda _items

  bool _showFavoriteOnly = false;

  // Procurando o produto com base no ID
  int foundProduct = 0;
  int stockMax(String productId) {
    for (var product in _items) {
      if (product.id == productId) {
        foundProduct = product.stock;
        break;
      }
    }
    return foundProduct;
  }


  List<Product> get items {
    if (_showFavoriteOnly) {
      return _items.where((prod) => prod.isFavorite).toList();
    }
    return [..._items];
  }

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }

  void stockManager(String productId, int quantity) {
    final productIndex = _items.indexWhere((product) => product.id == productId);
    if (productIndex != -1) {
      if (_items[productIndex].stock > 0) {
        _items[productIndex].stock =_items[productIndex].stock - quantity;
        notifyListeners();
      }
    }
  }
  // Método para contar a quantidade de items da lista de produtos
  int get itemsCountProducts {
    return _items.length;
  }
}
