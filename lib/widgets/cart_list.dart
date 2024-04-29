import 'package:flutter/material.dart';
import 'package:pokeshop/models/cart.dart';
import 'package:pokeshop/models/cart_item.dart';
import 'package:provider/provider.dart';

class CartList extends StatelessWidget {
  final CartItem cartItem;
  const CartList({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
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
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: FittedBox(
                child: Text('\$${cartItem.price.toStringAsFixed(2)}'), // aqui
              ),
            ),
          ),
          title: Text(cartItem.name),
          subtitle: Text(
              'Total: R\$ ${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
          trailing: Text('${cartItem.quantity}x'),
        ),
      ),
      onDismissed: (_) {
        Provider.of<Cart>(
          context,
          listen: false,
        ).removeItem(cartItem.productId);
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
