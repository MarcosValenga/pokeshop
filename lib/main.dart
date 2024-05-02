import 'package:flutter/material.dart';
import 'package:pokeshop/models/cart.dart';
import 'package:pokeshop/models/order_list.dart';
import 'package:pokeshop/models/product_list.dart';
import 'package:pokeshop/pages/product_view_page.dart';
import 'package:pokeshop/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  Myapp({super.key});
  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // MultiProvider para utilizaçao do provider em mais de uma ChangeNotifier
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList()),
      ],
      child: MaterialApp(
        title: 'PokeShop',
        theme: tema.copyWith( // Temas do app
          colorScheme: tema.colorScheme.copyWith( // Schemes de cores para definir em container, botoes, etc..
            primary: const Color.fromARGB(255, 201, 0, 60),
            secondary: const Color.fromARGB(255, 179, 178, 178),
            tertiary: Colors.blue
          ),
          textTheme: tema.textTheme.copyWith( // textTheme para customizaçao de fonte para uso no app
            titleLarge: const TextStyle(
              color: Colors.white,
              fontFamily: 'RobotoMono-Bold',
              fontSize: 30
            ),
            titleMedium: const TextStyle(
              color: Color.fromARGB(255, 0, 69, 148),
              fontFamily: 'RobotoMono-Regular',
              fontSize: 20,
            ),
            titleSmall: const TextStyle(
              color: Color.fromARGB(207, 221, 221, 221),
              fontFamily: 'RobotoMono-Light',
              fontSize: 12,
              fontWeight: FontWeight.w200,
            ),
          ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 216, 216, 216),
        ),

        home: const ProductViewPage(),

        routes: {
          // Definçoes de rotas na hierarquia
          AppRoutes.HOME:(context) => const ProductViewPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
