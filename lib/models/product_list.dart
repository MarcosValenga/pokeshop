import 'package:flutter/material.dart';
import 'package:pokeshop/data/dummy_data.dart';
import 'package:pokeshop/models/product.dart';

// Classe com ChangeNotifier para o notificar os interessados pela mudança de tal informaçao
class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts; // Atribuindo os produtos para uma var privada chamda _items
  List<Product> get items => [..._items];
  List<Product> get favoriteItems => _items.where((prod) => prod.isFavorite).toList();

  // Método para contar a quantidade de items da lista de produtos
  int get itemsCountProducts {
    return _items.length;
  }
}
