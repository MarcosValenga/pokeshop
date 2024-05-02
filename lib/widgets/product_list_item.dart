import 'package:flutter/material.dart';
import 'package:pokeshop/models/product.dart';
import 'package:pokeshop/widgets/product_detail_page.dart';
import 'package:provider/provider.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: true);
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
      child: GestureDetector(
        child: Card(
          color: const Color.fromARGB(255, 255, 255, 255),
          elevation: 3,
          margin: const EdgeInsets.symmetric(
            vertical: 7,
            horizontal: 5,
          ),
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                elevation: 5,
                context: context,
                builder: (BuildContext context) {
                  return ProductDetailPage(product);
                },
              );
            },
            child: ListTile(
              dense: true,
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(product.imgUrl),
              ),
              title: Text(
                product.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text('${product.description}\n${product.stock}x '),
              trailing: Text(
                "PokeDollar\n\$${product.price.toStringAsFixed(2)}",
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}