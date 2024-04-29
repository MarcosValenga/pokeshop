import 'package:flutter/material.dart';
import 'package:pokeshop/models/order_list.dart';
import 'package:pokeshop/widgets/order_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/nav_bar.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('PokeShop'),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: orders.itemsCountOrder,
        itemBuilder: (context, index) => OrderWidget(
          order: orders.items[index],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatButton(),
      bottomNavigationBar: const NavBar(),
    );
  }
}
