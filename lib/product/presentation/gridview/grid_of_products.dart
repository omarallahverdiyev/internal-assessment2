import 'package:flutter/material.dart';
import 'package:internal_assessment_app/product/data/product_model.dart';
import 'package:internal_assessment_app/product/presentation/gridview/product_grid_view.dart';

class GridOfProducts extends StatelessWidget {
  const GridOfProducts({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemBuilder: (context, index) {
          return ProductGridView(product: products[index]);
        },
      );
  }
}