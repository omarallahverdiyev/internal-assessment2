import 'package:flutter/material.dart';
import 'package:internal_assessment_app/product/data/dummy_product_data.dart';
import 'package:internal_assessment_app/product/presentation/gridview/grid_of_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Stubbs Business'),
      ),
      body: GridOfProducts(products: allProducts)
    );
  }
}
