import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final countProvider = StreamProvider<int>((ref) {
  return FirebaseFirestore.instance
      .collection('counters')
      .doc('products')
      .snapshots()
      .handleError((error) {
        print('Error: $error');
        // Consider adding error handling logic here
      })
      .map((snapshot) => snapshot.data()?['no'] ?? 0);
});