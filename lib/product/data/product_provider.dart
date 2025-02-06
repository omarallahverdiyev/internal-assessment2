import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_model.dart';

final productProvider = StreamProvider<List<Product>>((ref) {
  final firestore = FirebaseFirestore.instance;
  final collection = firestore.collection('products'); // Replace 'products' with your collection name

  return collection.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Product.fromMap(data);
    }).toList();
  });
});