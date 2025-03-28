import 'package:flutter/material.dart';

class SelectionButtons extends StatefulWidget {
  final void Function(int) onIndexChanged;
  final int initialIndex;

  const SelectionButtons({
    Key? key,
    required this.onIndexChanged,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  _SelectionButtonsState createState() => _SelectionButtonsState();
}

class _SelectionButtonsState extends State<SelectionButtons> {
  late List<bool> _selections;

  @override
  void initState() {
    super.initState();
    // Initialize selections based on initialIndex
    _selections = List.generate(4, (index) => index == widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ToggleButtons(
        direction: Axis.horizontal,
        onPressed: (int index) {
          setState(() {
            // Only update if a different button is pressed
            if (!_selections[index]) {
              // First, set all selections to false
              for (int i = 0; i < _selections.length; i++) {
                _selections[i] = i == index;
              }
              // Notify parent widget about the change
              widget.onIndexChanged(index);
            }
          });
        },
        selectedBorderColor: Colors.blue[700],
        selectedColor: Colors.white,
        fillColor: Colors.blue[200],
        color: Colors.blue[400],
        constraints: const BoxConstraints(
          minHeight: 40.0,
          minWidth: 80.0,
        ),
        isSelected: _selections,
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Option 1'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Option 2'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Option 3'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Option 4'),
          ),
        ],
      ),
    );
  }
}