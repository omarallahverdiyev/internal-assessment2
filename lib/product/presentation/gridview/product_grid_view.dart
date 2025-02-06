import 'package:flutter/material.dart';
import 'package:internal_assessment_app/product/data/product_model.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: ThemeData().copyWith().cardColor,
          ),
          child: Column(
            children: [
              Expanded(
                child: Image.network(product.images.first),
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
    );
  }
}
