// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:internal_assessment_app/order/orderItem/order_item_model.dart';


// final cartProvider = Provider((ref) {

//   Future<List<OrderItem>> getOrderItems() async {
//   // Get the collection reference you showed
//   var orderItemsRef = db.collection('appUsers').doc(uid).collection('orderItems');
  
//   // Get all documents in the collection
//   var snapshot = await orderItemsRef.get();
  
//   // Convert each document to an OrderItem and create a list
//   return snapshot.docs.map((doc) {
//     // Assuming you have a factory constructor or fromMap method in OrderItem
//     return OrderItem.fromMap(doc.data());
//   }).toList();
// }
  
//   final db = FirebaseFirestore.instance;

//   String uid = FirebaseAuth.instance.currentUser?.uid ?? '0';
//   if (uid == '0') {
//     return '0';
//   } else {
//     var toReturn = db.collection('appUsers').doc(uid).collection('orderItems'); //this is where i get the object, it needs to be a list instead, and for that i need a fromMap function which means i would need a fromMap function for product
//     return toReturn; 
//   }
// });

