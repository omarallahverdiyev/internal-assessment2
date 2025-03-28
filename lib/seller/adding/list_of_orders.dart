import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internal_assessment_app/order/order_provider.dart';
import 'package:internal_assessment_app/seller/adding/order_list_view.dart';
import 'package:internal_assessment_app/utils/async_value_ui.dart';

class ListOfOrders extends ConsumerWidget {
  const ListOfOrders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncOrders = ref.watch(orderProvider);
    return asyncOrders.buildUI(
      dataBuilder: (data) => ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) => OrderListView(order: data[index]),
      ),
    );
  }
}
