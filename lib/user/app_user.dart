import 'package:firebase_auth/firebase_auth.dart';
import 'package:internal_assessment_app/order/order_model.dart';

class AppUser {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final String addressDetails;
  final String invoiceDetails;
  final List<Order> orders;

  AppUser({
    required this.addressDetails,
    required this.invoiceDetails,
    required this.orders,
  });
}