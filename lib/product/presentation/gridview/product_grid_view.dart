import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internal_assessment_app/product/data/image_provider.dart';
import 'package:internal_assessment_app/product/data/product_model.dart';
import 'package:internal_assessment_app/product/presentation/productpage/product_modal_bottom_sheet.dart';
import 'package:internal_assessment_app/utils/async_value_ui.dart';

class ProductGridView extends ConsumerWidget {
  const ProductGridView({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncImages = ref.watch(productImagesProvider(product.key));
    return asyncImages.buildUI(
      dataBuilder: (data) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(
          onTap: () => showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return ProductModalBottomSheet(product: product);
            },
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: ThemeData().copyWith().cardColor,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Image.network(data.first),
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Text(product.polishTitle),
                      const Spacer(
                        flex: 1,
                      ),
                      Text(product.manufacturerCode),
                      const Spacer(
                        flex: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(product.price.toStringAsFixed(2)),
                      ),
                      const SizedBox(
                        height: 16,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
