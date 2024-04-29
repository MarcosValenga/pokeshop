import 'package:flutter/material.dart';
import 'package:pokeshop/widgets/nav_bar.dart';
import 'package:pokeshop/widgets/product_list_view.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductViewPage extends StatefulWidget {
  const ProductViewPage({super.key});

  @override
  State<ProductViewPage> createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // APPBAR
      appBar: AppBar(
        title: const Text('PokeShop'),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            iconSize: 40,
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text('Somente Favoritos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Todos'),
              )
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          )
        ],
      ),

      // CORPO DO APP
      body: ProductListView(_showFavoriteOnly),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatButton(),

      // NAVBAR
      bottomNavigationBar: const NavBar(),
    );
  }
}
