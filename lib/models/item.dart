enum ItemType { sandwich, extra, drink }

class Item {
  final String name;
  final double price;
  final ItemType type;

  Item({required this.name, required this.price, required this.type});
}