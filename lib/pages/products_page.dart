import 'package:flutter/material.dart';
import 'package:pokeshop/models/product_list.dart';
import 'package:pokeshop/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: products.itemsCountProducts,
        itemBuilder: (ctx, i) => Column(
          children: [
            ProductItem(products.items[i]),
            Divider(),
          ],
        ),
      ),
      
    );
  }
}
