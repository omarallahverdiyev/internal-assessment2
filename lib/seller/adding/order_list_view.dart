import 'package:flutter/material.dart';
import 'package:internal_assessment_app/order/order_model.dart';
import 'package:internal_assessment_app/seller/order_details_seller.dart';

class OrderListView extends StatelessWidget {
  const OrderListView({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(order.orderNumber.toString()),
      title: Text(order.deliveryStatus.polishDeliveryStatus),
      subtitle: Text(order.dateOfOrder.toString()),
      trailing: IconButton(icon: const Icon(Icons.chevron_right_rounded), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (build) => OrderDetails(order: order))),),
    );
  }
}
