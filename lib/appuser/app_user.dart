import 'package:internal_assessment_app/order/orderItem/order_item_model.dart';

class AppUser {
  AppUser({required this.orderItems, required this.uid});

  final List<OrderItem> orderItems;
  final String uid;
  late String nip;
  late String adress;
}