import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internal_assessment_app/order/orderItem/order_item_model.dart';
import 'package:internal_assessment_app/product/data/image_provider.dart';
import 'package:internal_assessment_app/product/data/product_model.dart';
import 'package:internal_assessment_app/product/presentation/productpage/incrementer.dart';
import 'package:internal_assessment_app/utils/async_value_ui.dart';
import 'package:internal_assessment_app/utils/firebase_upload/order_item_upload.dart';

class ProductModalBottomSheet extends ConsumerStatefulWidget {
  const ProductModalBottomSheet({super.key, required this.product});

  final Product product;

  @override
  ConsumerState<ProductModalBottomSheet> createState() =>
      _ProductModalBottomSheetState();
}

class _ProductModalBottomSheetState
    extends ConsumerState<ProductModalBottomSheet> {
  late Map<ProductColor, int> quantities;
  @override
  void initState() {
    super.initState();
    quantities = widget.product.availableColors
        .toList()
        .asMap()
        .map((_, color) => MapEntry(color, 0));
  }

  @override
  Widget build(BuildContext context) {
    final colorsAsList = widget.product.availableColors.toList();
    final asyncImages = ref.watch(productImagesProvider(widget.product.key));
    return asyncImages.buildUI(
      dataBuilder: (data) {
        return LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                data.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 500,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (final image in data)
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Image.network(image),
                                ),
                            ],
                          ),
                        ),
                      )
                    : const Icon(Icons.image_not_supported),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Text(widget.product.title.polishTitle),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(widget.product.manufacturerCode),
                      const Spacer(),
                      Text(widget.product.price.toString())
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: colorsAsList.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: Icon(
                        Icons.circle_outlined,
                        color: colorsAsList[index].exactColor,
                      ),
                      title: Text(colorsAsList[index].polishColorName),
                      trailing: CounterWidget(
                        increment: widget.product.incrementValue,
                        onValueChanged: (value) {
                          quantities[colorsAsList[index]] = value;
                        },
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      for (int i = 0; i < colorsAsList.length; i++) {
                        if (quantities[colorsAsList[i]] == 0) {
                          continue;
                        }
                        final orderItem = OrderItem(
                            product: widget.product,
                            selectedColor: colorsAsList[i],
                            quantity: quantities[colorsAsList[i]]!);
                        OrderItemUpload()
                            .uploadToFirebase(context, mounted, orderItem);
                      }
                    },
                    child: const Icon(Icons.add_shopping_cart))
              ],
            ),
          );
        });
      },
    );
  }
}
