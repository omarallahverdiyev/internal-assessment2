import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internal_assessment_app/buyer/domain/cart.dart';
import 'package:internal_assessment_app/buyer/domain/cart_provider.dart';
import 'package:internal_assessment_app/buyer/presentation/cart/cart_item.dart';
import 'package:internal_assessment_app/buyer/presentation/cart/checkout.dart';
import 'package:internal_assessment_app/utils/async_value_ui.dart';
import 'package:intl/intl.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncOrderItems = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stubbs business'),
      ),
      body: asyncOrderItems.buildUI(
        dataBuilder: (data) {
          final cart = Cart(orderItems: data);
          return Stack(children: [
            ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => CartItem(
                    orderItem: data[index]) //the widget for order item,
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
                            const Spacer(
                              flex: 1,
                            ),
                            Text(
                              NumberFormat.currency(symbol: '\$')
                                  .format(cart.totalPrice),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Text('Brutto'),
                            Text(
                              NumberFormat.currency(symbol: '\$')
                                  .format(cart.totalPriceAfterTaxes),
                            ),
                            Text(
                              cart.totalPriceAfterTaxes.toString(),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Checkout(cart: cart),
                                ),
                              );
                            },
                            child: const Icon(Icons.shopping_cart_checkout),
                          )
                        ],
                      )),
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
