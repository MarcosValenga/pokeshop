import 'package:flutter/material.dart';
import 'package:pokeshop/models/cart.dart';
import 'package:pokeshop/utils/app_routes.dart';
import 'package:pokeshop/widgets/badge.dart';
import 'package:provider/provider.dart';

class FloatButton extends StatelessWidget {
  const FloatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 66,
      height: 66,
      child: FloatingActionButton(
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 13, color: Colors.black),
          borderRadius: BorderRadius.circular(100),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(
            AppRoutes.HOME,
          );
        },
        child: Icon(
          Icons.catching_pokemon,
          size: 50,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Theme.of(context).colorScheme.primary,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            Consumer<Cart>(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.CART,
                  );
                },
                icon: const Icon(Icons.shopping_cart),
              ),
              builder: (ctx, cart, child) => Badgee(
                value: cart.itemsCountCart.toString(),
                child: child!,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.ORDER,
                );
              },
              icon: const Icon(Icons.shopping_bag),
            ),
          ],
        ),
      ),
    );
  }
}
