import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internal_assessment_app/product/data/product_model.dart';
import 'package:internal_assessment_app/utils/async_value_ui.dart';
import 'package:internal_assessment_app/product/data/image_provider.dart'; // Add this line to import the imageProvider method

class ProductListView extends ConsumerWidget {
  const ProductListView({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncImages = ref.watch(productImagesProvider(product.key));
    final listTileTitle =
        "${product.polishTitle} ${product.manufacturerCode.toString()}";
    return asyncImages.buildUI(
      dataBuilder: (data) {
        return Center(
          child: ListTile(
            leading: data.isNotEmpty
              ? Image.network(data.first)
              : const Icon(Icons.image_not_supported),
            title: Text(listTileTitle),
            subtitle: Text(
              product.categories
                  .map((category) => category.polishCategory)
                  .join(', '),
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios_rounded)),
          ),
        );
      },
      loadingWidget: Center(
        child: ListTile(
          leading: const CircularProgressIndicator(),
          title: Text(listTileTitle),
          subtitle: Text(
            product.categories
                .map((category) => category.polishCategory)
                .join(', '),
          ),
          trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios_rounded)),
        ),
      ),
    );
  }
}
