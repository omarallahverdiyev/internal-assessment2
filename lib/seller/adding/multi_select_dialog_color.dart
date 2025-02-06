import 'package:flutter/material.dart';
import 'package:internal_assessment_app/product/data/product_model.dart';

class MultiSelectDialogColor extends StatefulWidget {
  const MultiSelectDialogColor(
      {super.key,
      required this.title,
      required this.items,
      required this.selectedItems,
      required this.itemNames});

  final String title;
  final Set<ProductColor> items;
  final Set<ProductColor> selectedItems;
  final Set<String> itemNames;

  @override
  State<MultiSelectDialogColor> createState() => _MultiSelectDialogColorState();
}

class _MultiSelectDialogColorState extends State<MultiSelectDialogColor> {
  late Set<ProductColor> tempSelectedItems;

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
