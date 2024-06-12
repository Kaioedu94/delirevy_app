import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/cart_itens.dart';

class CartRepository {
  final CollectionReference cartCollection = FirebaseFirestore.instance.collection('cart');

  Future<void> addItemToCart(CartItem item) {
    return cartCollection.add(item.toMap());
  }

  Future<void> removeItemFromCart(CartItem item) {
    return cartCollection.doc(item.id).delete();
  }

  Stream<List<CartItem>> getCart() {
    return cartCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CartItem.fromMap(data);
      }).toList();
    });
  }
}
