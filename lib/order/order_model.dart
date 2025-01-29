import 'package:internal_assessment_app/order/orderItem/order_item_model.dart';

class Order {
  final List<OrderItem> items;
  final double totalPrice;
  final DateTime dateOfOrder;
  PaymentStatus paymentStatus;
  DeliveryStatus deliveryStatus;
  String? deliveryNumber;

  Order({
    required this.items,
    required this.totalPrice,
    required this.dateOfOrder,
    required this.paymentStatus,
    required this.deliveryStatus,
    this.deliveryNumber
  });
}


enum PaymentStatus {
  pending('Oczekujące'),
  completed('Zakończone'),
  failed('Nieudane');

  final String polishPaymentStatus;
  const PaymentStatus(this.polishPaymentStatus);
}

enum DeliveryStatus {
  ordered('Zamówione'),
  fulfilled('Zrealizowane'),
  shipping('W dostawie'),
  delivered('Dostarczone');

  final String polishDeliveryStatus;
  const DeliveryStatus(this.polishDeliveryStatus);
}