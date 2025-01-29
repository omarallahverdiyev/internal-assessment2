import 'package:internal_assessment_app/order/orderItem/order_item_model.dart';
import 'package:internal_assessment_app/product/data/product_model.dart';
import 'package:uuid/uuid.dart';

class Cart {

  double _calculatePriceAfterTaxes (items) {
    double totalPriceAfterTaxes = 0;
    double priceAfterTaxes;
    for (var item in items) {
      if(item.product.title == ProductTitle.pieluchy) {
        priceAfterTaxes = item.totalPrice * 1.05;
      } else {
        priceAfterTaxes = item.totalPrice * 1.23;
      }
      totalPriceAfterTaxes += priceAfterTaxes;
    }
    return totalPriceAfterTaxes;
  }

  void _addItem(items, OrderItem item) {
    items.add(item);
  }

  final String cartId = const Uuid().v4();
  final List<OrderItem> items;
  final double totalPrice;
  late final double totalPriceAfterTaxes = _calculatePriceAfterTaxes(items);


  Cart({required this.items})
      : totalPrice = items.fold(0, (sum, item) => sum + item.totalPrice);
}
