import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI<T> on AsyncValue<T> {
  Widget buildUI({
    required Widget Function(T data) dataBuilder,
    Widget? loadingWidget,
    Widget Function(Object error)? errorBuilder,
  }) {
    return when(
      data: dataBuilder,
      loading: () => loadingWidget ?? const Center(child: CircularProgressIndicator()),
      error: (error, _) => errorBuilder != null 
        ? errorBuilder(error) 
        : Center(child: Text('Error: $error')),
    );
  }
}