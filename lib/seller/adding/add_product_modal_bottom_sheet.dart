import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internal_assessment_app/product/data/product_model.dart';
import 'package:internal_assessment_app/seller/adding/firebase_upload/image_upload.dart';
import 'package:internal_assessment_app/seller/adding/firebase_upload/product_upload.dart';
import 'package:internal_assessment_app/seller/adding/image_item.dart';
import 'package:internal_assessment_app/seller/adding/image_selection.dart';
import 'package:internal_assessment_app/seller/adding/multi_select_dialog_category.dart';
import 'package:internal_assessment_app/seller/adding/multi_select_dialog_color.dart';

class AddProductModalBottomSheet extends StatefulWidget {
  const AddProductModalBottomSheet({super.key});

  @override
  State<AddProductModalBottomSheet> createState() =>
      _AddProductModalBottomSheetState();
}

class _AddProductModalBottomSheetState
    extends State<AddProductModalBottomSheet> {
  final GlobalKey<FormState> _formGlobalKey = GlobalKey<FormState>();
  bool _isPrivateLabelController = false;
  bool _isVisibleController = true;
  late List<Image> toBeUploadedImages;

  Product toBeAddedProduct = Product(
    images: [],
    manufacturerCode: '0',
    title: ProductTitle.komplet,
    availableColors: {},
    categories: {},
    incrementValue: 0,
    price: 0.0,
    isPrivateLabel: false,
    isVisible: true,
    dateAdded: DateTime.now(),
  );
  ProductTitle _selectedProductTitle = ProductTitle.komplet;
  Set<ProductColor> _selectedProductColors = {};
  Set<Category> _selectedCategories = {};

  void _showMultiSelectColor() async {
    final colorNames =
        ProductColor.values.map((color) => color.polishColorName).toList();

    final Set<ProductColor> results = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return MultiSelectDialogColor(
              title: 'Select Colors',
              items: ProductColor.values.toSet(),
              selectedItems: _selectedProductColors,
              itemNames: colorNames.toSet());
        });
    toBeAddedProduct.availableColors = results;
    _selectedProductColors = results;
  }

  void _showMultiSelectCategories() async {
    final categoryNames =
        Category.values.map((category) => category.polishCategory).toList();

    final Set<Category> results = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return MultiSelectDialogCategory(
              title: 'Select Categories',
              items: Category.values
                  .where((category) =>
                      category != Category.arrivals &&
                      category != Category.bestseller)
                  .toSet(),
              selectedItems: _selectedCategories,
              itemNames: categoryNames.toSet());
        });

        setState(() {
          toBeAddedProduct.categories = results;
          _selectedCategories = results;
        });
    
  }

  @override
  Widget build(BuildContext context) {
    late List<ImageItem> toBeUploadedImageItems;

    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Form(
              key: _formGlobalKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: const InputDecoration(
                        label: Text('Manufacturer Code'), hintText: '6436'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a code';
                      } else if (int.tryParse(value) == null) {
                        return 'The number is not an integer';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      toBeAddedProduct.manufacturerCode = value!;
                    },
                  ),
                  DropdownButtonFormField(
                    value: _selectedProductTitle,
                    decoration: const InputDecoration(
                        label: Text('Product title'), hintText: 'Komplet'),
                    items: ProductTitle.values.map((title) {
                      return DropdownMenuItem(
                        value: title,
                        child: Text(title.polishTitle),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(
                        () {
                          _selectedProductTitle = value!;
                        },
                      );
                    },
                    onSaved: (value) {
                      toBeAddedProduct.title = value!;
                    },
                  ),
                  ElevatedButton(
                      onPressed: _showMultiSelectColor,
                      child: const Text('Select colors')),
                  ElevatedButton(
                    onPressed: _showMultiSelectCategories,
                    child: const Text('Select categories'),
                  ),
                  ImageSelection(
                    onImagesSelected: (images) {
                      toBeUploadedImageItems = images;
                      toBeAddedProduct.images = images.map((imageItem) => imageItem.key).toList();
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    decoration: const InputDecoration(
                        label: Text('Increment value'), hintText: '4'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an increment value';
                      } else if (int.tryParse(value) == null) {
                        return 'Please enter an integer';
                      } else if (int.tryParse(value)! > 50) {
                        return 'The value is too big';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      toBeAddedProduct.incrementValue = int.parse(value!);
                    },
                  ),
                  TextFormField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    maxLength: 6,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}'))
                    ],
                    decoration: const InputDecoration(
                        suffixIcon: Text('zł'),
                        label: Text('Price'),
                        hintText: '32.99'),
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter a price';
                      } else if (double.tryParse(value) == null) {
                        return 'Please enter a 2 decimal place number';
                      } else if (double.tryParse(value)! > 500.00) {
                        return 'The value is too large';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      toBeAddedProduct.price = double.parse(value!);
                    },
                  ),
                  IntrinsicWidth(
                    child: Row(
                      children: [
                        const Text('Private Label'),
                        Switch.adaptive(
                          value: _isPrivateLabelController,
                          onChanged: (value) {
                            setState(() {
                              _isPrivateLabelController = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  IntrinsicWidth(
                    child: Row(
                      children: [
                        const Text('Visible to buyers'),
                        Switch.adaptive(
                          value: _isVisibleController,
                          onChanged: (value) {
                            setState(() {
                              _isVisibleController = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formGlobalKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                                'Validation successful, Processing data...'),
                          ),
                        );
                        _formGlobalKey.currentState?.save();
                        toBeAddedProduct.isPrivateLabel =
                            _isPrivateLabelController;
                        toBeAddedProduct.isVisible = _isVisibleController;
                        toBeAddedProduct.dateAdded = DateTime.now();
                        ProductUpload().uploadToFirebase(context, toBeAddedProduct, mounted);
                        ImageUpload().uploadToFirebase(context, toBeUploadedImageItems, mounted, toBeAddedProduct.key);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text('Please fix the errors'),
                          ),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
