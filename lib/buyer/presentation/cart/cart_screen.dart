import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internal_assessment_app/buyer/domain/cart.dart';
import 'package:internal_assessment_app/buyer/presentation/cart/cart_item.dart';
import 'package:internal_assessment_app/order/orderItem/order_item_model.dart';
import 'package:internal_assessment_app/utils/async_value_ui.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.asyncOrderItems});

  final AsyncValue<List<OrderItem>> asyncOrderItems;

  @override
  Widget build(BuildContext context) {
    late List<OrderItem> orderItems;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stubbs business'),
      ),
      body: asyncOrderItems.buildUI(
        dataBuilder: (data) {
          orderItems = data;
          final cart = Cart(orderItems: orderItems);
          return Stack(children: [
            ListView.builder(
                itemCount: orderItems.length,
                itemBuilder: (context, index) => CartItem(
                    orderItem: orderItems[index]) //the widget for order item,
                ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                child: SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Text('Netto'),
                            const Spacer(flex: 1,),
                            Text(
                              NumberFormat.currency(symbol: '\$').format(cart.totalPrice),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Text('Brutto'),
                            Text(NumberFormat.currency(symbol: '\$').format(cart.totalPriceAfterTaxes)),
                            Text(cart.totalPriceAfterTaxes.toString())
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ]);
        },
      ),
    );
  }
}
