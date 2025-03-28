import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internal_assessment_app/order/orderItem/order_item_model.dart';
import 'package:uuid/uuid.dart';

class Order {
  final List<OrderItem> items;
  final double totalPrice;
  final double totalPriceAfterTaxes;
  final DateTime dateOfOrder;
  PaymentStatus paymentStatus;
  DeliveryStatus deliveryStatus;
  String? deliveryNumber;
  final String addressLine1;
  final String? addressLine2;
  final String phoneNumber;
  final String zipCode;
  final String city;
  final String nip;
  final String uid;
  final int orderNumber;
  final String key;

  Order(
      {required this.items,
      required this.totalPrice,
      required this.totalPriceAfterTaxes,
      required this.dateOfOrder,
      required this.paymentStatus,
      required this.deliveryStatus,
      this.deliveryNumber,
      required this.addressLine1,
      this.addressLine2,
      required this.phoneNumber,
      required this.zipCode,
      required this.city,
      required this.nip,
      required this.uid,
      required this.orderNumber,
      String? key})
      : key = key ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((item) => item.toMap()).toList(),
      'totalPrice': totalPrice,
      'totalPriceAfterTaxes': totalPriceAfterTaxes,
      'dateOfOrder': Timestamp.fromDate(dateOfOrder),
      'paymentStatus': paymentStatus.name,
      'deliveryStatus': deliveryStatus.name,
      'deliveryNumber': deliveryNumber,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'phoneNumber': phoneNumber,
      'zipCode': zipCode,
      'city': city,
      'nip': nip,
      'uid': uid,
      'orderNumber': orderNumber,
      'key': key
    };
  }

  static Future<Order> fromMap(Map<String, dynamic> map) async {
    final itemsFutures = (map['items'] as List<dynamic>?)
            ?.map((x) => OrderItem.fromMap(x as Map<String, dynamic>))
            .toList() ??
        [];
        final items = await Future.wait(itemsFutures);
    return Order(
        items: items,
        totalPrice: map['totalPrice'],
        totalPriceAfterTaxes: map['totalPriceAfterTaxes'],
        dateOfOrder: map['dateOfOrder'].toDate(),
        paymentStatus: PaymentStatus.values.byName(map['paymentStatus']),
        deliveryStatus: DeliveryStatus.values.byName(map['deliveryStatus']),
        deliveryNumber: map['deliveryNumber'],
        addressLine1: map['addressLine1'],
        addressLine2: map['addressLine2'],
        phoneNumber: map['phoneNumber'],
        zipCode: map['zipCode'],
        city: map['city'],
        nip: map['nip'],
        uid: map['uid'],
        orderNumber: map['orderNumber'],
        key: map['key']);
  }
}

enum PaymentStatus {
  pending('Oczekujące'),
  completed('Zakończone'),
  failed('Nieudane'),
  other('Inny');

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
