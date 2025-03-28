import 'package:flutter/material.dart';
import 'package:internal_assessment_app/order/order_model.dart';
import 'package:internal_assessment_app/seller/list_of_orderitems.dart';

class OrderDetailsBuyer extends StatefulWidget {
  const OrderDetailsBuyer({super.key, required this.order});

  final Order order;

  @override
  State<OrderDetailsBuyer> createState() => _OrderDetailsBuyerState();
}

class _OrderDetailsBuyerState extends State<OrderDetailsBuyer> {
  int selectedIndexPayment = 0;
  int selectedIndexStatus = 0;

  @override
  void initState() {
    super.initState();
    if (widget.order.paymentStatus == PaymentStatus.pending) {
      selectedIndexPayment = 0;
    } else if (widget.order.paymentStatus == PaymentStatus.completed) {
      selectedIndexPayment = 1;
    } else if (widget.order.paymentStatus == PaymentStatus.failed) {
      selectedIndexPayment = 2;
    } else if (widget.order.paymentStatus == PaymentStatus.other) {
      selectedIndexPayment = 3;
    }
    
    if (widget.order.deliveryStatus == DeliveryStatus.ordered) {
      selectedIndexStatus = 0;
    } else if (widget.order.deliveryStatus == DeliveryStatus.fulfilled) {
      selectedIndexStatus = 1;
    } else if (widget.order.deliveryStatus == DeliveryStatus.shipping) {
      selectedIndexStatus = 2;
    } else if (widget.order.deliveryStatus == DeliveryStatus.delivered) {
      selectedIndexStatus = 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.order.addressLine1 == "Pickup"
                  ? const Text("Pickup")
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.order.addressLine1),
                        widget.order.addressLine2 == null
                            ? const Text('No address line 2')
                            : Text(widget.order.addressLine2!),
                        Text("${widget.order.city}, ${widget.order.city} ${widget.order.zipCode}"),
                        Text("NIP: ${widget.order.nip}"),
                        Text("Numer Telefonu: ${widget.order.phoneNumber}"),
                        Text("Status: ${widget.order.deliveryStatus.polishDeliveryStatus}"),
                      ],
                    ),
            ),
          ),
          Expanded(child: ListOfOrderitems(order: widget.order)),
        ],
      ),
    );
  }
}