import 'package:flutter/material.dart';
import 'package:internal_assessment_app/product/data/product_model.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final listTileTitle = "${product.polishTitle} ${product.manufacturerCode.toString()}"; 
    return Center(
      child: ListTile(
        leading: Image.network(product.images.first),
        title: Text(listTileTitle),
        subtitle: Text('${product.categories}'),
        trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios_rounded)),
      ),
    );
  }
}
