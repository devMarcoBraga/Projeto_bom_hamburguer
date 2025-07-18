import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../providers/cart_provider.dart';
import 'package:bom_hamburguer_app/widget/item_tile.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    final List<Item> menuItems = [
      Item(name: "X Burger", price: 5.00, type: ItemType.sandwich),
      Item(name: "X Egg", price: 4.50, type: ItemType.sandwich),
      Item(name: "X Bacon", price: 7.00, type: ItemType.sandwich),
      Item(name: "Fries", price: 2.00, type: ItemType.extra),
      Item(name: "Soft Drink", price: 2.50, type: ItemType.drink),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bom Hamburguer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (cart.errorMessage != null)
            Container(
              color: Colors.redAccent,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child: Text(
                cart.errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return ItemTile(item: menuItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
