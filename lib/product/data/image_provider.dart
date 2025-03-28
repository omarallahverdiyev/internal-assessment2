import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_provider.g.dart';

@riverpod
Future<List<String>> productImages(Ref ref, String productKey) async {
  final storage = FirebaseStorage.instance;
  final storageRef = storage.ref().child('images/$productKey');
  const maxRetries = 3;
  const retryDelay = Duration(seconds: 2);

  for (int attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      final result = await storageRef.listAll();
      if (result.items.isEmpty) {
        if (attempt < maxRetries) {
          await Future.delayed(retryDelay);
          continue;
        }
        return [];
      }
      final urls = await Future.wait(result.items.map((ref) => ref.getDownloadURL(),),);
      print('These are the urls: $urls');
      return urls;
    } catch (e) {
      if (attempt == maxRetries) {
        throw Exception('Failed after $maxRetries attemots ${e.toString()}');
      }
      await Future.delayed(retryDelay);
    }
    return [];
  }
  
  // try {
  //   final ListResult result = await storageRef.listAll();
  //   final urls = await Future.wait(
  //     result.items.map((ref) => ref.getDownloadURL())
  //   );

    
  //   print('These are the urls: $urls');
  //   return urls;
  // } catch (e) {
  //   print('Failed to fetch product images: $e');
  //   throw Exception('Failed to fetch product images: $e');
    
  // }
  throw Exception('Unexpected error occurred');
}