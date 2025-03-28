import 'package:internal_assessment_app/order/orderItem/order_item_model.dart';
import 'package:internal_assessment_app/product/data/product_model.dart';

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

  final List<OrderItem> orderItems;
  final double totalPrice;
  late final double totalPriceAfterTaxes = _calculatePriceAfterTaxes(orderItems);


  Cart({required this.orderItems})
      : totalPrice = orderItems.fold(0, (sum, item) => sum + item.totalPrice);
}
