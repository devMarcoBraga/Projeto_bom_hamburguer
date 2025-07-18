import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bom_hamburguer_app/widget/cart_summary.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('🛒 Revisar Pedido'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome do Cliente',
                hintText: 'Digite seu nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: cart.items.isEmpty
                  ? const Center(child: Text('Carrinho vazio.'))
                  : ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        final item = cart.items[index];
                        return ListTile(
                          title: Text(item.name),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('R\$ ${item.price.toStringAsFixed(2)}'),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  cart.removeItem(item);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${item.name} removido do carrinho'),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            const CartSummary(),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final name = _nameController.text.trim();

                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Digite seu nome antes de confirmar.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (cart.items.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Adicione itens ao carrinho.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Pedido confirmado para $name!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    cart.clearCart();
                    _nameController.clear();
                  }
                },
                child: const Text('Confirmar Pedido'),
              ),
            ),

            const SizedBox(height: 8),

            TextButton(
              onPressed: () {
                cart.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Carrinho limpo!'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
              child: const Text('Limpar Carrinho'),
            ),
          ],
        ),
      ),
    );
  }
}
