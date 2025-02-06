import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internal_assessment_app/product/data/product_provider.dart';
import 'package:internal_assessment_app/product/presentation/gridview/grid_of_products.dart';
import 'package:internal_assessment_app/utils/async_value_ui.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var asyncProducts = ref.watch(productProvider);
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Stubbs Business'),
      ),
      body: asyncProducts.buildUI(dataBuilder: (data) => GridOfProducts(products: data))
    );
  }
}
