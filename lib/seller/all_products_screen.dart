import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internal_assessment_app/product/data/product_provider.dart';
import 'package:internal_assessment_app/product/presentation/listview/list_of_products.dart';
import 'package:internal_assessment_app/seller/adding/add_product_modal_bottom_sheet.dart';

class AllProductsScreen extends ConsumerStatefulWidget {
  const AllProductsScreen({super.key});

  @override
  ConsumerState<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends ConsumerState<AllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final productStream = ref.watch(productProvider);

    return productStream.when(
        data: (products) => Scaffold(
              appBar: AppBar(
                title: const Text('Products'),
                actions: [
                  IconButton(
                      onPressed: () => showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return const AddProductModalBottomSheet();
                            },
                          ),
                      icon: const Icon(Icons.add))
                ],
              ),
              body: ListOfProducts(products: products),
            ),
        loading: () => const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        error: (error, stackTrace) => Scaffold(
              body: Center(
                child: Text('Error: $error'),
              ),
            ));
  }
}
