import 'package:internal_assessment_app/product/data/product_model.dart';

var allProducts = [
  Product(
    images: [
      'https://tuksik.pl/wp-content/uploads/2022/05/20220525_165315.jpg'
      'https://www.bellatine.pl/wp-content/uploads/20231128_125043-scaled.jpg'
    ],
    manufacturerCode: '1234',
    availableColors: {ProductColor.beige, ProductColor.black, ProductColor.blue},
    incrementValue: 5,
    price: 49.99,
    categories: {Category.arrivals, Category.bestseller},
    isVisible: true,
    title: ProductTitle.czapki,
    isPrivateLabel: false,
    dateAdded: DateTime.now()
  ),
];