import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../providers/cart_provider.dart';

class ItemTile extends StatelessWidget {
  final Item item;

  const ItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(item.name),
        subtitle: Text('R\$ ${item.price.toStringAsFixed(2)}'),
        trailing: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            cart.addItem(item);
          },
        ),
      ),
    );
  }
}
