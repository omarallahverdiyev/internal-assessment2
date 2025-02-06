import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internal_assessment_app/product/data/count_provider.dart';
import 'package:internal_assessment_app/product/data/product_model.dart';
import 'package:internal_assessment_app/product/data/product_provider.dart';
import 'package:internal_assessment_app/product/presentation/gridview/grid_of_products.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProducts = ref.watch(productProvider);
    final asyncNumberOfProducts = ref.watch(countProvider);

    // asyncNumberOfProducts.when(
    //   data: (data) => numberOfProducts = data,
    //   loading: () => const Center(
    //     child: CircularProgressIndicator(),
    //   ),
    //   error: (error, stackTrace) => print(error),
    // );
    // asyncProducts.when(
    //   data: (data) => products = data,
    //   error: (error, stackTrace) => ErrorWidget(error),
    //   loading: () => const Center(
    //     child: CircularProgressIndicator(),
    //   ),);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Center(
        child: GridView.builder(
          itemCount: Category.values.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                onTap: () => _categoryProductMaker(
                    context,
                    Category.values.map((category) => category).toList()[index],
                    asyncProducts,
                    asyncNumberOfProducts),
                child: Center(
                  child: Text(
                    Category.values
                        .map((category) => category.polishCategory)
                        .toList()[index],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

//   Future<void> _categoryProductMaker(context, Category lookingFor,
//       asyncProducts, asyncNumberOfProducts) async {
//     late List<Product> products;
//     late int numberOfProducts;
//     late List<Product> foundProducts = [];
//     asyncNumberOfProducts.when(
//       data: (data) {
//         numberOfProducts = data;
//         asyncProducts.when(
//           data: (productData) {
//             products = productData;
//             // Perform your product filtering here
//             for (var i = 0; i < numberOfProducts; i++) {
//               if (products[i].categories.contains(lookingFor)) {
//                 foundProducts.add(products[i]);
//               }
//             }
//           },
//           error: (error, stackTrace) => print('Products error: $error'),
//           loading: () => const Center(child: CircularProgressIndicator()),
//         );
//       },
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (error, stackTrace) => print('Number of products error: $error'),
//     );

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => Scaffold(
//           appBar: AppBar(
//             title: Text(lookingFor.polishCategory),
//           ),
//           body: GridOfProducts(products: foundProducts),
//         ),
//       ),
//     );
//   }

Future<void> _categoryProductMaker(
    BuildContext context,
    Category lookingFor,
    AsyncValue<List<Product>> asyncProducts,
    AsyncValue<int> asyncNumberOfProducts) async {
    
    // First, ensure both values are loaded
    if (asyncProducts is AsyncData && asyncNumberOfProducts is AsyncData) {
        final products = asyncProducts.value;
        final numberOfProducts = asyncNumberOfProducts.value;
        
        final foundProducts = <Product>[];
        
        // Perform filtering
        for (var i = 0; i < numberOfProducts!; i++) {
            if (products![i].categories.contains(lookingFor)) {
                foundProducts.add(products[i]);
            }
        }
        
        // Navigate to new screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Scaffold(
                    appBar: AppBar(
                        title: Text(lookingFor.polishCategory),
                    ),
                    body: GridOfProducts(products: foundProducts),
                ),
            ),
        );
    } else if (asyncProducts is AsyncError || asyncNumberOfProducts is AsyncError) {
        // Handle error case
        print('Error loading data');
    }
}
}
