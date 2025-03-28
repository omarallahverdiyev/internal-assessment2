import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  final int increment;
  final ValueChanged<int>? onValueChanged;
  
  const CounterWidget({
    Key? key,
    this.increment = 1,
    this.onValueChanged,
  }) : super(key: key);

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _value = 0;

  void _incrementValue() {
    setState(() {
      _value += widget.increment;
      widget.onValueChanged?.call(_value);
    });
  }

  void _decrementValue() {
    if (_value >= widget.increment) {
      setState(() {
        _value -= widget.increment;
        widget.onValueChanged?.call(_value);
      });
    }
  }

  int valueGetter() {
    return _value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: _value >= widget.increment ? _decrementValue : null,
          constraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
          padding: EdgeInsets.zero,
        ),
        SizedBox(
          width: 50,
          child: Text(
            _value.toStringAsFixed(widget.increment.truncateToDouble() == widget.increment ? 0 : 1),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _incrementValue,
          constraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}