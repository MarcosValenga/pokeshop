import 'package:flutter/material.dart';
import 'package:pokeshop/models/cart.dart';
import 'package:pokeshop/models/cart_item.dart';
import 'package:pokeshop/models/order_list.dart';
import 'package:pokeshop/models/product_list.dart';
import 'package:pokeshop/widgets/cart_list.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void buyProducts(BuildContext context, List<CartItem> cartItems){
    final productList = Provider.of<ProductList>(context, listen: false);
    for (var cartItem in cartItems){
      productList.stockManager(cartItem.productId, cartItem.quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 6,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Chip(
                  backgroundColor: const Color.fromARGB(255, 85, 178, 255),
                  label: Text(
                    'P\$${cart.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Provider.of<OrderList>(context, listen: false).addOrder(cart);
                    buyProducts(context, items);
                    cart.clear();
                  },
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(color: Colors.blue),
                  ),
                  child: const Text('COMPRAR'),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => CartList(cartItem: items[index]),
          ),
        ),
      ],
    );
  }
}
