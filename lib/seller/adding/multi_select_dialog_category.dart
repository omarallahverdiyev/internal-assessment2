import 'package:flutter/material.dart';
import 'package:internal_assessment_app/product/data/product_model.dart';

class MultiSelectDialogCategory extends StatefulWidget {
  const MultiSelectDialogCategory(
      {super.key,
      required this.title,
      required this.items,
      required this.selectedItems,
      required this.itemNames});

  final String title;
  final Set<Category> items;
  final Set<Category> selectedItems;
  final Set<String> itemNames;

  @override
  State<MultiSelectDialogCategory> createState() => _MultiSelectDialogCategoryState();
}

class _MultiSelectDialogCategoryState extends State<MultiSelectDialogCategory> {
  late Set<Category> tempSelectedItems;

  @override
  void initState() {
    super.initState();
    tempSelectedItems = Set.from(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map(
            (item) {
              return CheckboxListTile.adaptive(
                title: Text(
                  widget.itemNames.elementAt(
                    widget.items.toList().indexOf(item),
                  ),
                ),
                value: tempSelectedItems.contains(item),
                onChanged: (bool? selected) {
                  setState(
                    () {
                      if (selected == true) {
                        tempSelectedItems.add(item);
                      } else {
                        tempSelectedItems.remove(item);
                      }
                    },
                  );
                },
              );
            },
          ).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, tempSelectedItems),
          child: const Text('Submit'),
        )
      ],
    );
  }
}
