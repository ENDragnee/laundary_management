import 'dart:convert';

class ClothingItem {
  String name;
  int quantity;

  ClothingItem({this.name = '', this.quantity = 1});

  Map<String, dynamic> toMap() {
    return {'name': name, 'quantity': quantity};
  }

  factory ClothingItem.fromMap(Map<String, dynamic> map) {
    return ClothingItem(
      name: map['name'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  static String encode(List<ClothingItem> items) => json.encode(
    items.map<Map<String, dynamic>>((item) => item.toMap()).toList(),
  );

  static List<ClothingItem> decode(String items) =>
      (json.decode(items) as List<dynamic>)
          .map<ClothingItem>((item) => ClothingItem.fromMap(item))
          .toList();
}
