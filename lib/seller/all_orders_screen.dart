import 'package:flutter/material.dart';
import 'package:internal_assessment_app/seller/adding/list_of_orders.dart';

class AllOrdersScreen extends StatelessWidget {
  const AllOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: AppBar(title: const Text('Orders'),),body: const ListOfOrders());

  }
}
