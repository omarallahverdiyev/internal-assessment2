import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_provider.g.dart';

@riverpod
Future<List<String>> productImages(Ref ref, String productKey) async {
  final storage = FirebaseStorage.instance;
  final storageRef = storage.ref().child('images/$productKey');
  
  try {
    final ListResult result = await storageRef.listAll();
    final urls = await Future.wait(
      result.items.map((ref) => ref.getDownloadURL())
    );
    return urls;
  } catch (e) {
    throw Exception('Failed to fetch product images: $e');
  }
}