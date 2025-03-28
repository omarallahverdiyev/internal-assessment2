import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internal_assessment_app/product/data/product_provider.dart';
import 'package:internal_assessment_app/product/logic/code_search.dart';
import 'package:internal_assessment_app/product/presentation/gridview/grid_of_products.dart';
import 'package:internal_assessment_app/utils/async_value_ui.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { 
    final asyncSearchResults = ref.watch(productSearchProvider);
    final asyncProducts = ref.watch(productProvider);
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              leading: const Icon(Icons.search),
              hintText: 'Search products...',
              onChanged: (value) {
                if (value.isNotEmpty) {
                  ref.read(searchTermProvider.notifier).state = value;
                }
              },
            ),
          ),
        ),
        title: const Text('Stubbs Business'),
      ),
      body: asyncSearchResults.when(
        data: (results) => results.isEmpty
            ? asyncProducts.buildUI(
                dataBuilder: (data) => GridOfProducts(products: data))
            : GridOfProducts(products: results),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
      ),
    );
  }
}
