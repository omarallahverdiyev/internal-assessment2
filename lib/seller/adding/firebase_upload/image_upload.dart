import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:internal_assessment_app/seller/adding/image_item.dart';

class ImageUpload {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> uploadToFirebase(
      BuildContext context,
      List<ImageItem> toBeUploadedImageItems,
      bool isMounted,
      String productKey) async {
    try {
      Reference productFolderRef = _storage.ref().child(productKey);

      for (ImageItem imageItem in toBeUploadedImageItems) {
        // Create a reference for the specific image in the product folder
        Reference imageRef = productFolderRef.child('${imageItem.key}.jpg');
        await imageRef.putFile(imageItem.image);
        
      }
      
    } catch (e) {
      if (isMounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload images: $e')),
        );
      }
    }
  }
}
