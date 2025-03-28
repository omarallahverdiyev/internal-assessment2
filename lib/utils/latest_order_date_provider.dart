// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final latestOrderDateProvider = FutureProvider<DateTime?>((ref) async {
//   try {
//     // Get reference to the orders collection for the specific user
//     final uid = FirebaseAuth.instance.currentUser?.uid;
//     if (uid == null) return null;

//     final ordersQuery = FirebaseFirestore.instance
//         .collection('appUser')
//         .doc(uid)
//         .collection('orders')
//         .orderBy('timeOfOrder', descending: true)
//         .limit(1);

//     // Get the latest order
//     final querySnapshot = await ordersQuery.get();

//     // If no orders exist, return null
//     if (querySnapshot.docs.isEmpty) {
//       return null;
//     }

//     // Extract the timeOfOrder from the latest order
//     final latestOrder = querySnapshot.docs.first.data();
//     final timestamp = latestOrder['timeOfOrder'] as Timestamp;
    
//     return timestamp.toDate();
//   } catch (e) {
//     print('Error fetching latest order date: $e');
//     return null;
//   }
// });