import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internal_assessment_app/buyer/user_orders_provider.dart';
import 'package:internal_assessment_app/seller/adding/order_list_view.dart';
import 'package:internal_assessment_app/utils/async_value_ui.dart';

class MyOrders extends ConsumerWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncOrders = ref.watch(userOrdersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: asyncOrders.buildUI(
        dataBuilder: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) => OrderListView(order: data[index]),
        ),
      ),
    );
  }
}
