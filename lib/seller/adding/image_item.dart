import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ImageItem {
  final String key;
  final ImageProvider image;

  ImageItem({required this.image}) : key = const Uuid().v4();
}