import 'package:pokeshop/models/product.dart';

final dummyProducts = [
  Product(
      id: '1',
      name: 'PokeBall',
      tipoItem: 'PokeBall',
      description: 'Uma Pokebola comun usada para capturar pokemons',
      price: 10.90,
      stock: 900,
      imgUrl: 'https://pngfre.com/wp-content/uploads/Pokeball-1.png'),
  Product(
      id: '2',
      name: 'Potion',
      tipoItem: 'Cura',
      description: 'Uma poção simples, restaura de PS(Pontos de Saúde) de seu pokemon',
      price: 5.50,
      stock: 500,
      imgUrl: 'https://ghostwalker186.wordpress.com/wp-content/uploads/2013/10/potion.png'),
  Product(
      id: '3',
      name: 'Choice Scarf',
      tipoItem: 'Equipamento',
      description: 'Quando segurado por um pokemon aumenta em 50% sua Velocidade',
      price: 100.90,
      stock: 2,
      imgUrl: 'https://www.serebii.net/itemdex/sprites/sv/choicescarf.png'),
  Product(
      id: '4',
      name: 'Tm 01',
      tipoItem: 'TM',
      description: 'Ensina o ataque Hone Claws',
      price: 34.90,
      stock: 5,
      imgUrl: 'https://static.wikia.nocookie.net/international-pokedex/images/1/10/TM_%28Normal-type%29.png'),
];
