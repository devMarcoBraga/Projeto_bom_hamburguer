import 'package:flutter/material.dart';
import '../models/item.dart';

class CartProvider with ChangeNotifier {
  final List<Item> _items = [];
  String? errorMessage;

  List<Item> get items => _items;
  double get total => _calculateTotal();

  void addItem(Item item) {
    if (_items.any((i) => i.type == item.type && i.name == item.name)) {
      errorMessage = "Você não pode adicionar dois itens iguais.";
      notifyListeners();
      return;
    }

    _items.add(item);
    errorMessage = null;
    notifyListeners();
  }

  double _calculateTotal() {
    double total = _items.fold(0, (sum, item) => sum + item.price);

    bool hasSandwich = _items.any((i) => i.type == ItemType.sandwich);
    bool hasFries = _items.any((i) => i.name.toLowerCase().contains('fries'));
    bool hasDrink = _items.any((i) => i.type == ItemType.drink);

    if (hasSandwich && hasFries && hasDrink) {
      total *= 0.8;
    } else if (hasSandwich && hasDrink) {
      total *= 0.85;
    } else if (hasSandwich && hasFries) {
      total *= 0.9;
    }

    return total;
  }
  
  void removeItem(Item item) {
  _items.remove(item);
  notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
