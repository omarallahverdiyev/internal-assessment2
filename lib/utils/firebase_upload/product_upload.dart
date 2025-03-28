import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internal_assessment_app/product/data/product_model.dart';

class ProductUpload {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadToFirebase(BuildContext context, Product toBeAddedProduct, bool isMounted) async {
    try {
      Map<String, dynamic> productMap = toBeAddedProduct.toMap();

      await _firestore.collection('products').doc(toBeAddedProduct.key).set(productMap);
      await _firestore.collection('counters').doc('products').update({'count': FieldValue.increment(1)});

      if (isMounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product uploaded successfully!')),
        );
      }
    } catch (e) {
      if (isMounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload product: $e')),
        );
      }
    }
  }
}