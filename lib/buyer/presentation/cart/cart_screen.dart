import 'package:flutter/material.dart';
import 'package:internal_assessment_app/buyer/domain/cart.dart';
import 'package:internal_assessment_app/buyer/presentation/cart/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.cart});

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stubbs business'),
      ),
      body: ListView.builder(
          itemCount: cart.items.length,
          itemBuilder: (context, index) => CartItem(
              orderItem: cart.items[index]) //the widget for order item),
          ),
    );
  }
}
