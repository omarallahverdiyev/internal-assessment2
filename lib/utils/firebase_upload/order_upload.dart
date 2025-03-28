import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internal_assessment_app/order/order_model.dart' as order_model;

class OrderUpload {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadToFirebase(
      BuildContext context, bool isMounted, order_model.Order order, DateTime lastOrderDate) async {
    try {
      Map<String, dynamic> orderMap = order.toMap();
      final uid = FirebaseAuth.instance.currentUser!.uid;

      await _firestore.collection('orders').doc(order.key).set(orderMap);
      await _firestore.collection('appUsers').doc(uid).collection('orders').doc(order.key).set({
        'timeOfOrder': Timestamp.fromDate(order.dateOfOrder)
      });
      await _firestore.collection('appusers').doc(uid).set({
        'lastOrderDate': Timestamp.fromDate(lastOrderDate)
      });

      if (isMounted) {}
    } catch (e) {
      if (isMounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload product: $e')),
        );
      }
    }
  }
}
