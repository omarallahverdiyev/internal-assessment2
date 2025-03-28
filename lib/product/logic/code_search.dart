// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:internal_assessment_app/product/data/product_model.dart';


// // Define the provider
// final productSearchProvider =
//   FutureProvider.family<List<Product>, String>((ref, manufacturerCode) async {
//   return await ProductSearchService().searchProductsByManufacturerCode(manufacturerCode);
// });

// class ProductSearchService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<List<Product>> searchProductsByManufacturerCode(String code) async {
//   try {
//     QuerySnapshot querySnapshot = await _firestore
//       .collection('products')
//       .where('manufacturerCode', isEqualTo: code)
//       .get();

//     return querySnapshot.docs
//       .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
//       .toList();

//   } catch (e) {
//     print('Error searching products: $e');
//     return [];
//   }
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internal_assessment_app/product/data/product_model.dart';

// Add a StateProvider to hold the search term

final searchTermProvider = StateProvider<String>((ref) => '');

// Modify the existing provider to watch the search term
final productSearchProvider = FutureProvider<List<Product>>((ref) async {
  final searchTerm = ref.watch(searchTermProvider);
  
  // If search term is empty, return an empty list
  if (searchTerm.isEmpty) {
    return [];
  }
  
  return await ProductSearchService().searchProductsByManufacturerCode(searchTerm);
});

class ProductSearchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Product>> searchProductsByManufacturerCode(String code) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('products')
          .where('manufacturerCode', isEqualTo: code)
          .get();

      return querySnapshot.docs
          .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

    } catch (e) {
      print('Error searching products: $e');
      return [];
    }
  }
}