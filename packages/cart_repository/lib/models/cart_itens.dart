class CartItem {
  final String id;
  final String name;
  final int quantity;

  CartItem({required this.id, required this.name, required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
    };
  }

  static CartItem fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
    );
  }
}