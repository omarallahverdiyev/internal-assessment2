import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'order_model.dart' as buyerOrder;

final orderProvider = FutureProvider<List<buyerOrder.Order>>((ref) async {
  final firestore = FirebaseFirestore.instance;
  final collection = firestore.collection('orders');
  final snapshot = await collection.get();

  // return collection.get().then((snapshot) {
  //   return snapshot.docs.map((doc) {
  //     final data = doc.data();
  //     return buyerOrder.Order.fromMap(data);
  //   }).toList();
  // });
  final orders = <buyerOrder.Order>[];
  for (final doc in snapshot.docs) {
    final order = await buyerOrder.Order.fromMap(doc.data());
    orders.add(order);
  }
  return orders;
});