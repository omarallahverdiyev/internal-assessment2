import 'package:flutter/material.dart';
import 'package:internal_assessment_app/product/data/product_model.dart';
import 'package:internal_assessment_app/product/presentation/listview/product_list_view.dart';

class ListOfProducts extends StatelessWidget {
  const ListOfProducts({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductListView(product: products[index]);
        }
      ),
    );
  }
}