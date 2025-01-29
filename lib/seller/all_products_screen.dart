import 'package:flutter/material.dart';
import 'package:internal_assessment_app/product/data/dummy_product_data.dart';
import 'package:internal_assessment_app/product/presentation/listview/list_of_products.dart';
import 'package:internal_assessment_app/seller/adding/add_product_modal_bottom_sheet.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(onPressed: () => showModalBottomSheet(context: context, builder: (BuildContext context) { 
            return const AddProductModalBottomSheet();
          }), icon: const Icon(Icons.add))
        ],
      ),
      body: ListOfProducts(products: allProducts),
    );
  }
}
