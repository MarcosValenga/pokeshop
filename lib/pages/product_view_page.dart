import 'package:flutter/material.dart';
import 'package:pokeshop/models/cart.dart';
import 'package:pokeshop/models/product_list.dart';
import 'package:pokeshop/pages/cart_page.dart';
import 'package:pokeshop/pages/orders_page.dart';
import 'package:pokeshop/widgets/product_list_view.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

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
  int _currentIndex = 2;
  List<Widget> body = [
    const Icon(Icons.search),
    const Icon(Icons.edit),
    const ProductListView(),
    const CartPage(),
    const OrdersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final ProductList provider = Provider.of<ProductList>(context);
    final Cart providerCart = Provider.of<Cart>(context);
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
              if (selectedValue == FilterOptions.favorite) {
                provider.showFavoriteOnly();
              } else {
                provider.showAll();
              }
            },
          )
        ],
      ),

      // CORPO DO APP
      body: Center(child: body[_currentIndex]),

      // NAVBAR
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: [
          const BottomNavigationBarItem(
            label: 'Editar',
            icon: Icon(
              Icons.edit,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          const BottomNavigationBarItem(
            label: 'Pesquisar',
            icon: Icon(Icons.search, color: Color.fromARGB(255, 0, 0, 0)),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                    width: 3, color: Color.fromARGB(255, 0, 0, 0)),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.catching_pokemon,
                color: Color.fromARGB(255, 255, 0, 0),
                size: 60,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Carrinho',
            icon: Column(
              children: [
                badges.Badge(
                  showBadge: providerCart.itemsCountCart == 0 ? false : true,
                  position: badges.BadgePosition.topEnd(top: -8, end: -6),
                  badgeContent: Consumer<Cart>(
                    builder: (context, cart, _) => Text(
                      cart.itemsCountCart.toString(),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 10,
                      ),
                    ),
                  ),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),
          const BottomNavigationBarItem(
            label: 'Pedidos',
            icon: Icon(
              Icons.shopping_bag,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
    );
  }
}
