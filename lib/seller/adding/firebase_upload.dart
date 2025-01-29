import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internal_assessment_app/product/data/product_model.dart';

class FirebaseUpload {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadToFirebase(BuildContext context, Product toBeAddedProduct, bool mounted) async {
    try {
      Map<String, dynamic> productMap = toBeAddedProduct.toMap();
      await _firestore.collection('products').add(productMap);
    } catch (e) {
      if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload product: $e')),
      );
      }

    }
  }
}