import 'package:flutter/material.dart';
import 'package:internal_assessment_app/product/data/dummy_product_data.dart';
import 'package:internal_assessment_app/product/data/product_model.dart';
import 'package:internal_assessment_app/product/presentation/gridview/grid_of_products.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories'),),
      body: Center(
        child: GridView.builder(
          itemCount: Category.values.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                onTap: () => _categoryProductMaker(context, Category.values.map((category) => category).toList()[index]),
                child: Center(
                  child: Text(
                    Category.values.map((category) => category.polishCategory).toList()[index],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _categoryProductMaker(context, Category lookingFor) {
    List<Product> foundProducts = [];
    for (var i = 0; i < allProducts.length; i++) {
      if (allProducts[i].categories.contains(lookingFor) == true) {
        foundProducts.add(allProducts[i]);
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(lookingFor.polishCategory),
            ),
            body: GridOfProducts(products: foundProducts),),
      ),
    );
  }
}
