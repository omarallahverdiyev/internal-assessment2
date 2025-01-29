import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum ProductTitle {
  koszulka('Koszulka'),
  komplet('Komplet'),
  sukienka('Sukienka'),
  spiochy('Śpiochy'),
  koszula('Koszula'),
  spodnie('Spodnie'),
  szorty('Szorty'),
  skarpetki('Skarpetki'),
  pizamy('Piżamy'),
  koc('Koc'),
  czapki('Czapki'),
  body('Body'),
  zestaw('Zestaw'),
  pieluchy('Pieluchy'),
  inny('Inny');

  final String polishTitle;
  const ProductTitle(this.polishTitle);

  Map<String, String> toMap(ProductTitle productTitle) {
    return{
      'title': productTitle.polishTitle
    };
  }
}

enum ProductColor {
  navy('Granatowy', Color.fromARGB(255, 5, 44, 75)),
  pink('Różowy', Color.fromARGB(255, 200, 92, 128)),
  purple('Fioletowy', Color.fromARGB(255, 96, 6, 112)),
  green('Zielony', Color.fromARGB(255, 23, 175, 28)),
  olive('Oliwkowy', Color.fromARGB(255, 6, 48, 22)),
  orange('Pomarańczowy', Color.fromARGB(255, 175, 110, 12)),
  gray('Szary', Colors.grey),
  red('Czerwony', Colors.red),
  yellow('Żółty', Colors.yellow),
  beige('Beżowy', Color.fromARGB(255, 225, 194, 114)),
  blue('Niebieski', Colors.blue),
  dirtyPink('Brudny różowy', Color.fromARGB(255, 167, 47, 87)),
  lightPink('Jasny różowy', Color.fromARGB(255, 218, 66, 117)),
  black('Czarny', Colors.black),
  darkRed('Bordo', Color.fromARGB(255, 123, 19, 11)),
  brown('Brązowy', Colors.brown),
  white('Biały', Colors.white),
  multicolor('Wielekolorowy', Color.fromARGB(173, 255, 255, 255)),
  other('Inny', Color.fromARGB(149, 237, 237, 237));

  final String polishColorName;
  final Color exactColor;
  const ProductColor(this.polishColorName, this.exactColor);

  Map<String, dynamic> toMap (Set<ProductColor> availableColors) {
    return {
      'availableColors': availableColors.map((color) => color.polishColorName).toList()
    };
  }
}

enum Category {
  arrivals('Nowość'),
  boys('Chłopiec'),
  girls('Dziewczynka'),
  tshirts('Koszulka'),
  infant('Niemowlak'),
  sets('Komplet'),
  elegant('Elegancki'),
  dresses('Sukienka'),
  bestseller('Bestseller'),
  pants('Spodnie'),
  shorts('Szorty'),
  hoodie('Bluza');

  final String polishCategory;
  const Category(this.polishCategory);

    Map<String, dynamic> toMap (Set<Category> categories) {
    return {
      'categoriesActivated': categories.map((c) => c.polishCategory).toList()
    };
  }
}

class Product {
  Product(
      {required this.images,
      required this.manufacturerCode,
      required this.availableColors,
      required this.incrementValue,
      required this.price,
      required this.categories,
      required this.isVisible,
      required this.title,
      required this.isPrivateLabel,
      required this.dateAdded,
      this.totalSales = 0})
      : dateUpdated = dateAdded;
  String key = const Uuid().v4();
  List<String> images; //fire
  String manufacturerCode;
  Set<ProductColor> availableColors;
  int incrementValue;
  double price;
  Set<Category> categories;
  bool isVisible;
  ProductTitle title;
  bool isPrivateLabel;
  DateTime dateAdded;
  DateTime dateUpdated;
  int totalSales;

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'images': images,
      'manufacturerCode': manufacturerCode,
      'availableColors': availableColors.map((color) => color.toMap(availableColors)).toList(),
      'incrementValue': incrementValue,
      'price': price,
      'categories': categories.map((category) => category.toMap(categories)).toList(),
      'isVisible': isVisible,
      'title': title.toMap(title),
      'isPrivateLabel': isPrivateLabel,
      'dateAdded': dateAdded.toIso8601String(),
      'dateUpdated': dateUpdated.toIso8601String(),
      'totalSales': totalSales,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        images: List<String>.from(map['images']),
        manufacturerCode: map['manufacturerCode'] as String,
        availableColors: (map['availableColors'] as List).map((color) {
          return ProductColor.values.firstWhere(
            (e) => e.name == color,
            orElse: () => ProductColor.other,
            //ideally put some proper report sent about such errors
          );
        }).toSet(),
        incrementValue: map['incrementValue'] as int,
        price: (map['price'] as num).toDouble(),
        categories: (map['categories'] as List).map((category) {
          return Category.values.firstWhere((e) => e.name == category,
              orElse: () => Category.arrivals
              //proper error handling necessary
              );
        }).toSet(),
        isVisible: map['isVisible'] as bool,
        title: ProductTitle.values.firstWhere((e) => e.name == map['title'],
            orElse: () => ProductTitle.inny),
        isPrivateLabel: map['isPrivateLabel'] as bool,
        dateAdded: (map['dateAdded'] as Timestamp).toDate(),
        totalSales: map['totalSales'] as int? ?? 0);
  }

  String get polishTitle => title.polishTitle;
}
