import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/cart_itens.dart';


class CartRepository {
  final CollectionReference cartCollection = FirebaseFirestore.instance.collection('cart');

  Future<void> addItemToCart(CartItem item) {
    return cartCollection.add(item.toMap()); // Supondo que CartItem tem um método toMap
  }

  Future<void> removeItemFromCart(CartItem item) {
    return cartCollection.doc(item.id).delete(); // Supondo que CartItem tem um campo id
  }

  Stream<List<CartItem>> getCart() {
    return cartCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => CartItem.fromMap(doc.data())).toList(); // Supondo que CartItem tem um método fromMap
    });
  }
}