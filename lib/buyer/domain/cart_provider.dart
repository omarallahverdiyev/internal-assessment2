import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internal_assessment_app/order/orderItem/order_item_model.dart';

final cartProvider = FutureProvider<List<OrderItem>>(
  (ref) async {
    final db = FirebaseFirestore.instance;
    final uid = FirebaseAuth.instance.currentUser!.uid;
    var orderItemsRef =
        db.collection('appUsers').doc(uid).collection('orderItems');

    // Get all documents in the collection
    var snapshot = await orderItemsRef.get();

    // Convert each document to an OrderItem and create a list
    return Future.wait(snapshot.docs.map(
      (doc) async {
        return await OrderItem.fromMap(doc.data());
      },
    ).toList());
  },
);
