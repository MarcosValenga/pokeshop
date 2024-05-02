import 'package:flutter/material.dart';
import 'package:pokeshop/models/product.dart';
import 'package:pokeshop/models/product_list.dart';
import 'package:pokeshop/utils/app_routes.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context, listen: false);

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imgUrl),
      ),
      title: Text(product.name),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCT_FORM,
                  arguments: product,
                );
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Tem Certeza'),
                          content: const Text('Quer remover o item?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Não'),
                            ),
                            TextButton(
                              onPressed: () {
                                provider.removeItem(product);
                                Navigator.of(context).pop();
                              },
                              child: const Text('Sim'),
                            )
                          ],
                        ));
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
