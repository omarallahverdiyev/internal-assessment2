import 'package:flutter/material.dart';
import 'package:internal_assessment_app/order/orderItem/order_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internal_assessment_app/product/data/image_provider.dart';
import 'package:internal_assessment_app/utils/async_value_ui.dart';

class CartItem extends ConsumerWidget {
  const CartItem({super.key, required this.orderItem});

  final OrderItem orderItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncImage = ref.watch(productImagesProvider(orderItem.product.key));
    return asyncImage.buildUI(
      dataBuilder: (data) => Dismissible(
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
                  child: data.isNotEmpty
              ? Image.network(data.first)
              : const Icon(Icons.image_not_supported),
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
                              backgroundColor:
                                  orderItem.selectedColor.exactColor),
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
      ),
    );
  }
}
