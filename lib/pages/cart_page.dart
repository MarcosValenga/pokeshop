import 'package:flutter/material.dart';
import 'package:pokeshop/models/cart.dart';
import 'package:pokeshop/models/order_list.dart';
import 'package:pokeshop/widgets/cart_list.dart';
import 'package:pokeshop/widgets/nav_bar.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('PokeShop'),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
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
                      Provider.of<OrderList>(context, listen: false)
                          .addOrder(cart);
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatButton(),

      // NAVBAR
      bottomNavigationBar: const NavBar(),
    );
  }
}
