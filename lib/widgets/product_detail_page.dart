import 'package:flutter/material.dart';
import 'package:pokeshop/models/cart.dart';
import 'package:pokeshop/models/product.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage(this.product, {super.key});
  final Product product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(27), topRight: Radius.circular(27)),
          child: Container(
            color: const Color.fromARGB(255, 67, 105, 141),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildFavoriteIcon(),
                _buildProductInfo(),
                _buildProductImage(),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              _buildPurchaseArea(),
              _buildDescriptionArea(),
            ],
          ),
        )
      ],
    );
  }

  // Favorite Icon
  Widget _buildFavoriteIcon() {
    return Flexible(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                widget.product.toggleFavorite();
              });
            },
            icon: Icon(
              size: 30,
              widget.product.isFavorite ? Icons.star : Icons.star_border,
            ),
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }

  // Product Title info
  Widget _buildProductInfo() {
    return Flexible(
      flex: 4,
      fit: FlexFit.tight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.product.name,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            widget.product.tipoItem,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }

  // Product image
  Widget _buildProductImage() {
    return Flexible(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(widget.product.imgUrl),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Área de compra
  Widget _buildPurchaseArea() {
    final Cart cart = Provider.of<Cart>(context);
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Center(
                child: Card(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(
                    vertical: 7,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(widget.product.imgUrl),
                    ),
                    title: Text(
                      widget.product.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      "PokeDollar\n\$${widget.product.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.black, blurRadius: 5)
                        ],
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 85, 178, 255),
                      ),
                      child: IconButton(
                        enableFeedback: true,
                        icon: const Icon(
                          Icons.shopping_cart_checkout,
                          size: 30,
                          color: Colors.black,
                        ),
                        onPressed: widget.product.stock == 0
                            ? () {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 1),
                                    elevation: 5,
                                    content:
                                        Text('Item Esgotado'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            : () {
                                cart.addItem(widget.product);
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 1),
                                    elevation: 5,
                                    content:
                                        Text('Item Adicionado ao carrinho'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Área de descriçao
  Widget _buildDescriptionArea() {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 221, 221),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.all(15),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'DESCRIÇÃO DO JOGO',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.product.description,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
