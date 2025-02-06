import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internal_assessment_app/product/data/product_model.dart';
import 'package:uuid/uuid.dart';

class OrderItem {
  final Product product;
  final ProductColor selectedColor;
  final int quantity;
  final double totalPrice;
  final String key = const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'productKey': product.key,
      'selectedColor': selectedColor.toString(),
      'quantity': quantity,
      'key': key,
    };
  }

  static Future<OrderItem> fromMap(Map<String, dynamic> map) async {
    Product? product = await productFinder(map['productKey'] ?? '');
    return OrderItem(
      product: product!,
      selectedColor: ProductColor.values.firstWhere(
        (e) => e.name == map['selectedColor'],
        orElse: () => ProductColor.other,
        //ideally put some proper report sent about such errors
      ),
      quantity: (map['quantity'] ?? 0).toInt(),
    );
  }

  static Future<Product?> productFinder(String productKey) async {
    var doc = await FirebaseFirestore.instance
        .collection('products')
        .doc(productKey)
        .get();
    if (!doc.exists) return null;
    return Product.fromMap(doc.data()!);
  }

  OrderItem({
    required this.product,
    required this.selectedColor,
    required this.quantity,
  }) : totalPrice = product.price * quantity;
}
