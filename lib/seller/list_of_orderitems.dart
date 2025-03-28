import 'package:flutter/material.dart';
import 'package:internal_assessment_app/buyer/presentation/cart/cart_item.dart';
import 'package:internal_assessment_app/order/orderItem/order_item_model.dart';
import 'package:internal_assessment_app/order/order_model.dart';

class ListOfOrderitems extends StatelessWidget {
  const ListOfOrderitems({super.key, required this.order});

  final Order order;

  List<OrderItem> get items => order.items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(

      itemCount: items.length,
      itemBuilder: (context, index) {
        return CartItem(
          orderItem: items[index],
        );
      },
    );
  }
}
