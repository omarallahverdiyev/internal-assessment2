import 'dart:io';
import 'package:uuid/uuid.dart';

class ImageItem {
  final String key;
  final File image;

  ImageItem({required this.image}) : key = const Uuid().v4();
}