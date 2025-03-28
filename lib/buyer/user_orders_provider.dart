import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../order/order_model.dart' as buyerOrder;

final userOrdersProvider = StreamProvider<List<buyerOrder.Order>>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return Stream.value([]);

  //The point of this code is to find the orders of a given user. In order to do this it accesses the orders collection under appUsers collection, where each document has the name of an order key. After collecting the ids, it goes to a combined list of orders and fetches the orders with mathing ids.

  return FirebaseFirestore.instance
      .collection('appUsers')
      .doc(user.uid)
      .collection('orders')
      .snapshots()
      .asyncMap((userOrdersSnapshot) async {
    // Get all order IDs from user's orders subcollection
    final orderIds = userOrdersSnapshot.docs.map((doc) => doc.id).toList();

    if (orderIds.isEmpty) return [];

    // Fetch the actual orders from the main orders collection
    final ordersQuery = await FirebaseFirestore.instance
        .collection('orders')
        .where(FieldPath.documentId, whereIn: orderIds)
        .get();

    final orders = await Future.wait(
      ordersQuery.docs.map((doc) => buyerOrder.Order.fromMap(doc.data())).toList()
    );

    return orders;
  });
});