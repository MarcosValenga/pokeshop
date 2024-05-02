import 'package:flutter/material.dart';
import 'package:pokeshop/models/product.dart';
import 'package:pokeshop/models/product_list.dart';
import 'package:pokeshop/widgets/product_list_item.dart';
import 'package:provider/provider.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList provider = Provider.of<ProductList>(context); //Atribuindo caminho de ProductList para provider
    final List<Product> loadedProducts = provider.items; // produtos recebidos pelo getter items

    return ListView.builder(
      itemCount: loadedProducts.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: loadedProducts[index],
        child: const ProductListItem(),
      ),
    );
  }
}
