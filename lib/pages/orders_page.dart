import 'package:flutter/material.dart';
import 'package:pokeshop/models/order_list.dart';
import 'package:pokeshop/widgets/order_widget.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);

    return ListView.builder(
      itemCount: orders.itemsCountOrder,
      itemBuilder: (context, index) => OrderWidget(
        order: orders.items[index],
      ),
    );
  }
}
