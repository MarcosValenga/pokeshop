import 'package:flutter/material.dart';
import 'package:pokeshop/models/cart.dart';
import 'package:pokeshop/models/cart_item.dart';
import 'package:pokeshop/models/product_list.dart';
import 'package:provider/provider.dart';

class CartList extends StatelessWidget {
  final CartItem cartItem;
  const CartList({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);// produtos recebidos pelo getter items
    final productList = Provider.of<ProductList>(context,listen: false);
        
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(cartItem.imgUrl),
          ),
          title: Text(cartItem.name),
          subtitle: Text(
              'Total: R\$ ${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  cart.removQuantity(cartItem.productId, cartItem.quantity);
                },
                icon: const Icon(Icons.remove),
              ),
              Text(cartItem.quantity.toString()),
              IconButton(
                onPressed: () {
                  productList.stockMax(cartItem.productId) > cartItem.quantity ? cart.addQuantity(cartItem.productId) : null;
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
      onDismissed: (_) {
        cart.removeItem(cartItem.productId);
      },
      confirmDismiss: (_) {
        return showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Tem Certeza'),
            content: const Text('Quer remover o item do carrinho?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: const Text('Não'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: const Text('Sim'),
              )
            ],
          ),
        );
      },
    );
  }
}
