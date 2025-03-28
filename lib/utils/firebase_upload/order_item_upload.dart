import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internal_assessment_app/order/orderItem/order_item_model.dart';

class OrderItemUpload {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadToFirebase(
      BuildContext context, bool isMounted, OrderItem orderItem) async {
    try {
      Map<String, dynamic> orderItemMap = orderItem.toMap();
      final uid = FirebaseAuth.instance.currentUser!.uid;

      await _firestore
          .collection('appUsers')
          .doc(uid)
          .collection('orderItems')
          .doc(orderItem.key)
          .set(orderItemMap);

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
