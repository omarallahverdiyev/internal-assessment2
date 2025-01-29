import 'package:internal_assessment_app/buyer/domain/cart.dart';

class AppUser {
  AppUser({required this.cart, required this.uid}) : cartId = cart.cartId;

  final String cartId;
  final Cart cart;
  final String uid;
  late String nip;
  late String adress;
}