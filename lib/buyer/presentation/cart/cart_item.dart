import 'package:flutter/material.dart';
import 'package:internal_assessment_app/order/orderItem/order_item_model.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.orderItem});

  final OrderItem orderItem;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(orderItem.key),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                child: Image.network(orderItem.product.images.first),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(orderItem.product.title.polishTitle),
                        Text(orderItem.product.manufacturerCode.toString())
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: orderItem.selectedColor.exactColor),
                        Text(orderItem.selectedColor.polishColorName)
                      ],
                    ),
                  ],
                ),
              ),
              const Flex(direction: Axis.horizontal),
              Column(
                children: [
                  Text(orderItem.totalPrice.toString()),
                  Text(
                    '${orderItem.product.price} zł x ${orderItem.quantity} szt.',
                    style: const TextStyle(
                      color: Color.fromARGB(170, 108, 99, 99),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
